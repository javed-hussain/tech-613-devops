## Setting Up a Custom VPC

### Target Design
- VPC: `10.0.0.0/16`
- Public subnet: `10.0.2.0/24` in AZ a → app VM
- Private subnet: `10.0.3.0/24` in AZ b → DB VM
- Internet Gateway → HTTP reaches the app; SSH is not allowed from the internet
- Private subnet → no route to the Internet Gateway

### 1. Create the VPC
1. Open the VPC console → Your VPCs → Create VPC.
2. Choose **VPC only**.
3. Name it.
4. set the IPv4 CIDR block: `10.0.0.0/16`.
5. no ipv6 default tnenancy and no encryption control
6. Choose Create VPC.
- `/16` gives 65,536 addresses to divide into subnets.

### 2. Create the Subnets
1. VPC console → Subnets → Create subnet.
2. Select the vpc.
3. Public subnet:
   - name it, set the AZ and CIDR block
4. Private subnet:
   - do the same
- Each `/24` gives 256 addresses; AWS reserves 5, so 251 are usable.
- Subnet ranges must sit inside the VPC range and must not overlap.

### 3. Create and Attach an Internet Gateway
1. VPC console → Internet gateways → Create internet gateway.
2. Name it.
3. Actions → Attach to VPC → select the vpc.
- The gateway alone does nothing until a route table points to it.

### 4. Create the Route Tables
Public route table:
1. Route tables → Create route table → name it and attach it to the VPC .
2. Routes → Edit routes → add destination `0.0.0.0/0`, target internet gateway.
3. Subnet associations → associate it with the specified subnet.

Private route table:
1. Create `private-rt` in `custom-vpc`.
2. Do not add a route to the Internet Gateway.
3. Subnet associations → associate `private-subnet`.
- A subnet is public because its route table has a route to the Internet Gateway. [278]
- The `local` route is added automatically, so the app can reach the DB inside the VPC.

### 5. Enable Public IPs on the Public Subnet
1. Subnets → select `public-subnet`.
2. Actions → Edit subnet settings.
3. Enable **auto-assign public IPv4 address**.
- Without a public IP, the app VM can't be reached directly from the internet.
- This can be done when launching an instance anyways

### 6. Create the Security Groups
Need to create security groups for our VPC

App security group (`app-sg`):
- Inbound HTTP `80` from `0.0.0.0/0`.
- No SSH from the internet, as in the diagram. Use EC2 Instance Connect or a restricted source if you need access.
- for now we will leave ssh on from internet

DB security group :
- Inbound TCP `27017` with the source set to public subnet CIDR or sg.
- Don't use `0.0.0.0/0`.
- Using the security group as the source also covers new ASG instances.

### 7. Launch the Instances
- App VM or ASG → `public-subnet`, `app-sg`.
- DB VM → `private-subnet`, `db-sg`, with no public IP.
- App connection string: `mongodb://<DB-private-IP>:27017/<dbname>`.
- MongoDB must listen on its private IP, not just `127.0.0.1`.

### 8. Test
- Open the app's public address in a browser → the site loads.
- A database action works → the app can reach the DB.
- The DB has no public IP and no internet route.

### Request Flow
Internet → Internet Gateway → public route table → app VM → private network → DB VM

### Things to Know
- A private DB can't download packages unless you add a NAT Gateway, which has ongoing cost. [285]
- An ASG needs subnets in at least two AZs for resilience.
- An Application Load Balancer needs subnets in two AZs.
- **Public subnet = has a route to the Internet Gateway; private subnet = does not.**