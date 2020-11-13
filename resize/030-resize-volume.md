In this final stage of the tutorial, we will resize the Volume we have created
by editing the the PVC storage request using `kubectl`.

We will be editing the `storage` field within the `statefulset.yaml` file
viewed earlier.

We can view the current size of the volume with the following command:

`kubectl get pvc`{{execute}}

The value in the `CAPACITY` column should be `20Gi`.

Volumes cannot be resized whilst they are in use. Therefore, before we perform
the resize operation we must take the Volume offline. To achieve this, scale
the StatefulSet down to zero.

`kubectl scale statefulsets influxdb --replicas=0`{{execute}}

Now we are ready to perform the resize operation. Use the edit functionality
of `kubectl` to open the manifest for modification. It is important to use
this method, as resizing a volume without updating the PVC directly will not
result in the PVC being updated.

`kubectl edit pvc`{{execute}}

This will open the manifest for modification with the `Vim` text editor.  use
the arrow keys to navigate to the `storage` field. Press `i` to enter `insert`
mode, then change the value from `20Gi` to `30Gi`. Press the `Esc` key
followed by `:wq` and the `Enter` key to save and quit.

Kubernetes will recognise the change that has been made, and request more
space, triggering StorageOS to expand the underlying volume. You can verify
this with:

`kubectl get pvc`{{execute}}

The value in the `CAPACITY` column should now have been updated to `30Gi`.

We can now safely scale our StatefulSet back to its original size:

`kubectl scale statefulsets influxdb --replicas=1`{{execute}}

We can further verify that the underlying volume has been resized by opening a
shell to the running container and viewing the size of the mounted volume
(your prompt will change).

`kubectl exec -it influxdb-0 -- bash`{{execute}}

Here we can view free disk space statistics, filtering for the StorageOS
Volume.

`df -h | grep storageos`{{execute}}

In this output we can see the Volume, mounted at
`/var/lib/storageos/volumes/`, and in the second column, its new size of
`30Gi`.

Congratulations! You have successfully resized a StorageOS Volume.