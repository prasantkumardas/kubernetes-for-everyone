
Access Frontend application:


azureuser@kubernet-frontend:~/frontend$ kubectl get service my-webapp-service
NAME                TYPE       CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
my-webapp-service   NodePort   10.103.121.227   <none>        80:32704/TCP   118s
azureuser@kubernet-frontend:~/frontend$

azureuser@kubernet-frontend:~/frontend$ kubectl get deployment
NAME             READY   UP-TO-DATE   AVAILABLE   AGE
hello-minikube   1/1     1            1           53m
my-webapp        3/3     3            3           48m
azureuser@kubernet-frontend:~/frontend$


azureuser@kubernet-frontend:~/frontend$ minikube ip
192.168.39.56



azureuser@kubernet-frontend:~/frontend$ curl http://192.168.39.56:32704
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, nginx is successfully installed and working.
Further configuration is required for the web server, reverse proxy,
API gateway, load balancer, content cache, or other features.</p>

<p>For online documentation and support please refer to
<a href="https://nginx.org/">nginx.org</a>.<br/>
To engage with the community please visit
<a href="https://community.nginx.org/">community.nginx.org</a>.<br/>
For enterprise grade support, professional services, additional
security features and capabilities please refer to
<a href="https://f5.com/nginx">f5.com/nginx</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
