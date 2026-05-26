In Kubernetes, the scheduler is responsible for assigning pods to nodes in the cluster based on criteria. Sometimes, you might encounter situations where pods are not being scheduled as expected. This can happen due to factors such as node constraints, pod requirements, or cluster configurations.

Node affinity.

With node affinity rule you can control a Pod so where you can restricted to run on particular nodes. There are several ways to do this and the recommended approaches all use label selectors to facilitate the selection. 
You can use any of the following methods to choose where Kubernetes schedules specific Pods:
•	nodeSelector  and node labels
•	Affinity and anti-affinity
•	nodeName 
•	Pod topology spread constraints


nodeSelector and label

create a labels
kubectl label nodes <node-name> env=production
kubectl label nodes node-1 env=production

nodeSelector is the simplest recommended form of node selection constraint. You can add the nodeSelector field to your Pod specification and specify the node labels you want the target node to have. 


Node affinity

Node Affinity is a more expressive way to specify rules about the placement of pods relative to nodes' labels. It allows you to specify rules that apply only if certain conditions are met. Usage: Define nodeAffinity rules in the pod's YAML definition, specifying required and preferred node selectors.

- requiredDuringSchedulingIgnoredDuringExecution: The scheduler can't schedule the Pod unless the rule is met. This functions like nodeSelector, but with a more expressive syntax.

- preferredDuringSchedulingIgnoredDuringExecution: The scheduler tries to find a node that meets the rule. If a matching node is not available, the scheduler still schedules the Pod.