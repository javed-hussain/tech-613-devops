# What is Kubernetes?

## What is Kubernetes?

- Kubernetes, also called **K8s**, is an open-source container orchestration platform.
- It automates the deployment, scaling, and management of containerised applications.
- It is commonly used to run applications made from Docker containers.
- Instead of manually starting and managing containers, Kubernetes manages them automatically.


### Simple explanation

> Docker runs individual containers.    
> Kubernetes manages many containers across multiple machines.
> Kubernetes ensures applications stay available, scalable, and recover from failures.

## Benefits of Kubernetes

- **Automatic recovery:** If a container or Pod fails, Kubernetes restarts or replaces it.
- **Scaling:** Kubernetes can increase or decrease the number of application instances based on demand.
- **Load balancing:** Traffic is distributed across multiple copies of an application.
- **Rolling updates:** New application versions can be deployed without downtime.
- **Rollbacks:** If an update causes problems, Kubernetes can return to a previous version.
- **Self-healing:** Kubernetes monitors the health of containers and replaces unhealthy ones.
- **Efficient resource use:** Containers are scheduled across available machines.
- **Declarative configuration:** You describe the desired state using YAML, and Kubernetes maintains it.
- **Portability:** Applications can run consistently across local machines, cloud providers, and on-premises servers.



