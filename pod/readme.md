What is Pod ?

A Pod is a single instance of an application
A pod is the smallest object that you can create in kubernetes
Pods usually have one to one relationship with container running your application to scale up
you can create new pods and to scale down, you can delete the existing pods.
Its not recommended and also not to a good practice to have multiple containers of same kind as part of single pod
you can have mulpliple container of different kind of perticular pod
A node can have multiple  pod as per the requirement
Each worker node is managed by master node through the kubelet
A node is a worker machine where you can deploy pods in kubernetes
A pod always run on a node ,worker node, Maste Node


Pod Lifecycle:

Pending:	The Pod has been accepted by the Kubernetes cluster, but one or more of the containers has not been set up and ;made ready to run. This includes time a Pod spends waiting to be scheduled as well as the time spent downloading container images over the network.
Running:	The Pod has been bound to a node, and all of the containers have been created. At least one container is still running, or is in the process of starting or restarting.
Succeeded:	All containers in the Pod have terminated in success, and will not be restarted.
Failed:  	All containers in the Pod have terminated, and at least one container has terminated in failure. That is, the container either exited with non-zero status or was terminated by the system, and is not set for automatic restarting.
Unknown: 	For some reason the state of the Pod could not be obtained. This phase typically occurs due to an error in communicating with the node where the Pod should be running.

Container states:

1. Waiting
2. Running
3. Terminated


Pods Error:

1. Initial crash: Kubernetes attempts an immediate restart based on the Pod restartPolicy.
2. Repeated crashes: After the initial crash Kubernetes applies an exponential backoff delay for subsequent restarts,  described in restartPolic
3. CrashLoopBackOff state: This indicates that the backoff delay mechanism is currently in effect for a given container that is in a crash loop, failing and restarting repeatedly.
4. Backoff reset: If a container runs successfully for a certain duration (e.g., 10 minutes), Kubernetes resets the backoff delay, treating any new crash as the first one.

Conatiner Restart Policy:

The container restart policy in Kubernetes determines what happens when a container inside a Pod crashes or stops. It specifies whether and how Kubernetes should attempt to restart the container. The restart policy is defined at the Pod level, and it applies to all containers in the Pod

1. Always (default)
restartPolicy: Always
2. OnFailure
restartPolicy: OnFailure
3. Never
restartPolicy: Never



