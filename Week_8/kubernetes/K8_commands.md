| Command                                    | Purpose                                                                     |
| ------------------------------------------ | --------------------------------------------------------------------------- |
| kubectl create -f file.yaml                | Create resources from a YAML file                                           |
| kubectl apply -f file.yaml                 | Create or update resources from a YAML file                                 |
| kubectl delete -f file.yaml                | Delete resources defined in a YAML file                                     |
| kubectl get all                            | List common resources, such as Pods, Deployments, ReplicaSets, and Services |
| kubectl get pods                           | List all Pods                                                               |
| kubectl get deployments                    | List all Deployments                                                        |
| kubectl get services                       | List all Services                                                           |
| kubectl get nodes                          | List all cluster nodes                                                      |
| kubectl describe pod pod-name              | Show detailed information about a Pod                                       |
| kubectl logs pod-name                      | Show logs from a Pod                                                        |
| kubectl exec -it pod-name -- /bin/sh       | Open a shell inside a running Pod                                           |
| kubectl scale deployment name --replicas=5 | Change the number of Pods in a Deployment                                   |
| kubectl rollout status deployment/name     | Check if a Deployment update has finished                                   |
| kubectl rollout undo deployment/name       | Roll back a Deployment to the previous version                              |
| kubectl edit deploy name | edit the deployment yaml file (can be done by editing yaml file and applying or using a specific command) |