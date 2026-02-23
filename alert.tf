resource "dynatrace_davis_anomaly_detectors" "cpu_high_usage" {
  title       = "High CPU usage"
  description = "High CPU usage"
  enabled     = true
  source      = "Terraform"

  analyzer {
    name = "dt.statistics.ui.anomaly_detection.StaticThresholdAnomalyDetectionAnalyzer"

    input {
      analyzer_input_field {
        key   = "query"
        value = "timeseries avg(dt.host.cpu.usage)"
      }
      analyzer_input_field {
        key   = "alertCondition"
        value = "ABOVE"
      }
      analyzer_input_field {
        key   = "threshold"
        value = "10"
      }
      analyzer_input_field {
        key   = "violatingSamples"
        value = "3"
      }
      analyzer_input_field {
        key   = "slidingWindow"
        value = "5"
      }
      analyzer_input_field {
        key   = "dealertingSamples"
        value = "5"
      }
    }
  }

  event_template {
    properties {
      property {
        key   = "event.name"
        value = "High CPU usage"
      }
      property {
        key   = "event.description"
        value = "The {metricname} value of {alert_condition} {threshold} was detected on {entityname}"
      }
      property {
        key   = "event.type"
        value = "CUSTOM_ALERT"
      }
    }
  }

  execution_settings {
    query_offset = 1
  }
}



resource "dynatrace_automation_workflow" "email_alerts_workflow" {
  title       = "Notify Custom CPU Alerts Workflow"
  description = "Triggered by CPU usage problem"

  trigger {
    event {
      active = true
      config {
        davis_problem {
          categories {
            custom = true
          }
        }
      }
    }
  }

  tasks {
    task {
      name        = "send_email"
      description = "Send email notification"
      action      = "dynatrace.email:send-email"
      active      = true
      position {
        x = 0
        y = 1
      }
      input = jsonencode({
        body    = "Problem description: {{event()['event.description']}}"
        subject = "Dynatrace Alert: {{ event()['event.name'] }}"
        to      = ["rojbenimohamed@gmail.com"]
      })
    }
  }
}
