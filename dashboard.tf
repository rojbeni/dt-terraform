resource "dynatrace_document" "modern_trial_dashboard" {
  name = "General Dashboard"
  type = "dashboard"
  content = jsonencode({
    version   = 1
    variables = []
    tiles = {
      "1" = {
        type    = "markdown"
        content = "## General Dashboard"
      }
      "2" = {
        type          = "data"
        title         = "Host CPU Usage"
        query         = "timeseries avg(dt.host.cpu.usage), by:{dt.entity.host}"
        visualization = "lineChart"
      }
    }
    layouts = {
      "1" = { "x" : 0, "y" : 0, "w" : 24, "h" : 4 }
      "2" = { "x" : 0, "y" : 4, "w" : 12, "h" : 8 }
    }
  })
}
