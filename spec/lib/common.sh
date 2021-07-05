list_containers() {
  docker ps |grep test-argo-rollout -c
}

run_kubectl_version() {
  kubectl version --short=true
}
