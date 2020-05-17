# -*- mode: ruby -*-
# vi: set ft=ruby :

HOST_CPUS = 2
HOST_MEMORY = 4096

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/bionic64"

  # local synced folder is enabled by default; uncomment below to disable it
  # config.vm.synced_folder ".", "/vagrant", disabled: false

  config.vm.provider "virtualbox" do |vb|
    vb.memory = HOST_MEMORY
    vb.cpus = HOST_CPUS
  end

  provision_script_path = "./provision.sh"

  config.vm.define "tools" do |tools|
    tools.vm.provision "shell", path: provision_script_path
  end
end
