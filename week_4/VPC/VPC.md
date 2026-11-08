# VPC — Virtual Private Cloud
- A VPC is your own logically isolated private network inside AWS.
- It provides the network in which resources such as EC2 instances, load balancers and databases communicate.
- You choose the network's IP address range and control how traffic moves within it and to the internet.
- Think of it as the network for your cloud infrastructure—not a server running your application.
- A custom VPC lets you design the network deliberately around your application, rather than starting with AWS’s ready-made public-subnet setup. It is not a more powerful type of VPC—the difference is its configuration and separation from other workloads.

### IP Addresses and CIDR Blocks
- An IP address identifies a network interface so traffic can reach it.
- Private IP → used for communication within private networks.
- Public IP → can be used for communication over the internet, subject to routing and security rules.
- A CIDR block defines a range of IP addresses.
- Example: `10.0.0.0/16` is a range from which the VPC's private addresses are allocated.
- The /16 defines the range for IP addresses - means the first 16 bits are locked
- IP adresses that start with 10 are private addresses

### Subnets
- A subnet is a smaller section of the VPC's IP address range.
- Example:
  - VPC: `10.0.0.0/16`
  - Subnet: `10.0.1.0/24`
- Each subnet belongs to one Availability Zone.
- An Availability Zone is an isolated location within an AWS Region.
- Using subnets across multiple zones helps avoid relying on one location.

### Public Subnet
- Has a route to an Internet Gateway.
- Commonly used for internet-facing load balancers.
- An EC2 instance needs more than a public subnet to be reachable from the internet:
  - A public IP address for direct IPv4 access.
  - Appropriate routing.
  - Security rules allowing the traffic.

### Private Subnet
- Has no direct route to an Internet Gateway.
- Commonly used for application servers and databases.
- Resources can still communicate privately with other resources in the VPC, subject to security rules.
- Example: an application instance connects to MongoDB using the database instance's private IP.

### Route Tables
- A route table contains rules describing where network traffic should go.
- Each subnet is associated with a route table.
- Each route has:
  - Destination → the address range traffic is trying to reach.
  - Target → where AWS should send that traffic next.
- Examples:
  - VPC address range → local communication within the VPC.
  - `0.0.0.0/0` → a default route for IPv4 destinations not matched by a more specific route.
- Route tables direct traffic; they do not replace firewall rules.

### Internet Gateway
- A component attached to the VPC that enables communication with the internet.
- A public subnet's route table directs internet-bound traffic to it.
- Attaching one does not automatically expose every resource in the VPC.

### NAT Gateway
- Lets private instances initiate connections to the internet.
- Example: an application server downloads software updates.
- Return traffic is allowed, but internet users cannot use it to initiate connections to those instances.
- For internet access, a public NAT Gateway is placed in a public subnet.

Private Instance → NAT Gateway → Internet Gateway → Internet

### Security Groups
- Virtual firewalls attached to resources such as EC2 instances.
- Inbound rules → control traffic entering the resource.
- Outbound rules → control traffic leaving the resource.
- Rules can allow a specific port from another security group.
- Example:
  - Load balancer → accepts website requests from visitors.
  - Application instances → accept website traffic from the load balancer.
  - MongoDB instance → accepts database traffic from the application instances.

### How This Fits Your Website
1. Visitors connect to the internet-facing load balancer.
2. The load balancer forwards requests to an application instance.
3. The application queries the separate MongoDB instance over the private network.
4. The application returns a response through the load balancer.

VPC
├── Public subnets
│   └── Internet-facing load balancer
└── Private subnets
    ├── Application instances managed by the ASG
    └── Separate MongoDB instance

- The database does not need to be directly accessible from the internet.
- The ASG manages application capacity; the VPC provides the network those instances use.

- **VPC = overall network; subnet = section of that network; route table = traffic directions; security group = access rules.**