# AWS EKS Monitoring Stack with Prometheus and Grafana

This project sets up a monitoring stack on an AWS EKS cluster using **Prometheus** for collecting Kubernetes metrics and **Grafana** for visualization. The deployment process is automated with **Helm**, ensuring smooth and reproducible setup.

## Features
- **Prometheus**: Collects and stores time-series metrics from the Kubernetes cluster.
- **Grafana**: Visualizes metrics in beautiful and interactive dashboards.
- **AWS EKS**: The solution is deployed on Amazon Web Services Elastic Kubernetes Service (EKS).
- **NGINX Ingress Controller**: Exposes Grafana securely to external users.

## Architecture Diagram
![Architecture Diagram](./images/architecture.png)

## Prerequisites

Ensure the following tools are installed:
- [AWS CLI](https://aws.amazon.com/cli/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- [Helm](https://helm.sh/docs/intro/install/)
- [eksctl](https://eksctl.io/)

## Setup Instructions

### 1. **Create an EKS Cluster**

First, create your EKS cluster using `eksctl`:
```bash
eksctl create cluster --name aws-k8s-monitoring-cluster --region us-east-1 --nodes 3 --node-type t3.medium
2. Install Prometheus and Grafana using Helm
Create the monitoring namespace:
bash
Copy
Edit
kubectl create namespace monitoring
Install Prometheus:
bash
Copy
Edit
helm install prometheus prometheus-community/kube-prometheus-stack -n monitoring --create-namespace
Install Grafana:
bash
Copy
Edit
helm install grafana bitnami/grafana -n monitoring
3. Expose Grafana using Ingress
Create an Ingress resource to expose Grafana. Use the following ingress.yaml:

yaml
Copy
Edit
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: grafana-ingress
  namespace: monitoring
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
  - host: <your-public-ip-or-domain>
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: grafana
            port:
              number: 80
Apply the Ingress configuration:

bash
Copy
Edit
kubectl apply -f ingress.yaml
Replace <your-public-ip-or-domain> with the actual public IP or domain name provided by your AWS Load Balancer or NGINX Ingress.

4. Access Grafana
Once the Ingress is set up, you can access Grafana through the provided domain or public IP. The default login credentials are:

Username: admin

Password: admin

You can change the password after logging in.

5. Import Grafana Dashboards
After logging into Grafana, you can import popular dashboards for Kubernetes monitoring from the Grafana Dashboard Library.

6. Visualize Kubernetes Metrics
Grafana should automatically collect data from Prometheus. You can use pre-configured dashboards or create custom ones.

7. Optional Enhancements
You can further enhance your monitoring setup by:

Setting up alerts in Grafana: Configure alerts to be sent to Slack, email, or other services.

Visualize EKS Node + Pod Metrics: Create custom dashboards to visualize metrics specific to your EKS nodes and pods.

Expose Grafana securely with Ingress: Set up a domain to securely expose Grafana externally.

Demo Links
Grafana Dashboard

Prometheus Server

Troubleshooting
Grafana Dashboard not loading: Ensure that the Ingress is configured correctly and that your Grafana service is running.

Prometheus Metrics not appearing: Verify that Prometheus is properly scraping the Kubernetes metrics.

Links
Prometheus Documentation

Grafana Documentation

AWS EKS Documentation

Feel free to explore and ask questions if needed!
