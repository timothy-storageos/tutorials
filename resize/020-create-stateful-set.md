To begin with, we will create a StatefulSet that uses a StorageOS PVC.
The StatefulSet we are using in this tutorial consists of an
InfluxDB application, deployed on a single container and consuming a 20Gi StorageOS PVC.

View the manifest file for the StatefulSet as follows:

`cat statefulset.yaml`{{execute}} 

Create the Service Account, Service, and StatefulSet from the manifest file.

`kubectl create -f statefulset.yaml`{{execute}}

You should now be able to view the newly-created PVC (you will see further fields to the right that are truncated in the output shown below):

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