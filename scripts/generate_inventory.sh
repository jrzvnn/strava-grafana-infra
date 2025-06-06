#!/bin/bash

# Get root of the repo (one level up from scripts/)
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
TERRAFORM_DIR="$ROOT_DIR/terraform"
INVENTORY_FILE="$ROOT_DIR/ansible/inventory"

# Load Terraform outputs as JSON
TF_OUTPUT=$(terraform -chdir="$TERRAFORM_DIR" output -json)

# Parse IPs
GRAFANA_PRIVATE_IP=$(echo "$TF_OUTPUT" | jq -r '.grafana_ec2_id.value.private_ip')
NGINX_PUBLIC_IP=$(echo "$TF_OUTPUT" | jq -r '.nginx_ec2_id.value.eip_public_ip')

# Ensure ansible directory exists
mkdir -p "$(dirname "$INVENTORY_FILE")"

# Generate Ansible inventory
cat <<EOF > "$INVENTORY_FILE"
[grafana]
$GRAFANA_PRIVATE_IP ansible_user=ec2-user ansible_ssh_private_key_file=~/.ssh/ec2-ssh-key.pem ansible_ssh_common_args='-o StrictHostKeyChecking=no -o ProxyCommand="ssh -W %h:%p -i ~/.ssh/ec2-ssh-key.pem ec2-user@$NGINX_PUBLIC_IP"'

[nginx]
$NGINX_PUBLIC_IP ansible_user=ec2-user ansible_ssh_private_key_file=~/.ssh/ec2-ssh-key.pem ansible_ssh_common_args='-o StrictHostKeyChecking=no'
EOF

echo "Inventory generated at $INVENTORY_FILE"
