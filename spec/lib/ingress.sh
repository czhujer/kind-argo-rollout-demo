check_ingress_deploy() {
  kubectl -n ingress-nginx get deploy ingress-nginx-controller --no-headers=true  |awk -F ' ' '{ print $2 " " $3 " " $4}'
}

check_https_port() {
  wget https://127.0.0.1:443 --no-check-certificate -S -q
}

check_http_port() {
  wget http://127.0.0.1:80 -S -q
}

check_banana_app() {
  curl -kL http://localhost/banana -s
}

check_apple_app() {
  curl -kL http://localhost/apple -s
}
