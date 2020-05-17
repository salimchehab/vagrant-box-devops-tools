#!/bin/bash

readonly home_dir_vagrant="/home/vagrant"
readonly SALT_VERSION="2017.7.4+dfsg1-1ubuntu18.04.1"
readonly TERRAFORM_VERSION="0.12.25"
readonly TERRAFORM_PROVIDER_VERSION="2.62.0"
readonly VAULT_VERSION="1.4.1"
readonly TERRAFORM_ZIP_FILE="terraform_${TERRAFORM_VERSION}_linux_amd64.zip"
readonly TERRAFORM_DOWNLOAD_LINK="https://releases.hashicorp.com/terraform/$TERRAFORM_VERSION/$TERRAFORM_ZIP_FILE"
readonly TERRAFORM_PROVIDER_ZIP_FILE="terraform-provider-aws_${TERRAFORM_PROVIDER_VERSION}_linux_amd64.zip"
readonly TERRAFORM_PROVIDER_DOWNLOAD_LINK="https://releases.hashicorp.com/terraform-provider-aws/${TERRAFORM_PROVIDER_VERSION}/${TERRAFORM_PROVIDER_ZIP_FILE}"
readonly VAULT_ZIP_FILE="vault_${VAULT_VERSION}_linux_amd64.zip"
readonly VAULT_DOWNLOAD_LINK="https://releases.hashicorp.com/vault/${VAULT_VERSION}/${VAULT_ZIP_FILE}"
# plugin locations: ~/.terraform.d/plugin or ~/.terraform.d/plugins/<OS>_<ARCH>
readonly TERRAFORM_PLUGIN_DIR="${home_dir_vagrant}/.terraform.d/plugins"
# These are the required packages to be installed and checked
declare -ra os_packages=(
  "git"
  "wget"
  "unzip"
  "jq"
  "python3-dev"
  "python3-pip"
  "salt-api=${SALT_VERSION}"
  "salt-cloud=${SALT_VERSION}"
  "salt-master=${SALT_VERSION}"
  "salt-minion=${SALT_VERSION}"
  "salt-ssh=${SALT_VERSION}"
  "salt-syndic=${SALT_VERSION}"
)

declare -ra pip_requirements=(
  "awscli==1.18.40"
  "ansible==2.9.2"
)

function install_os_packages() {

  apt -y update && apt install -y "${os_packages[@]}"
}

function install_pip_packages() {

  pip3 install --upgrade pip
  for pip_requirement in "${pip_requirements[@]}"; do
    su - vagrant -c "pip3 install ${pip_requirement} --upgrade --user"
  done
}

function configure_binaries() {

  # get Terraform
  wget --quiet --directory-prefix="/tmp" "${TERRAFORM_DOWNLOAD_LINK}" &&
    unzip -o "/tmp/${TERRAFORM_ZIP_FILE}" -d /usr/local/bin/ &&
    rm "/tmp/${TERRAFORM_ZIP_FILE}"

  # get Terraform AWS plugin
  mkdir -p "${TERRAFORM_PLUGIN_DIR}" &&
    wget --quiet --directory-prefix="${TERRAFORM_PLUGIN_DIR}" "${TERRAFORM_PROVIDER_DOWNLOAD_LINK}" &&
    unzip -o "${TERRAFORM_PLUGIN_DIR}/${TERRAFORM_PROVIDER_ZIP_FILE}" -d "${TERRAFORM_PLUGIN_DIR}" &&
    rm "${TERRAFORM_PLUGIN_DIR}/${TERRAFORM_PROVIDER_ZIP_FILE}"

  # get Vault
  wget --quiet --directory-prefix="/tmp" "${VAULT_DOWNLOAD_LINK}" &&
    unzip -o "/tmp/${VAULT_ZIP_FILE}" -d /usr/local/bin/ &&
    rm "/tmp/${VAULT_ZIP_FILE}"
}

function main() {

  printf "[INFO]: %s\n" "Calling the following function: install_os_packages"
  install_os_packages

  printf "[INFO]: %s\n" "Calling the following function: install_pip_packages"
  install_pip_packages

  printf "[INFO]: %s\n" "Calling the following function: configure_binaries"
  configure_binaries

  # vagrant owns all files in the home dir
  chown -R vagrant:vagrant $home_dir_vagrant
}

main
