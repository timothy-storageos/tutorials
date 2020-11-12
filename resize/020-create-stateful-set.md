To begin with, we will create a StatefulSet that that uses a StorageOS PVC.
The StatefulSet we are using in this tutorial consists of an
InfluxDB application, consuming a 20Gi StorageOS PVC.

View the manifest file for the StatefulSet as follows:

`cat statefulset.yaml`{{execute}} 

Create the Service Account, Service, and StatefulSet from the manifest file.

`kubectl create -f statefulset.yaml`{{execute}}

You should now be able to view the newly-created PVC (further fields to the right are truncated):

`kubectl get pvc`{{execute}}

```bash
NAME              STATUS   VOLUME        CAPACITY
data-influxdb-0   Bound    <volume-id>   20Gi
```

You should also now be able to view the running pod that consumes the PVC.

`kubectl get pods`{{execute}}

```bash
NAME                  READY   STATUS        RESTARTS   AGE
influxdb-0            1/1     Running       0          5s
```

You have now succesfully created a StatefulSet that uses a 20Gi StorageOS PVC. In the next step we will resize this PVC.

NAME              STATUS   VOLUME        CAPACITY
data-influxdb-0   Bound    <volume-id>   20Gi