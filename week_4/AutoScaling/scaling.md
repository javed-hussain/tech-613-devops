# Autoscaling
- Automatically adjusts resources to match demand.
- Increased demand → add capacity to maintain performance.
- Decreased demand → remove capacity to reduce costs.
- **Vertical = bigger/smaller machines; horizontal = more/fewer machines.**
- Autoscaling automates capacity changes.

### Vertical Scaling (Up / Down)
- Changes the size of an existing VM.
- Scale up → increase CPU, memory or network capacity.
- Scale down → decrease resources.
- Example: move an application from a smaller VM to a larger VM.

### Horizontal Scaling (Out / In)
- Changes the number of VMs running an application.
- Scale out → add more instances.
- Scale in → remove instances.
- Usually creates identical copies of the application VM.

### AWS EC2 Auto Scaling
- Automatically adds or removes EC2 instances using horizontal scaling.
- Uses an Auto Scaling group with minimum and maximum capacity limits.
- Scaling policies control capacity changes in response to demand.

![asg](/Images/ASG.png)

#### Launch Template
- A reusable configuration for creating EC2 instances.
- Specifies the AMI, instance type, security groups and other launch settings.
- Ensures new instances use the same configuration.
- Does not launch or scale instances by itself.

#### Auto Scaling Group (ASG)
- Manages a collection of EC2 instances.
- Uses a launch template to create new instances.
- Maintains the desired number of instances and replaces unhealthy ones.
- Can add or remove instances automatically using scaling policies.

### Load Balancer
- The entry point visitors connect to.
- Has a DNS name used to access the website.
- Receives requests through a listener, e.g. HTTP on port 80.
- Forwards requests to healthy instances using a target group.

#### Target Groups
- A target group is a collection of destinations that a load balancer can send requests to. In your setup, those destinations—or “targets”—are the EC2 instances running your website.

#### Elastic Load Balancing Health Checks
- Check whether each instance’s application responds correctly.
- The load balancer periodically requests a configured path, e.g. `/health`.
- Repeated failures → instance marked unhealthy → normally stops receiving traffic.
- Enabling ELB health checks in the ASG allows it to replace unhealthy instances.
- Health check grace period → gives new instances time to start before the ASG acts on failed checks.
- EC2 health checks → is the instance running correctly?
- **ELB health checks → is the application responding correctly?**

#### Example
- Launch template → custom website AMI and chosen instance type.
- ASG → starts with 2 instances and scales between 2 and 4.
- Load balancer → distributes website requests across healthy instances.

Key Difference
- **Launch template = how to create instances; ASG = how many to run and manage.**
