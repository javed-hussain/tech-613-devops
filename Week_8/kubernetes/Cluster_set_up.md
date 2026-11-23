## Cluster Setup

A cluster is the whole Kubernetes system: a set of machines (nodes) that run your containers, plus the control plane that manages them.

A namespace is a named section inside a cluster that groups and separates resources. Think of the cluster as a building and namespaces as separate rooms. Names only have to be unique within a namespace, so two teams can each have a mongo Service without clashing.

```text
Kubernetes Cluster
├── Control Plane (Master Node)
└── Worker Nodes (data plane)
    ├── Pod 1
    ├── Pod 2
    └── Pod 3
```

### Cluster components

- **Control plane:** Makes decisions about the cluster, such as scheduling and maintaining the desired state.
- **Worker nodes:** Run the actual application containers.
- **kubelet:** An agent on each worker node that communicates with the control plane.
- **Container runtime:** Runs the containers, such as containerd.
- **kubectl:** The command-line tool used to interact with a Kubernetes cluster.

### Example commands

```bash
kubectl get nodes
kubectl get pods
kubectl get services
kubectl apply -f deployment.yaml
```

## Master Nodes

The **master node**, also called the **control plane**, manages the Kubernetes cluster.

It does not usually run the application itself. Instead, it controls and monitors the worker nodes.

### Main control-plane components

| Component | Purpose |
|---|---|
| API Server | Entry point for Kubernetes commands and API requests |
| etcd | Stores the cluster state and configuration (key-value)|
| Scheduler | Decides which worker node runs each Pod |
| Controller Manager | Monitors the cluster and maintains the desired state |
| Cloud Controller Manager | Integrates Kubernetes with cloud provider services |

### What the master node does

- Receives commands through `kubectl`.
- Stores cluster information in `etcd`.
- Schedules Pods onto worker nodes.
- Monitors the health of Pods and nodes.
- Replaces failed Pods.
- Manages scaling, updates, and networking rules.

## Worker Nodes

Worker nodes run the actual application workloads. Worker Nodes all run on the **data plane**

Each worker node contains:

- **kubelet:** Communicates with the control plane and manages containers on the node.
- **Container runtime:** Runs containers.
- **kube-proxy:** Handles networking and routing traffic to Pods.

```text
Data plane
├── Worker Node
│   ├── kubelet
│   ├── Container runtime
│   ├── kube-proxy
│   └── Pods
│       ├── Container 1
│       └── Container 2
├── Worker Node 2
└── Worker Node 3
```

- The control plane decides what should run
- The data plane actually runs it.
- Worker nodes are part of the data plane because they run the Pods.
- Important note
- A worker node can run multiple Pods.
- Each Pod can contain one or more containers.
- The control plane tells worker nodes what to run.
- Worker nodes carry out those instructions._