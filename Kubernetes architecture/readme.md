Details view of Kube Architect…….
A user kubectl send request to create POD from worker node.
First the API server will receive request for POD creation, it will validate and authenticate.
APIserver will send messages to ETCD for entry
After that ETCD will send back the request to APIserver
then APIserver will send notification to SCHEDULER
scheduler will verify that resource availability
and send instruction to APIserver that I have resource to create POD
Then APIserver will interact with Kubelet of workder node
Kuberlet say I have job for you 
APIserver will create entry in ETCD that POD has been created
finally APIserver will send notification to User that POD has created.


1.	User → API Server (create Pod request)
2.	API Server: Authenticate, validate, and write to etcd.
3.	etcd → API Server: Store confirmation.
4.	API Server → Scheduler: Notify Scheduler to schedule the Pod.
5.	Scheduler: Check resource availability and assign the Pod to a node.
6.	Scheduler → API Server: Send node assignment details.
7.	API Server → Kubelet: Instruct Kubelet to create the Pod.
8.	Kubelet: Create containers and run the Pod.
9.	API Server → etcd: Update Pod status in etcd.
10.	API Server → User: Send Pod creation confirmation.


Cluster of Nodes:
•	Kubernetes consists of a cluster made up of multiple nodes.
Master/Node Architecture:
•	Kubernetes follows a master-worker architecture.
•	Control Plane is called Master Node: Manages the cluster, ensuring desired state through components like the API Server, etcd, Controller Manager, and Scheduler.
•	Worker Nodes: It’s a group of containers and report their status to the control plane.
Replication Controller / ReplicaSet:
•	Kubernetes uses ReplicaSets to ensure that the specified number of pod replicas are running at any time.
•	If a pod fails, the ReplicaSet will automatically create a new one to maintain the desired state.
Horizontal Pod Autoscaler (HPA):
•	The HPA is a Kubernetes feature that automatically scales the number of pods based on desired state.

