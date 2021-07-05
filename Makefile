.PHONY: kind-setup
kind-setup:
	scripts/kind-setup.sh

.PHONY: kind-setdown
kind-setdown:
	kind delete cluster  --name "test-argo-rollout"

.PHONY: install-nginx-ingress
install-nginx-ingress:
	kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/kind/deploy.yaml

.PHONY: run-shellspec
run-shellspec:
	 shellspec -o j -f d

#.PHONY: kind-install-chart
#kind-install-chart:

#.PHONY: kind-run-integration-tests
#kind-run-integration-tests:
#	PYTEST_ADDOPTS="-v" \
#	KUBECONFIG=~/.kube/config \
#	pytest --disable-pytest-warnings \
#	tests/integration/tests
#
#.PHONY: run-k6s-io
#run-k6s-io:
#	export MY_HOSTNAME="test-api.k6.io";
#	echo $MY_HOSTNAME;
#	docker run --name k8s-local --rm \
#	-v `pwd`/tests/performance/basic.js:/basic.js \
#	loadimpact/k6:latest \
#	run -e MY_HOSTNAME=$MY_HOSTNAME \
#	/basic.js
