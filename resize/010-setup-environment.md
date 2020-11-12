This tutorial requires Kubernetes and StorageOS to be installed. When the installation is complete, you will see the text "StorageOS is ready on hostX".

To verify the installation, run the following command and ensure all pods are ready.

`kubectl -n kube-system get pods -lapp=storageos `{{execute}}

You now have a succesful and healthy StorageOS installation running on
a Kubernetes cluster. In the next step we will create a StatefulSet that uses a StorageOS PVC.

