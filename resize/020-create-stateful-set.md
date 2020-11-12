To begin with, we will create a StatefulSet that that uses a StorageOS PVC.
The StatefulSet we are using in this tutorial consists of 1 instance of an
InfluxDB application, consuming a 20Gi StorageOS PVC.

We will create a StatefulSet consisting of one InfluxDB container, consuming a
StorageOS PVC. View the configuration of the StatefulSet as follows:

`cat statefulset.yaml`{{execute}} 

Create the Service Account, Service, and StatefulSet from the manifest file.

`kubectl create -f statefulset.yaml`{{execute}}

You should now be able to view the newly-created PVC:

`kubectl get pvc`{{execute}}

```bash
NAME                  READY   STATUS        RESTARTS   AGE
data                  1/1     Running       0          5s
```

You should also now be able to view the running pod that consumes the PVC.

`kubectl get pods`{{execute}}

```bash
NAME                  READY   STATUS        RESTARTS   AGE
influxdb-0            1/1     Running       0          5s
```

You have now succesfully created a StatefulSet that uses a 20Gi StorageOS PVC. In the next step we will resize this PVC.