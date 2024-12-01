# -*- mode: ruby -*-
# vi:set ft=ruby sw=2 ts=2 sts=2:

# Define the number of nodes
NUM_NODE = 1

Vagrant.configure("2") do |config|

  config.vm.provider "vmware_desktop"
  config.vm.box = "bento/ubuntu-22.04-arm64"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  config.vm.box_check_update = false
  config.disksize.size = '25GB'

  (1..NUM_NODE).each do |i|
    config.vm.define "vm0#{i}" do |node|
      node.vm.provider "vmware_desktop" do |vmware|
        vmware.cpus = 4
        vmware.memory = 4096
        # vmware.gui = true
        vmware.vmx["ethernet0.virtualdev"] = "vmxnet3"
      end
      node.vm.hostname = "vm0#{i}"
      node.vm.network "forwarded_port", guest: 22, host: "#{2720 + i}"

      node.vm.provision "setup-hosts", :type => "shell", :path => "scripts/setup-hosts.sh" do |s|
        s.args = ["eth0"]
      end
      node.vm.provision "install-docker", type: "shell", :path => "scripts/install-docker.sh"
      node.vm.provision "install-mise", type: "shell", :path => "scripts/install-mise.sh"
    end
  end
end
