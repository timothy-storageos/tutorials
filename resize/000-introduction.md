
In this tutorial we will be resizing a StorageOS Volume.

StorageOS supports offline resize of Volumes, which can be achieved either by
editing a PVC storage request, or by updating the Volume config via the CLI or
UI. This tutorial will demonstrate editing the PVC storage request, which is
the recommended method.

In the stages that follow, we will create a StatefulSet that uses a StorageOS
PVC. We will then scale that StatefulSet down to zero, to ensure that the
Volume is not attached to a node and is therefore offline. Finally we will
resize the PVC and confirm that the new configuration has been applied.

This sandbox environment is a fully configured 3 node Kubernetes cluster with
StorageOS installed at runtime. Please wait for the initialisation to complete
before attempting to begin the tutorial - this will take a few minutes,

For more information about resizing volumes, view the
[concepts](https://docs.storageos.com/docs/concepts/volumes/#volume-resize)
and [operations](https://docs.storageos.com/docs/operations/resize/) pages
dedicated to this topic in the StorageOS documentation.
