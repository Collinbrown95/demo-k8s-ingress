# Handy
OKGREEN := '\033[92m'
ENDC := '\033[0m'
BOLD := '\033[1m'
SHELL := /bin/bash


deploy-k8s:
	# Apply the Digital Ocean deployment of the NGINX ingress controller
	kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.34.1/deploy/static/provider/do/deploy.yaml
	# Install Cert-Manager to the cluster
	kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v0.16.1/cert-manager.yaml
	# Deploy the manifests in the kubernetes folder
	kubectl apply -f kubernetes

init plan apply:
	terraform $@ -var-file=sensitive.tfvars

kubeconfig:
	@printf $(OKGREEN)
	@printf $(BOLD)
	@echo doctl kubernetes cluster kubeconfig save '<cluster-name>'
	@read -p "Enter Cluster Name: " cluster ; \
	doctl kubernetes cluster kubeconfig save $$cluster
	@printf $(ENDC)