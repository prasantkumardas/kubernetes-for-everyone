# Kubernetes Ingress Controller on Minikube Cluster

### In this demo, we will see how to use ingress controller to route the traffic on different services.


### What we are going to implement:
- In this demo, we will create two deployment and services i.e nginx and apache and with the help of ingress, we will route the traffic between the services

#
<b>3) Create one yaml file for apache deployment and service :</b>
```bash
# apache-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: apache-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: apache
  template:
    metadata:
      labels:
        app: apache
    spec:
      containers:
      - name: apache
        image: httpd:2.4
        ports:
        - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: apache-service
spec:
  selector:
    app: apache
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
  type: ClusterIP
```

#
<b>4) Apply apache deployment :</b>
```bash
kubectl apply -f apache-deployment.yaml
```

#
<b>5) Create one more yaml file for nginx deployment and service :</b>
```bash
# nginx-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 1
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
---
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  selector:
    app: nginx
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
  type: ClusterIP

```

#
<b>6) Apply nginx deployment :</b>
```bash
kubectl apply -f nginx-deployment.yaml
```

#
<b>7) Enable the Ingress Controller :</b>

# kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

# kubectl get pods -n ingress-nginx

#
<b>8) Now create an Ingress resource that routes traffic to the Apache and NGINX services based on the URL path.</b>
```bash
# ingress.yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: apache-nginx-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
  - host: localhost
    http:
      paths:
      - path: /apache
        pathType: Prefix
        backend:
          service:
            name: apache-service
            port:
              number: 80
      - path: /nginx
        pathType: Prefix
        backend:
          service:
            name: nginx-service
            port:
              number: 80
```

#
<b>9) Apply the Ingress resource :</b>
```bash
kubectl apply -f ingress.yaml
```

#
<b>10) To test the Ingress, map the hostname to the Minikube IP in your */etc/hosts* file :</b>

- port forward to access the Apache service on browser.
  ```bash
   kubectl port-forward -n ingress-nginx svc/ingress-nginx-controller 8080:80
  ```

curl http://localhost:8080/apache
curl http://localhost:8080/nginx

