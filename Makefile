IMAGE        := stephenwolfe/terraformer
TAG          := latest
STATE_BUCKET := spw006-terraform.tfstate
LOCK_TABLE   := terraform.tfstate.lock
REGION       := us-west-2
TYPE         ?= services
NAME         ?= root-setup
VAULT_ADDR   ?= https://vault.swolfe.io

# Terraform management
terraformer-svc := docker run \
	-it \
	--rm \
	-v $(PWD)/:/terraform \
	-v $(HOME)/.aws:/root/.aws \
	-v $(HOME)/.kube:/root/.kube \
	-v $(HOME)/.vault-token:/root/.vault-token \
	-e TF_DATA_DIR=/terraform/.terraform \
	-e TF_VAR_github_username=${GITHUB_USERNAME} \
	-e TF_VAR_github_token=${GITHUB_TOKEN} \
	-e TF_VAR_github_oauth_clientID=${GITHUB_OAUTH_CLIENTID} \
	-e TF_VAR_github_oauth_clientSecret=${GITHUB_OAUTH_CLIENTSECRET} \
	-e TF_VAR_cloudflare_api_token=${CLOUDFLARE_API_TOKEN} \
	-e VAULT_ADDR=${VAULT_ADDR} \
	-e VAULT_TOKEN \
	-e DIRECTORY=/terraform/${TYPE}/${NAME} \
	${IMAGE}:${TAG}

terraformer-shell := docker run \
	-it \
	--rm \
	-v $(PWD)/:/terraform \
	-v $(HOME)/.aws:/root/.aws \
	-v $(HOME)/.kube:/root/.kube \
	-v $(HOME)/.vault-token:/root/.vault-token \
	-e TF_DATA_DIR=/terraform/.terraform \
	-e VAULT_ADDR=${VAULT_ADDR} \
	-e VAULT_TOKEN \
	-e DIRECTORY=/terraform/${TYPE}/${NAME} \
	--entrypoint /bin/sh \
	${IMAGE}:${TAG}

.PHONY: pull
pull: ## pull terraformer image
	@touch $(HOME)/.vault-token
	@echo docker pull ${IMAGE}:${TAG}

.PHONY: init
init: pull ## run terraformer init
	@${terraformer-svc} init

.PHONY: validate
validate: pull init ## run terraformer validate
	@${terraformer-svc} validate

.PHONY: plan
plan: pull init ## run terraformer plan
	@${terraformer-svc} plan

.PHONY: apply
apply: pull init ## run terraformer apply
	@${terraformer-svc} apply

.PHONY: destroy
destroy: pull init ## run terraformer destroy
	@${terraformer-svc} destroy

.PHONY: shell
shell: pull ## run terraformer shell
	@${terraformer-shell}

.PHONY: docs
docs: ## run terraform-docs
	@terraform-docs --sort-by-required markdown table ${TYPE}/${NAME} > ${TYPE}/${NAME}/README.md


%: ## Do nothing on missing target
	@:

.PHONY:
create: ## create a new service directory
	@STATE_BUCKET=${STATE_BUCKET} \
	  LOCK_TABLE=${LOCK_TABLE} \
		REGION=${REGION} \
	  scripts/create_service.sh $(filter-out $@,$(MAKECMDGOALS))

# File management
PROFILE   ?= root

.PHONY: save-root
save-root: ## manually save root-setup terraform.state
	@aws s3 cp .terraform.tfstate/services/root-setup/terraform.tfstate \
		s3://${STATE_BUCKET}/services/root-setup-manual-upload/terraform.tfstate \
		--sse AES256 \
		--profile ${PROFILE}

.PHONY: fetch-root
fetch-root: ## manually fetch root-setup terraform.state
	@aws s3 cp s3://${STATE_BUCKET}/services/root-setup-manual-upload/terraform.tfstate \
		.terraform.tfstate/services/root-setup/terraform.tfstate \
		--profile ${PROFILE}

.PHONY: clean
clean: save-root ## clean up terraform directories
	@find . -name .terraform | xargs rm -rf &&\
	find . -name .terraform.tfstate | xargs rm -rf &&\
	find . -name errored.tfstate | xargs rm

.PHONY: help
help: ## show this usage
	@echo "\033[36mTerraform repo:\033[0m\n\n\tUsage: NAME=\$${services} make [target]\n"; \
	grep -E '^[a-zA-Z0-9._-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help
