# Week 4 cheatsheet: Cloud apps, MongoDB, and autoscaling

- **Cloud models:** distinguish IaaS, PaaS, and SaaS; cloud capacity is provisioned on demand, with costs and responsibility depending on the service model.
- **Architecture:** a reverse proxy receives client traffic and forwards it to backend services. Separate tiers/services to isolate responsibilities and scale them independently.
- **Deployments:** automate repeatable setup with scripts or user data; make services persist across shell sessions and restarts, and verify health after deployment.
- **MongoDB:** data is organized as databases, collections, and documents. Keep connection details in configuration/secrets and allow network access only where required.
- **Scaling:** vertical scaling changes instance size; horizontal scaling changes instance count. A load balancer distributes requests across healthy instances.
- **Auto Scaling Groups:** use a launch template and health checks; set minimum, desired, and maximum capacity, then define scaling policies. An AMI captures a configured machine image.

See [cloud concepts](../week_4/cloud_app/cloud_concepts.md) and [autoscaling](../week_4/AutoScaling/scaling.md).
