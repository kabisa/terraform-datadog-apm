
![Datadog](https://imgix.datadoghq.com/img/about/presskit/logo-v/dd_vertical_purple.png)

[//]: # (This file is generated. Do not edit)

# Terraform module for Datadog Apm

Monitors:
* [Terraform module for Datadog Apm](#terraform-module-for-datadog-apm)
  * [Request Rate](#request-rate)
  * [Error Percentage](#error-percentage)
  * [Request Rate Anomaly](#request-rate-anomaly)
  * [Latency P95](#latency-p95)
  * [Apdex](#apdex)
  * [Errors Slo](#errors-slo)
  * [Latency](#latency)
  * [Module Variables](#module-variables)

# Getting started
[pre-commit](http://pre-commit.com/) was used to do Terraform linting and validating.

Steps:
   - Install [pre-commit](http://pre-commit.com/). E.g. `brew install pre-commit`.
   - Run `pre-commit install` in this repo. (Every time you cloud a repo with pre-commit enabled you will need to run the pre-commit install command)
   - That’s it! Now every time you commit a code change (`.tf` file), the hooks in the `hooks:` config `.pre-commit-config.yaml` will execute.

## Request Rate

Number of requests per second

Query:
```terraform
avg(${var.request_rate_evaluation_period}):sum:trace.servlet.request.hits{${local.request_rate_filter}}.as_rate() > ${var.request_rate_critical}
```

| variable                       | default                       | required | description                      |
|--------------------------------|-------------------------------|----------|----------------------------------|
| request_rate_enabled           | True                          | No       |                                  |
| request_rate_warning           | null                          | No       |                                  |
| request_rate_critical          |                               | Yes      |                                  |
| request_rate_evaluation_period | last_30m                      | No       |                                  |
| request_rate_note              | ""                            | No       |                                  |
| request_rate_docs              | Number of requests per second | No       |                                  |
| request_rate_filter_override   | ""                            | No       |                                  |
| request_rate_alerting_enabled  | True                          | No       |                                  |
| request_rate_priority          | 3                             | No       | Number from 1 (high) to 5 (low). |


## Error Percentage

Query:
```terraform
avg(${var.error_percentage_evaluation_period}):100 * (sum:trace.${var.trace_span_name}.request.errors{${local.error_percentage_filter}}.as_rate() / sum:trace.${var.trace_span_name}.request.hits{${local.error_percentage_filter}}.as_rate() ) > ${var.error_percentage_critical}
```

| variable                           | default  | required | description                      |
|------------------------------------|----------|----------|----------------------------------|
| error_percentage_enabled           | True     | No       |                                  |
| error_percentage_warning           | 0.01     | No       |                                  |
| error_percentage_critical          | 0.05     | No       |                                  |
| error_percentage_evaluation_period | last_10m | No       |                                  |
| error_percentage_note              | ""       | No       |                                  |
| error_percentage_docs              | ""       | No       |                                  |
| error_percentage_filter_override   | ""       | No       |                                  |
| error_percentage_alerting_enabled  | True     | No       |                                  |
| error_percentage_priority          | 3        | No       | Number from 1 (high) to 5 (low). |


## Request Rate Anomaly

Request rate anomaly detection is performed by taking the standard deviation and put a band around it. If X percentage of the requests are outside that band, an alert is raised. https://www.datadoghq.com/blog/introducing-anomaly-detection-datadog/

Query:
```terraform
avg(${var.request_rate_anomaly_evaluation_period}):anomalies(sum:trace.${var.trace_span_name}.request.hits{${local.request_rate_anomaly_filter}}.as_rate(), 'agile', ${var.request_rate_anomaly_std_dev_count}, direction='both', alert_window='${var.request_rate_anomaly_trigger_window}', interval=60, count_default_zero='false', seasonality='weekly') > ${var.request_rate_anomaly_critical}
```

| variable                               | default                                  | required | description                                                                       |
|----------------------------------------|------------------------------------------|----------|-----------------------------------------------------------------------------------|
| request_rate_anomaly_enabled           | False                                    | No       |                                                                                   |
| request_rate_anomaly_warning           | 0.15                                     | No       |                                                                                   |
| request_rate_anomaly_critical          | 0.2                                      | No       |                                                                                   |
| request_rate_anomaly_evaluation_period | last_30m                                 | No       |                                                                                   |
| request_rate_anomaly_trigger_window    | last_30m                                 | No       |                                                                                   |
| request_rate_anomaly_recovery_window   | last_15m                                 | No       |                                                                                   |
| request_rate_anomaly_note              | ""                                       | No       |                                                                                   |
| request_rate_anomaly_docs              | Request rate anomaly detection is performed by taking the standard deviation and put a band around it. If X percentage of the requests are outside that band, an alert is raised. https://www.datadoghq.com/blog/introducing-anomaly-detection-datadog/ | No       |                                                                                   |
| request_rate_anomaly_filter_override   | ""                                       | No       |                                                                                   |
| request_rate_anomaly_alerting_enabled  | True                                     | No       |                                                                                   |
| request_rate_anomaly_priority          | 3                                        | No       | Number from 1 (high) to 5 (low).                                                  |
| request_rate_anomaly_std_dev_count     | 5                                        | No       | Request rate anomaly, how many standard deviations are needed to trigger an alert |


## Latency P95

Query:
```terraform
avg(${var.latency_p95_evaluation_period}):p95:trace.${var.trace_span_name}.request{${local.latency_p95_filter}} > ${var.latency_p95_critical}
```

| variable                      | default  | required | description                      |
|-------------------------------|----------|----------|----------------------------------|
| latency_p95_enabled           | True     | No       |                                  |
| latency_p95_warning           | 0.9      | No       |                                  |
| latency_p95_critical          | 1.3      | No       |                                  |
| latency_p95_evaluation_period | last_10m | No       |                                  |
| latency_p95_note              | ""       | No       |                                  |
| latency_p95_docs              | ""       | No       |                                  |
| latency_p95_filter_override   | ""       | No       |                                  |
| latency_p95_alerting_enabled  | True     | No       |                                  |
| latency_p95_priority          | 3        | No       | Number from 1 (high) to 5 (low). |


## Apdex

    Apdex is a measure of response time based against a set threshold. It measures the ratio of satisfactory response times to unsatisfactory response times. The response time is measured from an asset request to completed delivery back to the requestor. For more see: https://en.wikipedia.org/wiki/Apdex#Apdex_method

Query:
```terraform
avg(${var.apdex_evaluation_period}):avg:trace.${var.trace_span_name}.request.apdex.by.service{${local.apdex_filter}} < ${var.apdex_critical}
```

| variable                | default                                  | required | description                      |
|-------------------------|------------------------------------------|----------|----------------------------------|
| apdex_enabled           | True                                     | No       |                                  |
| apdex_warning           | 0.9                                      | No       |                                  |
| apdex_critical          | 0.8                                      | No       |                                  |
| apdex_evaluation_period | last_10m                                 | No       |                                  |
| apdex_note              | ""                                       | No       |                                  |
| apdex_docs              | Apdex is a measure of response time based against a set threshold. It measures the ratio of satisfactory response times to unsatisfactory response times. The response time is measured from an asset request to completed delivery back to the requestor. For more see: https://en.wikipedia.org/wiki/Apdex#Apdex_method | No       |                                  |
| apdex_filter_override   | ""                                       | No       |                                  |
| apdex_alerting_enabled  | True                                     | No       |                                  |
| apdex_priority          | 3                                        | No       | Number from 1 (high) to 5 (low). |


## Errors Slo

| variable                   | default  | required | description                      |
|----------------------------|----------|----------|----------------------------------|
| error_slo_enabled          | True     | No       |                                  |
| error_slo_warning          | 0.01     | No       |                                  |
| error_slo_critical         | 0.05     | No       |                                  |
| error_slo_timeframe        | 30d      | No       |                                  |
| error_slo_note             | ""       | No       |                                  |
| error_slo_docs             | ""       | No       |                                  |
| error_slo_filter_override  | ""       | No       |                                  |
| error_slo_alerting_enabled | True     | No       |                                  |
| error_slo_priority         | 2        | No       | Number from 1 (high) to 5 (low). |


## Latency

Query:
```terraform
avg(${var.latency_evaluation_period}):avg:trace.${var.trace_span_name}.request{${local.latency_filter}} > ${var.latency_critical}
```

| variable                  | default  | required | description                      |
|---------------------------|----------|----------|----------------------------------|
| latency_enabled           | True     | No       |                                  |
| latency_warning           | 0.3      | No       |                                  |
| latency_critical          | 0.5      | No       |                                  |
| latency_evaluation_period | last_10m | No       |                                  |
| latency_note              | ""       | No       |                                  |
| latency_docs              | ""       | No       |                                  |
| latency_filter_override   | ""       | No       |                                  |
| latency_alerting_enabled  | True     | No       |                                  |
| latency_priority          | 3        | No       | Number from 1 (high) to 5 (low). |


## Module Variables

| variable             | default  | required | description                                                                                          |
|----------------------|----------|----------|------------------------------------------------------------------------------------------------------|
| env                  |          | Yes      |                                                                                                      |
| alert_env            |          | Yes      |                                                                                                      |
| service              |          | Yes      |                                                                                                      |
| trace_span_name      | http     | No       | Traces contain a span name. Example:
  trace.<SPAN_NAME>.<METRIC_SUFFIX>
  trace.<SPAN_NAME>.<METRIC_SUFFIX>.<2ND_PRIM_TAG>_service

The name of the operation or span.name (examples: redis.command, pylons.request, rails.request, mysql.query
https://docs.datadoghq.com/tracing/guide/metrics_namespace/ |
| notification_channel |          | Yes      |                                                                                                      |
| additional_tags      | []       | No       |                                                                                                      |
| name_prefix          | ""       | No       |                                                                                                      |
| name_suffix          | ""       | No       |                                                                                                      |
| locked               | True     | No       |                                                                                                      |
| create_slo           | False    | No       |                                                                                                      |
| slo_warning          | 99.95    | No       |                                                                                                      |
| slo_critical         | 99.9     | No       |                                                                                                      |
| slo_timeframe        | 30d      | No       |                                                                                                      |
| slo_alerting_enabled | True     | No       |                                                                                                      |


