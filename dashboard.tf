resource "dynatrace_document" "modern_trial_dashboard" {
  name = "[CapMon] Terraform Modern Dashboard"
  type = "dashboard" # This tells Dynatrace it's a dashboard, not a notebook
  content = jsonencode({
    version   = 1
    variables = []
    tiles = {
      "1" = {
        type    = "markdown"
        content = "## Managed by Terraform\nThis is a modern 2026 dashboard."
      }
      "2" = {
        type          = "data"
        title         = "Host CPU Usage"
        query         = "fetch builtin:host.cpu.usage | summarize avg(value)"
        visualization = "lineChart"
      }
    }
    layouts = {
      "1" = { "x" : 0, "y" : 0, "w" : 24, "h" : 4 }
      "2" = { "x" : 0, "y" : 4, "w" : 12, "h" : 8 }
    }
  })
}
