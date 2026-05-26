Kubernetes Taints
A taint is applied to a node to indicate that the node should not accept any pod unless the pod explicitly tolerates the taint. Taints are like a “mark” on a node to prevent pods from being scheduled onto it unless necessary.

A taint consists of three parts:
1.	Key: A string representing the key for the taint (e.g., key=value).
2.	Value: The value associated with the key (optional).
3.	Effect: The action taken when a pod does not tolerate the taint. The possible effects are:
  	    NoSchedule: The pod will not be scheduled onto this node.
	    PreferNoSchedule: Kubernetes will try to avoid scheduling the pod on the node, but it may still schedule it there if necessary.
        NoExecute: The pod will be evicted from the node if already running, and new pods will not be scheduled on the node.

4.	kubectl taint nodes node1 key1=value1:NoSchedule
5.	kubectl taint nodes node1 key1=value1:NoExecute
6.	kubectl taint nodes node1 key2=value2:NoSchedule

Tolerations
A toleration is applied to a pod which is allow it to be scheduled on nodes that have taints. A pod with a toleration allows it to "tolerate" the taint on a node and be scheduled there.
A toleration consists of:
1.	Key: The taint key to tolerate.
2.	Value: The taint value to tolerate.
3.	Effect: The effect of the taint that the pod is willing to tolerate.
4.	Operator: A way to match the key-value pair. It can be:
	  Equal: Exact match between the key and value (default).
	  Exists: Ignores the value and only matches the key.
5.	TolerationSeconds: The amount of time for which the pod should tolerate a NoExecute taint before being evicted.
