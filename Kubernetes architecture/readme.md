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



**Control Plane (Master Node Components)**
**API Server**
This is the "front desk" of Kubernetes. Whenever you want to interact with your cluster, your request goes through the API Server. It validates and processes these requests to the backend components.

**etcd**
Think of this as the "database" of Kubernetes. It stores all the information about your cluster—what nodes are part of the cluster, what pods are running, what their statuses are, and more.

**Scheduler**
The "event planner" for your containers. When you ask for a container to be run, the Scheduler decides which machine (Node) in your cluster should run it. It considers resource availability and other constraints while making this decision.

**Controller Manager**
Imagine a bunch of small robots that continuously monitor the cluster to make sure everything is running smoothly. If something goes wrong (e.g., a Pod crashes), they work to fix it, ensuring the cluster state matches your desired state.

**Cloud Controller Manager**
This is a specialized component that allows Kubernetes to interact with the underlying cloud provider, like AWS or Azure. It helps in tasks like setting up load balancers and persistent storage.

**Worker Node Components**
**kubelet**
This is the "manager" for each worker node. It ensures all containers on the node are healthy and running as they should be.

**kube-proxy**
Think of this as the "traffic cop" for network communication either between Pods or from external clients to Pods. It helps in routing the network traffic appropriately.

**Container Runtime**
This is the software used to run containers. Docker is commonly used, but other runtimes like containerd can also be used.

**Other Components**
Pod
The smallest unit in Kubernetes, a Pod is a group of one or more containers. Think of it like an apartment in an apartment building.

Service
This is like a phone directory for Pods. Since Pods can come and go, a Service provides a stable "address" so that other parts of your application can find them.

Volume
This is like an external hard-drive that can be attached to a Pod to store data.

Namespace
A way to divide cluster resources among multiple users or teams. Think of it as having different folders on a shared computer, where each team can only see their own folder.

Ingress
Think of this as the "front door" for external access to your applications, controlling how HTTP and HTTPS traffic should be routed to your services.

