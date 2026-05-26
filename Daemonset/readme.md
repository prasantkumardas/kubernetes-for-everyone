What is a daemonset?

A DaemonSet in Kubernetes is a workload controller that ensures a pod runs on all or some nodes in a cluster
Example: If you create a daemonset in a cluster of 3 nodes, then 3 pods will be created. No need to manage replicas.
If you add another node to the cluster, a new pod will be automatically created on the new node.

How it works
A DaemonSet controller monitors for new and deleted nodes, and adds or removes pods as needed.


Some typical uses of a DaemonSet are:

running a cluster storage daemon on every node
running a logs collection daemon on every node
running a node monitoring daemon on every node


Pod on every node: It ensures that a copy of the pod is running on each node in your cluster.
Automatically manages nodes: If you add a new node to the cluster, the DaemonSet will automatically schedule the pod onto that new node.
Pod lifecycle: When nodes are removed from the cluster, the DaemonSet ensures that the pods are cleaned up as well.


If node labels are changed, the DaemonSet will promptly add Pods to newly matching nodes and delete Pods from newly not-matching nodes.
