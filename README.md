# To Note

This is customized to have k8s tools installed to help jump start testing. Feel free to customize this for other purposes as you see fit.

# Provision Ubuntu VMs with Vagrant-VMware on Apple Silicon (M1/M2)
This repo aims to provision Ubuntu virtual machines (VMs) with [Vagrant](https://developer.hashicorp.com/vagrant) and [VMware Fusion](https://www.vmware.com/products/fusion.html) on Apple Silicon (M1/M2).
### Using the Ubuntu-ARM64 Vagrant Box
Since VMware Fusion only supports running ARM on ARM, the Vagrant Box used in this repo is [`bento/ubuntu-22.04-arm64`](https://app.vagrantup.com/bento/boxes/ubuntu-22.04-arm64) which is a Ubuntu-ARM64 box, instead of x86.
### Prerequisites
- [Vagrant v2.4.3](https://developer.hashicorp.com/vagrant/downloads) as well as [Plugin](https://developer.hashicorp.com/vagrant/docs/providers/vmware/installation) and [Utility](https://developer.hashicorp.com/vagrant/docs/providers/vmware/vagrant-vmware-utility)
- [VMware Fusion Player v13.0 (Free Personal Use License)](https://www.vmware.com/products/desktop-hypervisor/workstation-and-fusion)
- If you have issues installing the plugin, use `export VAGRANT_DISABLE_STRICT_DEPENDENCY_ENFORCEMENT=1` in your shell config. (Ref - [hashicorp/vagrant/issues/13510](https://github.com/hashicorp/vagrant/issues/13510#issuecomment-2431163553))
### Directory Structure
```
.
├── README.md
├── Vagrantfile
└── scripts
    ├── collect-host-ip.sh
    └── setup-hosts.sh

1 directory, 4 files
```
### Usage
Provision VMs.
```
cd vagrant-vmware-arm
vagrant status
vagrant up
```
SSH to the VMs.
```
vagrant ssh [hostname]
```
Suspend the VMs.
```
vagrant suspend
```
### Troubleshooting
#### Unexpected communications error
If you encountered the following error when running the vagrant commands.
```
Vagrant encountered an unexpected communications error with the
Vagrant VMware Utility driver. Please try to run the command
again. If this error persists, please open a new issue at:

  https://github.com/hashicorp/vagrant-vmware-desktop/issues
```
Try to upgrade Vagrant and the Vagrant Utility to the latest version.
```
# upgrade vagrant
brew update && brew upgrade hashicorp-vagrant

# upgrade vagrant utility
brew update && brew upgrade vagrant-vmware-utility
```
