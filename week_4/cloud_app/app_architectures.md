# Architectures: Monolith vs n-Tier vs microservices

Monolith, 2-tier, n-tier, and microservices describe different ways to organise an application. The key distinction is that tier usually means a physically separate deployment unit, while layer means a logical separation of code responsibilities; a monolith can still have many internal layers.

| Architecture  | What it means                                                                             | Typical structure                                       | Main advantage                                                       | Main drawback                                                                                             |
| :-: | :-: | :-: | :-: | :-:|
|Monolith| Entire application is one codebase and one deployable unit| UI, business logic, data access all bundled together| Simple to build, test, deploy, and debug | Must deploy/scale the whole app together; tight coupling grows with size|
| 2-tier| Client directly communicates with a server/database | Client/UI tier + database/server tier| Simple client-server model| Business logic may sit in the client or database, making security, reuse, and maintenance harder  |
| N-tier | Application is split into multiple tiers, commonly presentation, business logic, and data | Browser/API → application/business tier → database tier | Separation of concerns; tiers can sometimes be scaled separately | More deployment and network complexity than a monolith|
| Microservices | Application is split into small, independently deployable services by business capability | e.g. auth, orders, payments, notifications services | Independent deployment, scaling, fault isolation, and team ownership | Much higher operational complexity: networking, monitoring, data consistency, DevOps       |

## Monolith

A monolith puts all functionality in one application: one repository, one build, and usually one deployment. Typically contains UI, business logic, data access layer, database

- Good for simple small scale apps - simple deployment, no complex inter tier complexity
- Weakness appears at scale - single point of failure - changes to one part may require entire system redoployment - harder for large teams to work on one codebase


## 2-tier

A 2-tier architecture has two major deployment tiers: a client and a server/database. A basic example is a desktop application that directly queries a database, or an early client-server system.

- simple architecture, fewer network calls
- still a weak seperation of concerns, poor scalability, couples client and database hard to centeralise business rules


## n-tier

Means many tiers - application is divided into seperate responsibilities such as presentation tier, data tier etc

- clear seperation of concerns:, easier to mantain since there is seperation, tiers can be scaled independantly, better security
- complexity increase - more infastructure, config and deployment work - latency between tiers

## Microservices

Microservices split the system into separate services, each owning a business capability and often its own database. Services communicate through APIs, message queues, or events rather than direct in-process function calls.
- services can be developed deployed and scaled independently, failures in one service can be isolated, can scale individual services
- much higher operational complexity, data consistency is harder, end to end tests are harder, distributed system problems appear (timeouts, retries, network failures)
