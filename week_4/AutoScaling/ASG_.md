## Set Up EC2 Auto Scaling in the AWS Console

### 1. Create a Custom AMI

### 2. Create a Launch Template
1. In EC2, open Instances → Launch Templates.
2. Choose Create launch template.
3. Enter a name, e.g. `app-launch-template`.
4. Select the Auto Scaling guidance checkbox.
5. Under Application and OS Images:
   - Choose My AMIs.
   - Select your custom AMI.
6. Select an instance type compatible with the AMI.
7. Select a key pair if you need SSH access.
8. Under Network settings:
   - Leave the subnet unspecified; select subnets in the Auto Scaling group.
   - Select security groups appropriate for your application and VPC.
9. Review the storage settings.
10. Choose Create launch template.
11. To Test click on the LT and actions and press launch instance from template

### 3. Create the Auto Scaling Group
1. Open Auto Scaling → Auto Scaling Groups.
2. Choose Create Auto Scaling group.
3. Enter a name, e.g. `app-asg`.
4. Select `app-launch-template`.
5. Select the launch template version → choose Next.
6. On Choose instance launch options:
   - Select your VPC.
   - pick availability-zones and subnets.
   - pick distribution
7. Choose Next.

### Load Balancing and health Check
1. On Integrate with other services:
   - create a load balancer:
     - application load balancer (because our app is served by HTTP), name it
     - load balancer scheme will be internet facing (we are balancing internet traffic not internal traffic)
     - subnets set from ASG - create a new target group just name it
   - If using an existing application load balancer, attach its target group instead.
2.  Review the health check settings (elastic load balancing) → choose Next.

### 4. Set the Group Size to 2
On Configure group size and scaling:
- set Desired capacity = 2 → initially launches two instances.
- set Minimum capacity = 2 → does not scale below two instances.
- set Maximum capacity = 4 → can scale out to four instances.

### 5. Configure Scaling Rules
Under Automatic scaling:

1. Select Target tracking scaling policy.
2. Enter a policy name
3. Select Average CPU utilization as the metric.
4. Set Target value.
5. Set instance warmup to the time your application needs to become ready.
6. Leave scale-in enabled.
7. Choose Next.

- AWS adjusts instance capacity to keep average CPU utilisation near 50%.
- Sustained higher demand → adds instances, up to four.
- Lower demand → removes instances, but never below two.
- This is a target-tracking policy, not an immediate “CPU > 50% → add one” rule.

### 6. Review and Create
1. Add notifications if required → choose Next.
2. Add tags if required → choose Next.
3. Review the launch template, networking, capacity and scaling policy.
4. Choose Create Auto Scaling group.

### 7. Check the Group
1. Select `app-asg` in Auto Scaling Groups.
2. Open Activity → check that instance launches succeed.
3. Open Instance management → check for two InService instances.
4. Open Automatic scaling → check that the scaling policy appears.
5. Open EC2 → Instances to view the two new instances.
6. find the load balancer and click the URL should take you to the app

### CLean up
- terminate ASG - then load balancer - then target group
