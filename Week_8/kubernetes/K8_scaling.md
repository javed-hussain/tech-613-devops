# Kubernetes Autoscaling

Autoscaling means Kubernetes adjusts capacity automatically as load changes, so you don't have to scale by hand. There are four main tools, and each one scales something different.

## Horizontal Pod Autoscaler (HPA)

HPA changes the **number of pods** in a Deployment, ReplicaSet or StatefulSet based on how busy they are, usually CPU or memory usage (custom metrics are also possible).

- When load goes up, it adds more pods. When load drops, it removes them.
- You set a minimum and maximum number of pods, and a target such as "keep average CPU around 70%".
- It is built into Kubernetes and configured with a Kubernetes resource (YAML).
- It needs the metrics-server running to read CPU and memory, and the pods need resource requests set, because usage is measured as a percentage of the request.
- It works best for stateless apps that can run as many identical copies, like our web app.

## Cluster Autoscaler

The Cluster Autoscaler changes the **number of nodes** (machines) in the cluster.

- If pods can't be scheduled because the nodes are full, it adds a node.
- If nodes are mostly empty, it removes them to save cost.
- It is configured at the cluster level, usually through a cloud provider (EKS, GKE, AKS).
- It reacts to pending pods, not to CPU graphs.
- It works alongside HPA: HPA adds pods, and if there is no room for them, the Cluster Autoscaler adds nodes.

## Vertical Pod Autoscaler (VPA)

VPA changes **how much CPU and memory each pod gets**, instead of how many pods there are.

- It watches real usage and adjusts the container's resource requests (and limits) up or down.
- It is useful when you don't know the right resource values, or for apps that can't run multiple copies.
- It is an add-on, configured with a Kubernetes resource (YAML).
- Applying new values usually means restarting the pod.
- Don't use it together with HPA on the same metric (like CPU) for the same app, because they will conflict.

## KEDA (Kubernetes Event-Driven Autoscaling)

KEDA scales pods based on **events and external sources**, not just CPU and memory.

- It can scale on things like the length of a message queue, a Kafka topic, a database query, or a schedule.
- It can scale down to **zero** pods when there is no work and back up when events arrive, which HPA alone can't do.
- It works with HPA: KEDA creates and manages an HPA behind the scenes.
- It needs extra setup, since KEDA has to be installed in the cluster.

## Summary

| Tool | What it scales | Based on |
|---|---|---|
| **HPA** | Number of pods | CPU, memory, custom metrics |
| **Cluster Autoscaler** | Number of nodes | Pending pods and node usage |
| **VPA** | Resources per pod | Observed usage |
| **KEDA** | Number of pods (including to zero) | External events |