TF_DEV=terraform/environments/dev
TF_K3S=terraform/environments/k3s
TF_SECURITY=terraform/environments/security
ANSIBLE_DIR=ansible

.PHONY: help
help:
	@echo "Available targets:"
	@echo "  make fmt"
	@echo "  make validate"
	@echo "  make k3s-plan"
	@echo "  make k3s-apply"
	@echo "  make k3s-destroy"
	@echo "  make ansible-k3s"
	@echo "  make security-plan"

# -------------------------
# Terraform Formatting
# -------------------------

fmt:
	terraform fmt -recursive terraform/

validate:
	cd $(TF_K3S) && terraform init -backend=false
	cd $(TF_K3S) && terraform validate

# -------------------------
# k3s Environment
# -------------------------

k3s-init:
	cd $(TF_K3S) && terraform init

k3s-plan:
	cd $(TF_K3S) && terraform plan

k3s-apply:
	cd $(TF_K3S) && terraform apply -auto-approve

k3s-destroy:
	cd $(TF_K3S) && terraform destroy -auto-approve

# -------------------------
# Security Environment
# -------------------------

security-init:
	cd $(TF_SECURITY) && terraform init

security-plan:
	cd $(TF_SECURITY) && terraform plan

security-apply:
	cd $(TF_SECURITY) && terraform apply -auto-approve

# -------------------------
# Ansible
# -------------------------

ansible-k3s:
	ansible-playbook \
	-i $(ANSIBLE_DIR)/inventory/k3s.ini \
	$(ANSIBLE_DIR)/playbooks/site.yaml

ansible-security:
	ansible-playbook \
	-i $(ANSIBLE_DIR)/inventory/security.ini \
	$(ANSIBLE_DIR)/playbooks/site.yaml

# -------------------------
# Combined Workflow
# -------------------------

deploy-k3s:
	make k3s-apply
	make ansible-k3s