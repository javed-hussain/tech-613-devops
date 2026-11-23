# Week 5 cheatsheet: AWS networking, storage, and monitoring

- **VPC:** a VPC is an isolated network. Subnets divide it; route tables direct traffic. An Internet Gateway enables public internet routes; a NAT Gateway lets private subnet resources initiate outbound internet connections.
- **Security groups:** stateful instance-level firewalls. Allow only required inbound ports and trusted sources; outbound rules also affect connectivity.
- **S3:** object storage uses buckets and object keys. Apply least privilege, choose appropriate access settings, and use AWS CLI or Boto3 for automation.
- **Monitoring:** collect metrics and logs, build dashboards, and use alarms to detect thresholds or missing data. Notifications can be sent through SNS.
- **Performance testing:** load testing measures behavior under traffic; watch latency, throughput, and errors, and avoid confusing a short test with production capacity.

See [VPC notes](../Week_5/VPC/VPC.md), [S3 notes](../Week_5/S3/S3.md), and [monitoring](../Week_5/Monitoring/monitoring.md).
