


Overlay Network
- An overlay network is a virtual network which is routed on top of underlay network infrastructure, routing decision would take place which help of software
- Some overlay network provider operate in layer-2 ( Flannel ) and some Layer-3  calico -used ipinIP protocal


 Key Concepts of Container Networking
- Network Namespace: Containers have their own isolated network namespace, meaning each container sees its own network stack (interfaces, routing tables, etc.).
- Virtual Network Interface: Each container gets its own virtual network interface for communication.
- Bridge Networks: A bridge acts as a virtual switch, connecting container interfaces to each other and the host.


Types of Container Networks
Kubernetes and Docker provide several networking modes:

a. Bridge Network (Default in Docker):
   Containers communicate with each other on the same bridge using private IPs.
    Outbound traffic uses NAT for internet access.
b. Host Network:
   The container shares the host’s network stack.
No isolation; the container uses the host’s IP and port.
c. None Network:
   No network interface is created for the container.
   Useful for custom setups.
d. Overlay Network:
   Enables communication between containers across different hosts.
   Used in container orchestrators like Kubernetes and Docker Swarm.
e. Macvlan Network:
   Assigns a unique MAC address to each container.
   Containers appear as physical devices on the network.


CNI (Container Network Interface).

CNI (Container Network Interface) is a specification and library for configuring network interfaces in Linux containers. It is widely used in container orchestration platforms like Kubernetes to provide networking capabilities for Pods. CNI ensures that containers can connect to the network and communicate with other containers, hosts, and external systems.

5. Common CNI Plugins
- Calico:

Provides advanced networking and network security.
Supports routing and network policies for isolation.
Suitable for high-performance use cases.

- Flannel:

Flannel is an open-source virtual network project managed by CoreOS network designed for Kubernetes. Each host in a flannel cluster runs an agent called flanneld. It assigns each host a subnet, which acts as the IP address pool for containers running on the host. Containers can then contact other containers directly, using their IP address. Flannel supports multiple backends for encapsulating packets. The recommended choice is Virtual Extensible LAN (VXLAN), which runs a Layer 2 network on top of a Layer 3 infrastructure. Flannel also supports host-gw, which maps direct routes between hosts in a manner similar to Calico.

Lightweight and simple overlay network.
Commonly used for Pod-to-Pod communication across nodes.

- Weave Net:

Provides automatic IP management and encryption.
Suitable for secure multi-host communication.

- Cilium:

Uses eBPF (extended Berkeley Packet Filter) for high-performance networking and security.
Excellent for microservices and API-based architectures.

- Kube-Router:

Focuses on efficient Pod networking, service proxying, and network policy enforcement.

There are three types of network in Kubernetes:

1. Node Network
2. Pod Network
3. Cluster Network

1. Node Network:
Enables communication between nodes in the cluster.

To connect nodes:

Ensure the nodes are in the same subnet or have proper routing between them.
Use a Container Network Interface (CNI) plugin to manage networking.

2. POD Networking:

The Pod network in Kubernetes is the communication framework that allows Pods (the smallest deployable units in Kubernetes) to connect and communicate within a cluster and with external systems. Each Pod in a Kubernetes cluster gets a unique IP address, and the Kubernetes networking model ensures seamless communication between Pods, services, and the external world.



Components of Pod Networking
- Pod IP Addresses:

Assigned from a cluster-wide CIDR range.
Each Pod retains its IP for its lifetime.
- Network Namespace:

Pods operate in their own network namespace, isolating their networking stack.
Containers within a Pod share the same namespace and communicate over localhost.
- Virtual Ethernet Interfaces (veth):

Each Pod has a veth pair for connecting the Pod’s network namespace to the host network.
- CNI Plugins:

Responsible for IP allocation, route configuration, and traffic handling between Pods.

---Pod Networking Goals:  
1. Pod-to-Pod Communication:

Direct communication between Pods across nodes is essential for microservices architectures.
2. Pod-to-Service Communication:

Services provide stable endpoints for Pods, abstracting dynamic Pod IPs.
3. Pod-to-External Communication:

Pods must communicate with external systems or clients.


CRI: Container Runtime Interface
The Container Runtime Interface (CRI) is an API specification in Kubernetes that defines how the kubelet (Kubernetes node agent) interacts with container runtimes. It provides a standard way for Kubernetes to manage containers without being tied to a specific container runtime, enabling flexibility and extensibility.