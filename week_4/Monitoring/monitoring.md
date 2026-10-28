# Monitering
## Monitoring

Monitoring is the process of collecting and analysing data about an application and its underlying infrastructure, such as CPU load, memory usage, latency, and error rates. Collecting metrics alone is not enough: monitoring is effective only when the data improves visibility, triggers alerts, or leads to an automated response such as autoscaling.

### Monitoring Approaches: Worst → Best
Metrics ignored → Dashboard → Alarms → Autoscaling

| Approach | What happens | Limitation or outcome |
|---|---|---|
| Metrics collected but ignored | CPU load is monitored, but the data is not used. | The application may become overloaded and fail. |
| Dashboard | CPU load is displayed on a dashboard. | Someone must check it; problems may be missed. |
| Alarms and notifications | CPU load monitoring triggers alarms and sends notifications. | Someone is notified so they can respond. |
| Autoscaling | CPU load monitoring triggers automatic scaling. | Capacity scales out or in in response to load. |


![diagram](/Images/monitering.png)

### Monitoring on AWS
- monitoring tab in AWS instance dashboard - can enable detailed monitoring from this section
- We can create a cloudwatch dashboard directly from the instance page or through the cloudwatch service

#### What is cloud watch
AWS’s **monitoring** service for tracking resource usage, application performance, and operational health.

##### Main Features
- Metrics: Track numerical data, such as EC2 CPU utilisation.
- Logs: Collect and analyse application and system logs.
- Dashboards: Display metrics and logs in one place.
- Alarms: Monitor thresholds and trigger notifications or automated actions.

Example workflow: High EC2 CPU usage → CloudWatch alarm → Notification or Auto Scaling action.  
Purpose: Detect problems, troubleshoot issues, and automate responses.

![dashboard](/Images/dashboard.png)