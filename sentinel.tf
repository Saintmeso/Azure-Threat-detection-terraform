#Microsoft Sentinel Configuration

resource "azurerm_sentinel_log_analytics_workspace_onboarding" "sentinel" {
  workspace_id = azurerm_log_analytics_workspace.soc_workspace.id
}
