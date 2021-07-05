.PHONY: kind-setup
kind-setup:
	scripts/kind-setup.sh

.PHONY: kind-setdown
kind-setdown:
	kind delete cluster  --name "test-argo-rollout"

.PHONY: install-argo-rollouts
install-argo-rollouts:
	kubectl create namespace argo-rollouts
	kubectl apply -n argo-rollouts -f https://github.com/argoproj/argo-rollouts/releases/latest/download/install.yaml

.PHONY: install-nginx-ingress
install-nginx-ingress:
	kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/kind/deploy.yaml
	kubectl delete validatingwebhookconfigurations.admissionregistration.k8s.io ingress-nginx-admission

.PHONY: install-nginx-test-deploy
install-nginx-test-deploy:
	kubectl create namespace ingress-test || true
	kubectl -n ingress-test apply -f k8s/banana-apple-app

.PHONY: install-argo-bg-demo
install-argo-bg-demo:
	kubectl create namespace argo-bg-demo || true
	kustomize build https://github.com/argoproj/rollouts-demo.git/examples/blue-green | kubectl -n argo-bg-demo apply -f -

.PHONY: run-shellspec
run-shellspec:
	 shellspec -o j -f d

#.PHONY: kind-run-integration-tests
#kind-run-integration-tests:
#	PYTEST_ADDOPTS="-v" \
#	KUBECONFIG=~/.kube/config \
#	pytest --disable-pytest-warnings \
#	tests/integration/tests

.PHONY: run-k6s-io
run-k6s-io:
#	export MY_HOSTNAME="http://blue-green-preview.dev.argoproj.io/";
	echo "$$MY_HOSTNAME"
	docker run --name k6s-local --rm \
		--add-host blue-green-preview.dev.argoproj.io:172.17.0.1 \
		--add-host blue-green.dev.argoproj.io:172.17.0.1 \
		-v `pwd`/tests/performance/basic.js:/basic.js \
		loadimpact/k6:latest \
		run -e MY_HOSTNAME=$$MY_HOSTNAME \
		/basic.js
