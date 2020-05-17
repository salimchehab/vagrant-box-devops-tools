# DevOps Basic Tools Box

This is a general purpose box with the most commonly used packages I need installed. The Docker alternative is available [here](https://github.com/salimchehab/docker-image-devops-tools). 
Installed tools include:

- Terraform v0.12.25
- Terraform AWS Provider version 2.62.0
- Vault v1.4.1
- aws-cli version 1.18.40
- Python 3.6.9
- Salt 2017.7.4 (Nitrogen)
- Ansible 2.9.1

# Prerequisites

Make sure [VirtualBox](https://www.virtualbox.org/wiki/Downloads) and [Vagrant](https://www.vagrantup.com/downloads.html) are installed.

Ensure that hardware virtualization support is turned on in the BIOS settings if using a Windows machine (enable `VT-x` on Intel processors).

Vagrant 2.2.5 was used for the below setup:
```text
$ vagrant --version
Vagrant 2.2.5
```

# Vagrant Provisioning

`vagrant up` will bring up the machine and provision it with the available [bash script](./provision.sh).

The amount of cores and memory dedicated can be changed inside the [Vagrantfile](./Vagrantfile) with the `HOST_CPUS` and `HOST_MEMORY` variables. 

Check that the machine is running:
```text
$ vagrant status
Current machine states:

tools                     running (virtualbox)
```

Use `vagrant ssh` to log in and check the installed versions from inside the machine:
```text
vagrant@ubuntu-bionic:~$ uname -a
Linux ubuntu-bionic 4.15.0-99-generic #100-Ubuntu SMP Wed Apr 22 20:32:56 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
vagrant@ubuntu-bionic:~$ terraform --version
Terraform v0.12.25
vagrant@ubuntu-bionic:~$ ls -lh  ~/.terraform.d/plugins/
total 147M
-rwxr-xr-x 1 vagrant vagrant 147M May 15 00:10 terraform-provider-aws_v2.62.0_x4
vagrant@ubuntu-bionic:~$ vault --version
Vault v1.4.1
vagrant@ubuntu-bionic:~$ aws --version
aws-cli/1.18.40 Python/3.6.9 Linux/4.15.0-99-generic botocore/1.15.40
vagrant@ubuntu-bionic:~$ salt --version
salt 2017.7.4 (Nitrogen)
vagrant@ubuntu-bionic:~$ ansible --version
ansible 2.9.2
  config file = None
  configured module search path = ['/home/vagrant/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /home/vagrant/.local/lib/python3.6/site-packages/ansible
  executable location = /home/vagrant/.local/bin/ansible
  python version = 3.6.9 (default, Apr 18 2020, 01:56:04) [GCC 8.4.0]
```
