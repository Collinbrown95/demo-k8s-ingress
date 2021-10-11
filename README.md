# k8s-ingress-demo
A simple project to illustrate how to expose a kubernetes service behind an ingress.

### How a Digital Ocean Load Balancer is Created
(from the [docs](https://github.com/digitalocean/digitalocean-cloud-controller-manager/blob/master/docs/controllers/services/annotations.md)) Digital Ocean's cloud controller manager watches for Kubernetes services with of type `LoadBalancer` and creates corresponding DigitalOcean Load Balancers to match that Kubernetes service. The Load Balancer is configured by applying the appropriate annocations to the Kubernetes Service resource in the `metadata` field. In the [ingress-nginx manifest](https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.34.1/deploy/static/provider/do/deploy.yaml), this looks as follows:

```yaml
# ...
---
# Source: ingress-nginx/templates/controller-service.yaml
apiVersion: v1
kind: Service
metadata:
  annotations:
    service.beta.kubernetes.io/do-loadbalancer-enable-proxy-protocol: 'true'
  # ...
spec:
  type: LoadBalancer
  # ...
---
# ...
```

- Note that there is a [workaround](https://github.com/digitalocean/digitalocean-cloud-controller-manager/blob/master/docs/controllers/services/examples/README.md#accessing-pods-over-a-managed-load-balancer-from-inside-the-cluster) required to allow pods to communicate with other pods over external IP Addresses.

## Supplementary Resources

### How DNS Works
- [DNS Records](https://www.cloudflare.com/en-ca/learning/dns/dns-records/)
- [DNS A Records](https://www.cloudflare.com/learning/dns/dns-records/dns-a-record/)
- [DNS AAAA Records](https://www.cloudflare.com/learning/dns/dns-records/dns-aaaa-record/)
- [How DNS works](https://www.cloudflare.com/learning/dns/dns-server-types/)

### DigitalOcean Docs and Tutorial
- [How to Add Domains Digital Ocean](https://docs.digitalocean.com/products/networking/dns/how-to/add-domains/)
- [Manage DNS records through Digital Ocean](https://docs.digitalocean.com/products/networking/dns/how-to/manage-records/)
- [How to point your domain to Digital Ocean's DNS Nameservers](https://www.digitalocean.com/community/tutorials/how-to-point-to-digitalocean-nameservers-from-common-domain-registrars)
- [Digital Ocean Domains and DNS](https://docs.digitalocean.com/products/networking/dns/)
- [NGINX Ingress Gateway on Digital Ocean Tutorial](https://www.digitalocean.com/community/tutorials/how-to-set-up-an-nginx-ingress-with-cert-manager-on-digitalocean-kubernetes)

## Cert-Manager and Let's Encrypt
- [Explanation of SSL for Kubernetes with Cert-Manager](https://www.youtube.com/watch?v=hoLUigg4V18)

### Past Sessions and Other Info
- [k8s-demo from last session](https://github.com/blairdrummond/k8s-demo-app)