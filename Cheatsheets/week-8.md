# Week 8 cheatsheet: Docker and Kubernetes

- **Containers:** package an app and its dependencies while sharing the host kernel. Images are templates; containers are running instances.
- **Docker basics:** build an image from a `Dockerfile`, tag it, then run it. Useful commands: `docker ps -a`, `docker images`, `docker logs`, `docker exec`, `docker stop`, `docker rm`.
- **Dockerfile:** use a suitable base image, copy only needed files, install dependencies, set a working directory, and define the startup command. Rebuild after changing image contents.
- **Compose:** define related services, networks, and volumes in a Compose file; use named volumes when data must outlive a container.
- **Kubernetes:** a cluster has a control plane and worker nodes. A Pod is the smallest deployable unit; a Deployment manages replicas and rollouts; a Service provides stable network access.
- **Configuration and data:** ConfigMaps hold non-secret settings; Secrets hold sensitive values (protect access and storage). PersistentVolumes provide storage beyond a pod lifecycle; Namespaces organize resources.
- **Security:** use trusted, maintained images, patch and rebuild regularly, run with least privilege, and avoid embedding secrets in images.

See [Docker notes](../Week_8/docker/Introduction_to_Docker.md) and [Kubernetes objects](../Week_8/kubernetes/K8_objects.md).
