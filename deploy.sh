#!/bin/bash

set -e

echo "[*] Running Terraform..."
 cd terraform
# terraform init
# terraform apply -auto-approve

echo "[*] Getting Terraform outputs..."
echo "[*] Generating Ansible inventory..."
cd ..
bash ./scripts/generate_inventory.sh

echo "[*] Running Ansible playbook..."
ansible-playbook -i ansible/inventory ansible/playbook.yml -vvv

