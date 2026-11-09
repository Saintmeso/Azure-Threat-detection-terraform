resource "azurerm_monitor_data_collection_rule" "soc_securityevent_dcr" {
  name                = "SOC-SecurityEvent-DCR"
  resource_group_name = azurerm_resource_group.yousif_soc_lab.name
  location            = azurerm_resource_group.yousif_soc_lab.location
  kind                = "Windows"

  data_sources {
    windows_event_log {
      name    = "windows-security-events"
      streams = ["Microsoft-SecurityEvent"]

      x_path_queries = [
        "Security!*[System[(EventID=4624) or (EventID=4625) or (EventID=4672)]]"
      ]

    }
  }
  destinations {
    log_analytics {
      name                  = "soc-workspace-destination"
      workspace_resource_id = azurerm_log_analytics_workspace.soc_workspace.id
    }
  }

  data_flow {
    streams      = ["Microsoft-SecurityEvent"]
    destinations = ["soc-workspace-destination"]
  }
}

resource "azurerm_monitor_data_collection_rule_association" "soc_securityevent_dcr_association" {
  name                    = "soc_securityevent_dcr_association"
  target_resource_id      = azurerm_windows_virtual_machine.Cloud_VM.id
  data_collection_rule_id = azurerm_monitor_data_collection_rule.soc_securityevent_dcr.id
}