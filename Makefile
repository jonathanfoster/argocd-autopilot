SHELL = /usr/bin/env bash -o pipefail
.SHELLFLAGS = -ec

KIND_CLUSTER_NAME ?= argocd-autopilot

.PHONY: all
all: help

##@ Available Tasks:

.PHONY: kind-create
kind-create: ## Create kind cluster
	kind create cluster --name=${KIND_CLUSTER_NAME}

.PHONY: kind-delete
kind-delete: ## Delete kind cluster
	kind delete cluster --name=${KIND_CLUSTER_NAME}

.PHONY: help
help: ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make <task>\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  %-15s %s\n", $$1, $$2 } /^##@/ { printf "\n%s\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.PHONY: install-toolchain
install-toolchain: ## Install toolchain
	brew install argocd-autopilot
