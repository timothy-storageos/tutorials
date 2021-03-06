First verify the StorageOS Installation.

`kubectl -n kube-system get pods -lapp=storageos`{{execute}}

We can use a pod to access the CLI using kubectl exec:

`kubectl -n kube-system run \
--image storageos/cli:v2.1.0 \
--restart=Never                          \
--env STORAGEOS_ENDPOINTS=[[HOST2_IP]]:5705 \
--env STORAGEOS_USERNAME=storageos       \
--env STORAGEOS_PASSWORD=storageos       \
--command cli                            \
-- /bin/sh -c "while true; do sleep 999999; done"`{{execute}}

Wait for the CLI pod to enter the Running state and press `Ctrl+C` to continue once the pod is running.

`kubectl -n kube-system get pods -l run=cli -w`{{execute}}

Verify that you have a healthy installation with three nodes:

`kubectl exec -ti cli -n kube-system -- storageos get node`{{execute}}
