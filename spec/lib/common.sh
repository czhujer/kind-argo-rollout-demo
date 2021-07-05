list_containers() {
  docker ps |grep test-argo-rollout -c
}

check_kubectl_version() {
  kubectl version --short=true
}
