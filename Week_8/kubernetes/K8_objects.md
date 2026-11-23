## Kubernetes Objects

Kubernetes uses **objects** to describe the desired state of applications and cluster resources.

Resource (type): a kind of thing the Kubernetes API offers, such as pods, deployments, services, persistentvolumes. It's the category.

Object: a specific instance of a resource that exists in your cluster, such as the Deployment named mongo or the PV named mongo-pv. It's the thing you create with YAML.
You usually define objects in YAML files and apply them with:

```bash
kubectl apply -f file.yaml
```

### Pod

- The smallest deployable unit in Kubernetes.
- Usually contains one container.
- Containers inside the same Pod share networking and storage.

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
spec:
  containers:
    - name: nginx
      image: nginx:latest
      ports:
        - containerPort: 80
```

### Deployment

- Manages a set of identical Pods.
- Used for applications that need multiple replicas.
- Supports rolling updates and rollbacks.
- Automatically replaces failed Pods.
- Contains a replicaset typically to manage the pods: 
  - A ReplicaSet is a Kubernetes object that keeps a specific number of identical Pods running. If a Pod fails, it automatically creates a replacement to maintain the desired number.
- A selector is a filter that finds Kubernetes objects by their labels. For example, app: A means “select the Pods labelled app: A.”



```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
        - name: nginx
          image: nginx:latest
          ports:
            - containerPort: 80
```

### Service

- Provides a stable network address for Pods.
- Pods can be replaced or restarted, but the Service remains available.
- Can distribute traffic across multiple Pods.

```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  selector:
    app: nginx
  ports:
    - port: 80
      targetPort: 80
  type: ClusterIP
```

### ConfigMap

- Stores non-sensitive configuration data.
- Examples include environment variables, configuration files, and command-line arguments.

### Secret

- Stores sensitive information.
- Examples include passwords, API keys, tokens, and certificates.
- Should not contain data that needs to be public.

### PersistentVolume

- Provides storage that exists independently of Pods.
- Useful for databases and applications that must keep data after restarts.
- Jenkins would use persistent storage to retain jobs, plugins, and configuration.

### Namespace

- Used to organise resources within a cluster.
- Useful for separating environments such as development, testing, and production.

## Key Point

- **Docker** builds and runs containers.
- **Kubernetes** deploys, scales, monitors, and manages containers.
- A Kubernetes cluster contains a control plane/master node and worker nodes.
- Kubernetes objects describe the desired state of applications.
- Kubernetes automatically maintains that desired state.