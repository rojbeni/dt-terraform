resource "dynatrace_metric_events" "cpu_high_usage" {
  summary = "CPU usage above 50% for 5m"
  enabled = true

  query_definition {
    type        = "METRIC_KEY"
    metric_key  = "builtin:host.cpu.usage"
    aggregation = "AVG"
  }

  model_properties {
    type               = "STATIC_THRESHOLD"
    threshold          = 50
    alert_condition    = "ABOVE"
    violating_samples  = 3
    samples            = 5
    dealerting_samples = 5
    alert_on_no_data   = false
  }


  event_template {
    title       = "CPU usage above 50% for 5m"
    description = "CPU usage above 50% for 5m"
    event_type  = "CUSTOM_ALERT"
    davis_merge = true
  }
}

resource "dynatrace_alerting_profile" "notify_custom_alerts" {
  display_name = "Notify Custom CPU Alerts"

  event_type_filters {
    custom_event_filter {
      custom_title_filter {
        operator         = "CONTAINS"
        value            = "High CPU"
        case_insensitive = true
      }
    }
  }
}

resource "dynatrace_email_notification" "email_alerts" {
  name                   = "Email Alerts"
  active                 = true
  profile                = dynatrace_alerting_profile.notify_custom_alerts.id
  to                     = ["admin@example.com"]
  subject                = "Dynatrace Alert: {ProblemTitle}"
  body                   = "Problem description: {ProblemDetailsText}"
  notify_closed_problems = true
}

