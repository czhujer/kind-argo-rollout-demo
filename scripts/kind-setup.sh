#!/bin/bash
set -ueo pipefail

cilium_version="1.10.1"

cilium_install () {
	# Add the Cilium repo
	helm repo add cilium https://helm.cilium.io/

  echo -e "install cilium helm chart..."

	helm install cilium cilium/cilium --version "${cilium_version}" \
	   --namespace kube-system \
	   --set nodeinit.enabled=true \
	   --set kubeProxyReplacement=partial \
	   --set hostServices.enabled=false \
	   --set externalIPs.enabled=true \
	   --set nodePort.enabled=true \
	   --set hostPort.enabled=true \
	   --set bpf.masquerade=false \
	   --set image.pullPolicy=IfNotPresent \
	   --set ipam.mode=kubernetes

	sleep 62s

	timeout 5 kubectl get nodes -o wide
  timeout 5 kubectl get pods -n kube-system -o wide

  timeout 5 docker ps

#	sleep 60s
#
#	timeout 5 ci-utils/kubectl get nodes -o wide
#  timeout 5 ci-utils/kubectl get pods -n kube-system -o wide

#  timeout 5 ci-utils/kubectl -n kube-system describe po -l k8s-app=kube-dns

#  echo -e "\n\nci-utils/kubectl -n kube-system logs ds/cilium-node-init"
#  timeout 5 ci-utils/kubectl -n kube-system logs ds/cilium-node-init
#  echo -e "\n\nci-utils/kubectl -n kube-system logs ds/cilium-node-init -p"
#  timeout 5 ci-utils/kubectl -n kube-system logs ds/cilium-node-init -p

#  timeout 5 ci-utils/kubectl -n kube-system logs ds/cilium --tail 100
#  timeout 5 ci-utils/kubectl -n kube-system logs ds/cilium --tail 100 -p
#  timeout 5 ci-utils/kubectl -n kube-system describe pod -l k8s-app=cilium
}

kind --version
# kind create cluster --name "test-argo-rollout" --config="kind-config.yaml" --wait=20s

kubectl taint nodes --all node-role.kubernetes.io/master- || true

kubectl get nodes -o wide

cilium_install

