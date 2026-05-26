Kubernetes Network Policy:

A Network Policy in Kubernetes is a resource used to control the traffic flow to and from Pods within a cluster. It acts as a firewall for Pods, defining which traffic is allowed or denied based on rules.

Key Concepts
Namespacescoped:
Policies are namespace scoped
Ingress: Controls traffic coming into Pods.
Egress: Controls traffic going out from Pods.

Selectors:
Network Policies use selectors to target specific Pods based on labels.
Default Behavior:
Like NamespaceSelector and NodeSelector
ipBlock: This selects particular IP CIDR ranges to allow as ingress sources or egress destinations. These should be cluster-external IPs, since Pod IPs are ephemeral and unpredictable

By default, Pods are open to all traffic (Ingress and Egress).that means doesn't enforce the network policy bydefault.
Once a Network Policy is applied, only the traffic explicitly allowed by policies is permitted.
CNI Requirement:


Policy rules can specify protocols (TCP,UDP,SCTP) named Ports and port numbers.
Network Policies are enforced only if the CNI plugin supports them (e.g., Calico, Cilium).


Scenario
frontend service: Exposes an application to users.
backend service: Processes data and communicates with the database.
database: Stores application data and only accepts traffic from the backend.

Install Calico:

kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/calico.yaml


Calico Network Policy Features:

Enhanced Rule Types:

Supports Kubernetes-native policies and Calico-specific policies.
Provides advanced options like DNS filtering, ICMP rules, and HTTP-based policies.
Policy Levels:

Namespace-scoped policies: Similar to Kubernetes Network Policies.
Global Network Policies: Cluster-wide policies not tied to a specific namespace.
Selectors:

Allows for powerful matching based on labels, namespaces, and other metadata.
Example: Select pods with specific labels or namespaces.
Protocol and Port Control:

Supports TCP, UDP, ICMP, and other protocols with fine-grained port specifications.
Advanced Capabilities:

Egress and ingress control with options like FQDN filtering.
Host-level traffic policies using Calico HostEndpoints.
Logging for audit and debugging.

Policy Action:

Specifies whether to Allow, Deny, or Log traffic.

Calico HostEndpoints are a feature in Calico (a Kubernetes networking and network policy provider) that allow you to define network policies for traffic to and from the host interfaces of the cluster nodes, not just pods. This is particularly useful for securing the cluster's infrastructure, such as restricting SSH access, protecting API servers, or controlling ingress/egress at the node level.

Concept of HostEndpoint.

HostEndpoint Resource:

Represents a specific interface on a host (node).
Allows you to apply Calico policies to traffic going in/out of the host interface.
Policy Scope:

Controls host-to-host, host-to-pod, or external-to-host traffic.
Integrates with the broader Calico network policy model.
Use Cases:

Restrict SSH access to specific IPs.
Allow only necessary services to communicate with the Kubernetes control plane.
Monitor and log traffic at the host interface level.

Ex:

apiVersion: projectcalico.org/v3
kind: HostEndpoint
metadata:
  name: node1-eth0
  labels:
    role: worker
spec:
  interfaceName: eth0
  node: node1
  expectedIPs:
    - 192.168.1.100



