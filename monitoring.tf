#log analytics,AMA, DCR
resource "azurerm_log_analytics_workspace" "soc_workspace" {
  name                = "SOC-Workspace"
  location            = azurerm_resource_group.yousif_soc_lab.location
  resource_group_name = azurerm_resource_group.yousif_soc_lab.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_virtual_machine_extension" "AMA" {
  name                      = "AMA"
  virtual_machine_id        = azurerm_windows_virtual_machine.Cloud_VM.id
  publisher                 = "Microsoft.Azure.Monitor"
  type                      = "AzureMonitorWindowsAgent"
  type_handler_version      = "1.0" #this is the version of the extention package that azure has to install
  automatic_upgrade_enabled = true
}

resource "azurerm_monitor_data_collection_rule" "soc_dcr" {
  name                = "soc_dcr"
  resource_group_name = azurerm_resource_group.yousif_soc_lab.name
  location            = azurerm_resource_group.yousif_soc_lab.location
  kind                = "Windows"

  data_sources {
    windows_event_log {
      name    = "windows-security-events"
      streams = ["Microsoft-Event"]

      x_path_queries = [
        "Security!*[System[*]]"
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
    streams      = ["Microsoft-Event"]
    destinations = ["soc-workspace-destination"]
  }
}

resource "azurerm_monitor_data_collection_rule_association" "soc_dcr_association" {
  name                    = "soc_dcr_association"
  target_resource_id      = azurerm_windows_virtual_machine.Cloud_VM.id
  data_collection_rule_id = azurerm_monitor_data_collection_rule.soc_dcr.id
}