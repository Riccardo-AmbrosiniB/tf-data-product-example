terraform {
  required_providers {
    azuredevops = {
      source = "microsoft/azuredevops"
      version = ">=0.1.0"
    }
  }
  backend "azuredevops" {
    resource_group_name  = "quantyca-internal-giandomenico-avelluto"
    storage_account_name = "quantycaodmterraform"
    container_name       = "terraform-state"
    key                  = "odm/azuredevops/terraform.tfstate"
    }
}

provider "azuredevops" {}

data "azuredevops_project" "odm_project" {
  name = "OpenDataMesh"
}

resource "azuredevops_serviceendpoint_bitbucket" "bitbucket" {
  project_id            = data.azuredevops_project.odm_project.id
  username              = "giogiyeah"
  password              = "***"
  service_endpoint_name = "BitbucketServiceEndpoint"
  description           = "Managed by Terraform"
}

resource "azuredevops_build_definition" "odm-provisioner-terraform-demo-CI" {
  project_id = data.azuredevops_project.odm_project.id
  name       = "odm-provisioner-terraform-demo-CI"
  #path       = ""

  ci_trigger {
    use_yaml = true
  }

  repository {
    repo_type             = "Bitbucket"
    repo_id               = "quantyca/odm-plane-utility-provisionservice-terraform"
    branch_name           = "master"
    yml_path              = "azure-pipelines-CI.yml"
    service_connection_id = azuredevops_serviceendpoint_bitbucket.bitbucket.id
  }
}
