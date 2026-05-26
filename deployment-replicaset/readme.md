Deployment:

> Pods Encapsulation: Each application or service in Kubernetes is encapsulated in a container, which is further encapsulated in a Pod. A Pod is the smallest deployable unit in Kubernetes.

> Replication Controller/ReplicaSet: Multiple instances (replicas) of Pods are deployed to ensure high availability and scalability. The ReplicaSet ensures that a specific number of Pod replicas are running at all times. Replication controller works as LB
>Replicaset will run the desired number of replica has defined.

> Deployment Object: A Deployment is a higher-level Kubernetes object that manages the ReplicaSet(s) and provides capabilities like scaling, rolling updates, and rollbacks. It abstracts the ReplicaSet management to make deployments easier.

> Rolling Updates & Rollbacks: One of the primary features of a Deployment is to handle rolling updates to your application. When changes are made (e.g., image updates), the Deployment gradually updates Pods while ensuring the application is still available. If something goes wrong, you can roll back the Deployment to a previous stable version.

> Update Management: Kubernetes ensures that updates are managed in a way that minimizes downtime. The Deployment controller uses a rollout manager that updates Pods in a controlled manner.

> Availability During Updates: While Pods are being updated, Kubernetes ensures that only a certain number of Pods are down at any given time to prevent complete service outage. This guarantees application availability even during updates.

> Customizable Availability Settings: By default, Kubernetes ensures that at least 25% of the desired Pods are available during updates, but this can be customized with specific maxUnavailable and maxSurge settings based on your requirements.

> Revision History: Kubernetes keeps track of Deployment revisions. Each change made to the Deployment (such as an update or rollback) is stored as a revision, allowing you to easily roll back to a previous configuration if needed.

Use cases Deployment:

1. Rollout a ReplicaSet

2. Update PodTemplateSpec

3. Rollback to a Previous Revision

4. Scale the Deployment

5. Pause and Resume Rollouts

6. Monitor Rollout Status

7. Clean up Older ReplicaSets

8. Canary Deployment

9. Blue Green deployment

10. Progressive delivery 


example:

kubectl apply -f https://k8s.io/examples/controllers/nginx-deployment.yaml
kubectl get deployments
kubectl rollout status deployment/nginx-deployment
kubectl get rs
kubectl get pods --show-labels
kubectl set image deployment.v1.apps/nginx-deployment nginx=nginx:1.16.1
or
kubectl set image deployment/nginx-deployment nginx=nginx:1.16.1
kubectl edit deployment/nginx-deployment
kubectl rollout status deployment/nginx-deployment

kubectl describe deployments

rolling back

Rolling Back a Deployment:
Suppose that you made a typo while updating the Deployment

kubectl set image deployment/nginx-deployment nginx=nginx:1.161
kubectl describe deployment

kubectl rollout history deployment/nginx-deployment

kubectl rollout history deployment/nginx-deployment --revision=2

Rolling Back Previous version.

kubectl rollout undo deployment/nginx-deployment
kubectl rollout undo deployment/nginx-deployment --to-revision=2

kubectl scale deployment/nginx-deployment --replicas=10

Assuming horizontal Pod autoscaling is enabled in your cluster,:

kubectl autoscale deployment/nginx-deployment --min=10 --max=15 --cpu-percent=80

kubectl run web-dev --image=nginx --dry-run=client -o yaml
kubectl run web-dev --image=nginx --labels="app=web,env=dev"

find thr selector:

kubectl get pods -l env=dev
kubectl explain rc
kubectl explain pod