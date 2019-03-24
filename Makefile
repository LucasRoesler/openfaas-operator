.PHONY: build build-armhf push test verify-codegen ci-armhf-build ci-armhf-push ci-arm64-build ci-arm64-push
TAG?=latest

build:
	docker build -t openfaas/openfaas-operator:$(TAG) . -f Dockerfile

build-armhf:
	docker build -t openfaas/openfaas-operator:$(TAG)-armhf . -f Dockerfile.armhf

push:
	docker push openfaas/openfaas-operator:$(TAG)

test:
	go test ./...

verify-codegen:
	./hack/verify-codegen.sh

ci-certify:
	./contrib/get_kind.sh
	./contrib/install_kubectl.sh
	./contrib/create_kind_cluster.sh
	./contrib/install_helm.sh
	./contrib/install_tiller.sh
	./contrib/deploy.sh
	./contrib/certify.sh

ci-armhf-build:
	docker build -t openfaas/openfaas-operator:$(TAG)-armhf . -f Dockerfile.armhf

ci-armhf-push:
	docker push openfaas/openfaas-operator:$(TAG)-armhf

ci-arm64-build:
	docker build -t openfaas/openfaas-operator:$(TAG)-arm64 . -f Dockerfile.arm64

ci-arm64-push:
	docker push openfaas/openfaas-operator:$(TAG)-arm64
