A ConfigMap is used to store non-confidential data in key-value pairs. Pods can consume ConfigMaps as environment variables, command-line arguments, or as configuration files in a volume.

A ConfigMap allows you to decouple environment-specific configuration from your container images, so that your applications are easily portable.

configmap are stored in etcd and have their lifecycle managed by kubernetes 
configmap are not encrypted at rest
It can't hold large chunks of data. The data stored in a configmap can't exceed 1 MB

Configmap has binarydata and data field which are optional

There are four different ways that you can use a ConfigMap to configure a container inside a Pod:

- Inside a container command and args
- Environment variables for a container
- Add a file in read-only volume, for the application to read
- Write code to run inside the Pod that uses the Kubernetes API to read a ConfigMap

kubectl exec -it myapp-pod -- /bin/sh
then

echo $FIRSTNAME # you can see the firstname environment file inside the container

#https://kubernetes.io/docs/tasks/inject-data-application/distribute-credentials-secure/#define-container-environment-variables-using-secret-data


#create secret file

apiVersion: v1
kind: Secret
metadata:
  name: test-secret
data:
  username: bXktYXBw
  password: Mzk1MjgkdmRnN0pi


Secret:

A Secret in Kubernetes is a way to store sensitive data such as passwords, tokens, or keys securely. Unlike ConfigMaps, Secrets are specifically designed for confidential information and are base64-encoded by default in the API. They help keep sensitive data out of your application code or container images.

secret features:

- Enable encryption of rest
- Enable or config RBAC role
- Restrict secret access
- Consider using External secret stores

1. Set environmental variable for a container
2. Provide credential such as SSH keys or password
3. Allow the kubelet to pull container image from private registers

Types of secret

Built-in Type	                       Usage
Opaque	                               arbitrary user-defined data #default secret
kubernetes.io/service-account-token	   ServiceAccount token
kubernetes.io/dockercfg	               serialized ~/.dockercfg file
kubernetes.io/dockerconfigjson	       serialized ~/.docker/config.json file
kubernetes.io/basic-auth	           credentials for basic authentication
kubernetes.io/ssh-auth	               credentials for SSH authentication
kubernetes.io/tls	                   data for a TLS client or server
bootstrap.kubernetes.io/token	       bootstrap token data


Opaque Secrets:

Opaque is the default Secret type if you don't explicitly specify a type in a Secret manifest.

kubectl create secret generic empty-secret
kubectl get secret empty-secret
PS D:\Kube-Notes\Day19-Configmap> kubectl get secret empty-secret
NAME           TYPE     DATA   AGE
empty-secret   Opaque   0      7s
PS D:\Kube-Notes\Day19-Configmap> 