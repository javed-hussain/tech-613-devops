# Cloud Concepts

## What is cloud computing?
Cloud computing is the _**on-demand**_ delivery of IT resources, such as servers, storage, databases, networking, and software, _**over the internet**_, usually with pay-as-you-go pricing. Instead of buying and maintaining your own physical servers, you rent the capacity you need from a provider such as AWS, Microsoft Azure, or Google Cloud.
* Often has a GUI
* Pay as you-go / pay for what you use
* global
* You can provision exactly the right type and size of computing resources you need
* You can access many resources, almost instantly
* Cloud provider owns and maintains the network and hardware 

### On Prem vs Cloud:
On-prem is short for on-premises: IT infrastructure that a company owns, houses, and manages in its own physical location, such as an office or private data centre. The organisation buys the servers, storage, networking equipment, and software licences, and its IT team is responsible for running, securing, updating, and repairing them.

![Images/cloud.png](../Images/cloud.png)


### Deployment models
A cloud deployment model describes where cloud infrastructure is hosted, who owns and controls it, and how it is accessed.

Simple deployment models use one environment and are easier to manage - single cloud environment
* Public Cloud:
  * Shared tenancy: Infrastructure is shared between many customers
  * typically pay as you go and quick to set up
* Private Cloud:
  * Sole tenancy: Dedicated infastructure used by one organisation offering more control and isolation - costs more
  * May be on prem or by a third party

Complex deployment models combine enviroments:
* Hybrid Cloud: private cloud + public cloud
* Multi-cloud: 2 or more public cloud providers such as AWS+Azure

### Cloud Service Types:
A cloud service type (also called a cloud service model) describes what a cloud provider supplies and how much of the underlying technology the customer must manage.

* IaaS (infastructure as a service): The provider supplies computing resources (hardware + basic networking) such as VMs, storage and networking, customer installs and manages the OS, application and data. Eg, AWS EC2 **Most Responsibility**
* PaaS (Platform as a service): The provider supplies a managed platform/environment for developing building and deploying/scaling applications without needing to manage the underlying hardware or OS. Customer focuses on code and data while the provider manages servers, OS, runtime and infastructure
* SaaS: Provider supplies a complete application that you can access over the internet (not ran locally): Customer normlly manages user accounts settings and data entered. example is gmail or microsoft 365 **Least responsibility**
* Faas: Function as a service: serverless cloud model where you upload an individual function and the cloud provider can execute them automatically in response to events or triggers

![cloud](../Images/cloud_models.webp)

## Advantages of cloud computing
* Cost Effecciency: little/no upfront cost/investment - we only pay what we use
* Scalability and elasticity: computing power, storage and users can be scaled up or down as demand changes
* Accessibility: cloud can be accessed from anywhere with an internet connection
* reliability and backup: most providers offer redundancy, backups and failovers between data centres
* Automatic Updates
* less maintanance - services are managed
* Faster deployment: new services apps or environments can be provisioned in minutes without requiring new hardware
* collaberation and integration: facilitates collabertion and experimentation (can see what other people in orginsation are doing)

## Potential Disadvantages
* Security and privacy risks: third party in charge of data raises concerns about unauthorised access, data isolation and compliance with privacy laws
* Internet Dependance:
* Less control: customer doesnt physically control servers or infra - depend on provider for maintanance and incident response
* Service outages
* Vendor lock-in: heavy use of a providers ervices can make switching or exiting expensive and technically difficult
* Unexpected costs: pay as you go prices may surge if usage increased unexpectedly or if services are poorly managed

## CapEx and OpEx

CapEx and OpEx are 2 ways an organisation pays for IT.

* CapEx — Capital Expenditure: money spent upfront to buy or build long-term assets, such as physical servers, networking equipment, data-centre space, or owned software. These assets are recorded on the balance sheet and their value is depreciated over several years.
  * For example: organisations purchasing servers for on prem data services - purchasing network hardware and buying software licenses
* OpEx — Operational Expenditure: money spent on day-to-day operations, usually as a recurring or pay-as-you-go cost. In cloud computing, you pay for the compute, storage, networking, and software services you actually consume, rather than buying the underlying hardware.
  * Examples: Monthly AWS, Azure, or Google Cloud bills
  * Pay-as-you-go virtual machine costs
  * Storage charges based on gigabytes used
  * Microsoft 365 or SaaS subscription payments
  * Cloud example: Instead of buying a server, a company uses AWS EC2 and pays only for the compute time it uses; when demand falls, it can stop or resize the instance.

#### Which one do most businesses prefer and why?
* Most businesses now prefer OpEx-based cloud spending because it avoids large upfront hardware purchases, scales with demand, and makes costs more predictable in the short term. However, cloud is not always cheaper—for large, stable, predictable workloads, owning infrastructure (CapEx) can cost less over time.
  * Unpredictable or growing demand: cloud/OpEx often wins.
  * Stable, predictable, high utilisation: on-premises/CapEx may win.



- Is cloud always cheaper:
  - Cloud can be cheaper when usage is variable, uncertain, or needs to scale quickly, because you avoid buying capacity for peak demand. But it can become expensive when workloads are large, constant, and predictable, since you keep “renting” capacity every month instead of owning assets
  - Real world case studies:
    - Netflix runs in AWS - reported 75% improved preformance and 29% cost saving - because OpEx cloud suits netlfixes highly variable global traffic
    - Dropbox : moved from AWS S3 to on prem - saved 75 mil in 2 years after its CapEx spending of 53 mil

## guaranteed levels of service
A guarenteed level of service: the minimum standard of performance or availability that a cloud provider formally promises to deliver to a customer. Commonly specifies:
- uptime/availability
- connectivity
- response time
- support and incident handling
- remedies (what the customer receives if promise is not met)

**_SLI_** Service Level Indictor: An SLI is a measurable metric showing how well a service is actually performing. It is usually expressed as a ratio of good events to total events, such as successful requests divided by all requests

**_SLO_** Service Level Objective: An SLO is the internal target for an SLI over a period of time. It defines the level of reliability or performance the team aims to provide.
eg: 99.9% of requests must succeed each month

**_SLA_** Service Level Agreement: An SLA is a formal agreement between a provider and a customer that states the promised level of service and what happens if the provider misses it. In cloud services, missing an SLA often results in service credits or another financial remedy

### Cloud Market Share:
Current market share in the cloud computing space:
- The “Big Three” cloud providers are AWS, Microsoft Azure, and Google Cloud. 
- In Q2 2026, Synergy Research estimated global cloud infrastructure market share at AWS 28%, Microsoft Azure 20%, and Google Cloud 15%, with the three together accounting for about 63–67% of the market


#### What are each of the "Big Three" known for? What are their USPs or reasons for choosing them?
(USP: Unique Selling Proposition - main selling point that differenciates it from others)
- AWS: Broadest and most mature cloud ecosystem - best for organisations that need highly flexible service rich platform
- Microsoft Azure: Known for deep integration with microsoft enterprise stack - default choice for orginsations already using microsoft products
- GCP (coogle cloud): chosen for data-intensive and AI-first workloads - partricularly attractive to engineering-led companies - best fit for AI/ML teams, data heavy businesses


BONUS: What does the cloud certification path look like for each of the big three?
What path would you like to pursue and why?