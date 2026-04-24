#!/bin/bash
set -euo pipefail

# Variables
TERRAFORM_VERSION="1.7.5"   # Change to desired version
TERRAFORM_ZIP="terraform_${TERRAFORM_VERSION}_linux_amd64.zip"
DOWNLOAD_URL="https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/${TERRAFORM_ZIP}"

# Update system
sudo yum update -y

# Install dependencies
sudo yum install -y wget unzip

# Download Terraform
wget -q "${DOWNLOAD_URL}" -O "${TERRAFORM_ZIP}"

# Unzip and move binary
unzip -o "${TERRAFORM_ZIP}"
sudo mv terraform /usr/local/bin/

# Verify installation
terraform -version

# Cleanup
rm -f "${TERRAFORM_ZIP}"

echo "Terraform ${TERRAFORM_VERSION} installed successfully!"
