http_listener {
name = "appgw_list_01"
frontend_ip_configuration_name = "test-appgwPIP-smh"
frontend_port_name = "port_80"
protocol = "Http"
firewall_policy_id = azurerm_web_application_firewall_policy.WAF01.id

}
http_listener {
name = "appgw_list_02"
frontend_ip_configuration_name = "test-appgwPIP-smh"
frontend_port_name = "port_81"
protocol = "Http"
#firewall_policy_id = azurerm_web_application_firewall_policy.WAF01.id
}
http_listener {
name = "appgw_list_03"
frontend_ip_configuration_name = "test-appgwPIP-smh"
frontend_port_name = "port_82"
protocol = "Http"
#comment1
