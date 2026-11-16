# Alarms
An **alarm** monitors a condition and triggers a notification or automated action when a defined threshold is breached for a specified period.

## Creating a cloud watch alarm
A **CloudWatch alarm** monitors a metric, such as CPU utilisation, and triggers an action when it breaches a defined threshold over a specified period—for example, sending an email notification.

### Example

A CloudWatch alarm was created to monitor the EC2 instance’s CPU utilisation andsend an email notification when CPU usage remained above a defined threshold for
a set amount of time.

The alarm used the `CPUUtilization` metric from the `AWS/EC2` namespace. It was
configured to trigger if the average CPU utilisation was greater than 20% for
one one-minute period.

### Alarm configuration

| Setting | Value |
|---|---|
| Metric | `CPUUtilization` |
| Namespace | `AWS/EC2` |
| Statistic | Average |
| Period | 1 minute |
| Threshold | Greater than 20% |
| Datapoints to alarm | 1 out of 1 |
| Alarm state | In alarm |
| Notification | SNS email topic |

This means the alarm triggers if average CPU utilisation exceeds 20% over one one-minute evaluation period

### Create the SNS email subscription
- SNS (Simple Notification Service): An AWS messaging service that delivers messages published to a topic to its subscribers, such as email recipients or other AWS services.
- An SNS topic is a named communication channel that receives messages from publishers, such as CloudWatch alarms, and distributes them to its subscribers, such as email recipients.
- SNS subscription: A connection between an SNS topic and a destination, such as an email address, that receives messages from the topic. Email subscriptions must be confirmed before receiving notifications.


1. Opened the **Amazon SNS** console.
2. Selected **Topics → Create topic**.
3. Chose **Standard** as the topic type.
4. Named the topic.
5. Created the topic.
6. Selected **Create subscription**.
7. Set **Protocol** to `Email`.
8. Entered the email address as the endpoint.
9. Created the subscription.
10. Opened the AWS subscription confirmation email.
11. Selected **Confirm subscription**.
12. Checked that the subscription status changed to **Confirmed**.

The email subscription had to be confirmed before CloudWatch could send alarm
notifications.

### Create the CloudWatch alarm

1. Opened the **CloudWatch** console.
2. Went to **Alarms → All alarms → Create alarm**.
3. Selected **Select metric**.
4. Chose **EC2 → Per-Instance Metrics**.
5. Found the target EC2 instance (use instance ID) and selected `CPUUtilization`.
6. Selected **Select metric**.
7. Set the statistic to **Average**.
8. Set the time period.
9. Set the threshold type to **Static**.
10. Set the condition to **CPUUtilization > 20**.
11. Set **Datapoints to alarm** to **1 out of 1**.
12. Selected **Next**.
13. Under notification, selected **In alarm**.
14. Selected the created SNS topic.
15. Name the alarm .
16. Create the alarm.

CloudWatch metric alarms watch a selected metric and perform an action, such as sending an SNS notification, when the metric breaches the configured threshold.

### Screenshots

![Subscription confirmed](/Images/alarm.png)

![Email notification received](/Images/alarmemail.png)

