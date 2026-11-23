# Persistent Storage for the Tic-Tac-Toe App (PV and PVC)

## Architecture Diagram
TODO

## What is a PV?
A **PersistentVolume (PV)** is a piece of storage that has been made available to the cluster. It could be a folder on a node's disk, a cloud disk (AWS EBS, Google Persistent Disk) or a network share (NFS). The PV is the Kubernetes object that describes that storage.

- It is a **cluster-level resource**, like a node, and does not belong to a namespace.
- It exists **independently of any pod**. Pods come and go, but the PV and its data stay.
- It is created either **manually** by an admin (what we did) or **automatically** by a StorageClass (dynamic provisioning).
- It describes the storage: **size**, **access mode**, **reclaim policy** and **where the data actually lives** (here, `hostPath`).

In short: **the PV is the actual storage.**

## What is a PVC?

A **PersistentVolumeClaim (PVC)** is a request for storage made by a user or application. A pod does not connect to a PV directly. It asks for storage through a claim, and Kubernetes finds a PV that satisfies it and **binds** the two together.

- It is **namespaced**, so it lives in the same namespace as the pod that uses it.
- It states **how much** storage is needed and **how** it will be accessed.
- Kubernetes matches it to a PV with the same `storageClassName` and access mode, and enough capacity.
- Once bound, the pair is exclusive: one PVC to one PV.
- The pod references the **PVC** (not the PV) under `volumes`.

In short: **the PVC is the request for storage.** This keeps the app decoupled from where the storage physically lives. The app only says "I need 500Mi", and the cluster decides which PV provides it.

| | PV | PVC |
|---|---|---|
| Role | The storage itself | A request for storage |
| Created by | Admin or StorageClass | The app owner |
| Scope | Cluster-wide | Namespace |
| Referenced by | The PVC (binding) | The pod (`volumes`) |
| Analogy | A parking space | A parking permit for that space |

### Lifecycle

1. **Available:** the PV exists and is not claimed.
2. **Bound:** a PVC has claimed the PV (`kubectl get pv,pvc` shows `Bound`).
3. **Released:** the PVC was deleted, but the PV still holds the old data (with `Retain`).
4. The PV is then reused, cleaned up or deleted, depending on the reclaim policy.

## Access Modes

An **access mode** defines **how many nodes can mount the volume and whether they can write to it**. It is set on both the PV and the PVC, and they must match.

| Mode | Short | Meaning |
|---|---|---|
| `ReadWriteOnce` | RWO | Read-write by a **single node** (several pods on that same node can share it) |
| `ReadOnlyMany` | ROX | Read-only by **many nodes** |
| `ReadWriteMany` | RWX | Read-write by **many nodes** (needs storage that supports it, such as NFS) |
| `ReadWriteOncePod` | RWOP | Read-write by a **single pod** only |

We use `ReadWriteOnce` because there is one Mongo pod, so only one node ever needs to write to the volume.

## Reclaim Policy

The **reclaim policy** defines **what happens to the PV and its data after the PVC is deleted**. It is set on the PV.

| Policy | What happens |
|---|---|
| `Retain` | The PV and its data are **kept**. The PV becomes `Released` and must be cleaned up manually. |
| `Delete` | The PV **and the underlying storage are deleted** automatically with the PVC. |
| `Recycle` | Deprecated. Wiped the data so the PV could be reused. |

We use `Retain` so the database files are not lost if the claim is deleted by accident. The trade-off is that we have to remove the PV (and the data folder) ourselves at the end. Dynamically provisioned PVs usually default to `Delete`.

## Why Use Them?

Without a volume, MongoDB writes to the container's own filesystem, so **deleting the pod deletes the data**. With a PV and PVC, the data is stored outside the pod, and a new pod mounts the same storage and finds the same data.

## The YAML Explained

### 1. PersistentVolume

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: mongo-pv
spec:
  capacity:
    storage: 500Mi
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: manual
  hostPath:
    path: /Users/javedhussain/mongo-data
    type: DirectoryOrCreate
```

| Field | Meaning |
|---|---|
| `capacity.storage` | Size of the volume (`500Mi`). Must be at least what the PVC requests |
| `accessModes: ReadWriteOnce` | Can be mounted read-write by a single node |
| `persistentVolumeReclaimPolicy: Retain` | Keep the data when the PVC is deleted (must be cleaned up manually) |
| `storageClassName: manual` | Label used to match this PV with the PVC (stops the default provisioner taking over) |
| `hostPath.path` | Folder on the node/local disk where the data is stored |
| `type: DirectoryOrCreate` | Create the folder if it does not exist |

### 2. PersistentVolumeClaim

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: mongo-pvc
spec:
  accessModes:
    - ReadWriteOnce
  storageClassName: manual
  resources:
    requests:
      storage: 500Mi
```

| Field | Meaning |
|---|---|
| `accessModes` | Must match the PV |
| `storageClassName: manual` | Must match the PV, otherwise the claim will not bind |
| `resources.requests.storage` | Amount of storage requested (`500Mi`, so the PV must be at least this size) |

### 3. Mongo Deployment (using the volume)

```yaml
    spec:
      containers:
        - name: mongo
          image: mongo:8.0
          ports:
            - containerPort: 27017
          volumeMounts:
            - name: mongo-storage
              mountPath: /data/db
      volumes:
        - name: mongo-storage
          persistentVolumeClaim:
            claimName: mongo-pvc
```

| Field | Meaning |
|---|---|
| `volumes` | Declares a volume for the pod and links it to the PVC by `claimName` |
| `volumeMounts` | Mounts that volume inside the container |
| `mountPath: /data/db` | The folder where MongoDB stores its database files |
| `name: mongo-storage` | Must be the same in `volumes` and `volumeMounts` |


```

## Commands

```bash
kubectl apply -f ttt-app-db-pvc.yaml
kubectl get pv       # STATUS should be Bound
kubectl get pvc      # STATUS should be Bound
```

## Cleanup

```bash
kubectl delete deployment ttt-deployment mongo
kubectl delete pvc mongo-pvc
kubectl delete pv mongo-pv
kubectl get pv                 # confirm it is gone
rm -rf ~/mongo-data            # Retain leaves the files behind
```