In Kubernetes, a Service is a method for exposing a network application that is running as one or more Pods in your cluster

Why Services are needed in Kubernetes?

Services are necessary because of the distributed architecture of Kubernetes clusters. Apps are routinely deployed as Pods that could have thousands of replicas, spanning hundreds of physical compute Nodes. When a user interacts with your app, their request needs to be routed to any one of the available replicas, regardless of where it’s placed.


Use ClusterIP for internal-only services.

Use NodePort for quick external testing.

Use LoadBalancer for production-grade external access.

Use Headless for stateful workloads needing direct Pod IPs.


The following example demonstrates how to create and test simple ClusterIP, NodePort, and LoadBalancer Services in basic configurations. You can learn more about all the available options in the Kubernetes documentation.

For ease of use, we’ll deploy an NGINX web server Pod, but the app you expose could equally be a database, metrics agent, microservice, or any other workload that needs network access. You’ll need Kubectl and an existing Kubernetes cluster to follow along.

1. Deploy the sample app
First, copy the following Deployment manifest and save it as app.yaml in your working directory:

apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx
  labels:
    app: nginx
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        ports:
          - containerPort: 80
The manifest deploys three replicas of the nginx:latest container image. In the metadata.labels field, an app: nginx label is applied—this will be referenced by your Services in the following steps. The ports.containerPort field within the Pod spec template is used to indicate that the Pods will be exposing port 80, the default NGINX web server port.

Use Kubectl to apply the Deployment manifest to your cluster:

$ kubectl apply -f app.yaml
deployment.apps/nginx created
Wait until all the deployment’s Pod replicas are ready:

$ kubectl get deployments
NAME    READY   UP-TO-DATE   AVAILABLE   AGE
nginx   3/3     3            3           20s

2. Create a ClusterIP Service

Now your NGINX deployment is running, but you don’t have a way to access it. Although you could directly connect to the Pods, this doesn’t load balance and will lead to errors if one of the Pods becomes unhealthy or is replaced. Creating a Service allows you to route traffic between the replicas so you can reliably access the Deployment.

The following manifest defines a simple ClusterIP service:

apiVersion: v1
kind: Service
metadata:
  name: nginx-clusterip
spec:
  type: ClusterIP
  selector:
    app: nginx
  ports:
    - port: 8080
      targetPort: 80
There are a few points to note in the manifest:

The spec.type field is set to ClusterIP as we’re creating a ClusterIP service.
The spec.selector field selects the NGINX Pods using the app: nginx label applied in the Deployment’s manifest.
The spec.ports field specifies that traffic to port 8080 on the Service’s Cluster IP address will be routed to port 80 at your Pods.
Save the manifest as clusterip.yaml, then add it to your cluster:

$ kubectl apply -f clusterip.yaml
service/nginx-clusterip created
Next, use Kubectl’s get services command to discover the cluster IP address that’s been assigned to the Service:

$ kubectl get services
NAME              TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
nginx-clusterip   ClusterIP   10.109.128.34   <none>        8080/TCP   10s
In this example, the service has the IP address 10.109.128.34. You can now connect to this IP from within your cluster in order to reach your NGINX Deployment, with automatic load balancing between your three Pod replicas.

To check, use kubectl exec to curl the IP address from inside one of your NGINX Pods:

$ kubectl exec deployment/nginx -- curl 10.109.128.34:8080
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
You got a successful response, proving the Service is working. You can also try connecting using the Service’s DNS name, such as nginx-clusterip.default.svc.cluster.local. Whichever method you use, port 8080 must be specified, as that’s the port the Service is configured to listen on.

3. Create a NodePort Service

Now, let’s externally expose the Deployment using a NodePort Service. The manifest is similar to a ClusterIP Service—specify type: NodePort instead of type: ClusterIP and use the ports.nodePort field to set the Node port to listen on:

apiVersion: v1
kind: Service
metadata:
  name: nginx-nodeport
spec:
  type: NodePort
  selector:
    app: nginx
  ports:
    - port: 80
      nodePort: 32000
You can omit the nodePort field, in which case the port number given by the port field will be used. The manifest above specifies that Node port 32000 will direct traffic to port 80 at your app: nginx Pods.

Save the manifest as nodeport.yaml and use Kubectl to apply it:

$ kubectl apply -f nodeport.yaml
service/nginx-nodeport created
Next, find the IP address of one of your cluster’s Nodes:

$ kubectl get nodes -o wide
NAME       STATUS   ROLES           AGE     VERSION   INTERNAL-IP    EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION     CONTAINER-RUNTIME
minikube   Ready    control-plane   5h32m   v1.26.1   192.168.49.2   <none>        Ubuntu 20.04.5 LTS   6.2.0-37-generic   docker://20.10.23
In this demo, we’re using a local Minikube cluster with no external IP address available. The internal IP address is resolvable from the host machine, so the following example still works. For Nodes that have an external IP address assigned, such as those provisioned in your cloud accounts, you can access the service using both the internal and external IPs.

Accessing port 32000 on your Node’s IP address should now connect you to your NGINX deployment:

$ curl 192.168.49.2:32000
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>

4. Create a LoadBalancer Service

The simplest LoadBalancer Service looks very similar to ClusterIP Services:

apiVersion: v1
kind: Service
metadata:
  name: nginx-lb
spec:
  type: LoadBalancer
  selector:
    app: nginx
  ports:
    - port: 8080
      targetPort: 80
Adding this Service to your cluster will attempt to use the configured load balancer integration to provision a new infrastructure component. If you created your cluster from a managed cloud service, this should result in a load balancer resource being added to your cloud account.

Save the manifest as lb.yaml, then apply it with Kubectl:

$ kubectl apply -f lb.yaml
service/nginx-lb created
If you are following along using Minikube, start a minikube tunnel session to expose your load balancer Service before continuing below.

Run Kubectl’s get services command with the output format set to wide to view the publicly accessible external IP address that’s been assigned to the load balancer:

$ kubectl get services -o wide
NAME              TYPE           CLUSTER-IP      EXTERNAL-IP     PORT(S)          AGE     SELECTOR
nginx-lb          LoadBalancer   10.96.153.245   10.96.153.245   8080:30226/TCP   79s     app=nginx
You can reach the Service by connecting to its external IP address. Note that our demo Service is configured by its ports.port field to listen on port 8080 again, so this is the port you should target.

$ curl 10.96.153.245:8080
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
