IMAGE        := stephenwolfe/terraformer
TAG          := latest
STATE_BUCKET := spw006-terraform.tfstate
TYPE         ?= services
NAME         ?= root-setup

# Terraform management
terraformer-svc := docker run \
	-it \
	--rm \
	-v $(PWD)/:/terraform \
	-v $(HOME)/.aws:/root/.aws \
	-v $(HOME)/.kube:/root/.kube \
	-v $(HOME)/.vault-token:/root/.vault-token \
	-e TF_DATA_DIR=/terraform/.terraform \
	-e VAULT_TOKEN \
	-e VAULT_ADDR \
	-e DIRECTORY=/terraform/${TYPE}/${NAME} \
	${IMAGE}:${TAG}

.PHONY: pull
pull: ## pull terraformer image
	@docker pull ${IMAGE}:${TAG}

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
