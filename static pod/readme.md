It is same as pod then what is difference in static pod ?
static pod are managed by kubelet daemon on specific node without API server 
Unlike Pods that are managed by the control plane ( Like deployment) instead the kubelet watches each static pod
static pod can be created when emergency deployment required in case master component is down ( Kube-API server , Controller-Manager,scheduler ...)
static pod managed by kubelet 

Regular Pods: Managed by the Kubernetes control plane (API server, scheduler, controllers).


PS D:\Kube-Notes\Day4-pod> kubectl get pods
NAME                            READY   STATUS    RESTARTS   AGE
static-web-kind-control-plane   1/1     Running   0          6m39s
PS D:\Kube-Notes\Day4-pod> kubectl delete pods/static-web-kind-control-plane
pod "static-web-kind-control-plane" deleted
PS D:\Kube-Notes\Day4-pod> kubectl get pods
NAME                            READY   STATUS    RESTARTS   AGE
static-web-kind-control-plane   1/1     Running   0          10s
PS D:\Kube-Notes\Day4-pod> 

