launch.sh
export ETCD_HOST=[[HOST2_IP]]

echo "Installing StorageOS and ETCD"

sleep 5

ssh node01 -o StrictHostKeyChecking=no wget https://raw.githubusercontent.com/storageos/tutorials/master/ephemeral/assets/install-etcd.sh
echo ${ETCD_HOST} | ssh node01 bash install-etcd.sh

kubectl create -f https://github.com/storageos/cluster-operator/releases/download/v2.3.0/storageos-operator.yaml

kubectl create -f- <<END
apiVersion: v1
kind: Secret
metadata:
  name: "storageos-api"
  namespace: "storageos-operator"
  labels:
    app: "storageos"
type: "kubernetes.io/storageos"
data:
  # echo -n '<secret>' | base64
  apiUsername: c3RvcmFnZW9z
  apiPassword: c3RvcmFnZW9z
  # CSI Credentials
  csiProvisionUsername: c3RvcmFnZW9z
  csiProvisionPassword: c3RvcmFnZW9z
  csiControllerPublishUsername: c3RvcmFnZW9z
  csiControllerPublishPassword: c3RvcmFnZW9z
  csiNodePublishUsername: c3RvcmFnZW9z
  csiNodePublishPassword: c3RvcmFnZW9z
  csiControllerExpandUsername: c3RvcmFnZW9z
  csiControllerExpandPassword: c3RvcmFnZW9z
END

kubectl create -f- <<END
apiVersion: "storageos.com/v1"
kind: StorageOSCluster
metadata:
  name: "my-storageos-cluster"
  namespace: "storageos-operator"
spec:
  # StorageOS Pods are in kube-system by default
  secretRefName: "storageos-api" # Reference from the Secret created in the previous step
  secretRefNamespace: "storageos-operator"  # Namespace of the Secret
  k8sDistro: "upstream"
  images:
    nodeContainer: "storageos/node:v2.3.0" # StorageOS version
    kubeSchedulerContainer: "k8s.gcr.io/kube-scheduler:v1.18.8"
  kvBackend:
    address: '${ETCD_HOST}:2379'
  resources:
    requests:
      memory: "512Mi"
      cpu: 1
END

# DNS needs restarting sometimes
kubectl -n kube-system delete pod -lk8s-app=kube-dns &
