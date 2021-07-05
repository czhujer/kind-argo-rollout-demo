list_containers() {
  docker ps |grep test-argo-rollout -c
}

check_kubectl_version() {
  kubectl version --short=true
}

check_ingress_deploy() {
  kubectl -n ingress-nginx get deploy ingress-nginx-controller --no-headers=true  |awk -F ' ' '{ print $2 " " $3 " " $4}'
}

check_https_port() {
   wget https://127.0.0.1:443 --no-check-certificate -S -q
}

check_http_port() {
   wget http://127.0.0.1:80 -S -q
}

#get_k8s_deploy_status() {
#  # The result of the evaluation is passed as arguments
#  # $1: stdout, $2: stderr, $3: status
#  echo "$1" | grep '.*1/1.*1.*1.*' -c
#}
