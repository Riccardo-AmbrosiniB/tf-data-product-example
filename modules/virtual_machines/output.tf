output "vmPrivateIp" {
  value = azurerm_linux_virtual_machine.odm_demo.private_ip_address
}

output "vmPublicIp" {
  value = azurerm_linux_virtual_machine.odm_demo.private_ip_address
}
