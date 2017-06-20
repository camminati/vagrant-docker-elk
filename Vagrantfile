# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
  # https://docs.vagrantup.com.

 config.vm.define "elk" do |elk|
    elk.vm.box = "ubuntu/trusty64"
    elk.vm.hostname = "elk.localhost"
    elk.vm.network "private_network", ip: "10.0.0.15"
    elk.vm.network "forwarded_port", guest: 5601, host: 5601
    elk.vm.network "forwarded_port", guest: 9200, host: 9200
    elk.vm.network "forwarded_port", guest: 5044, host: 5044
    elk.vm.provision :shell, path: "provision/bootstrap.sh", privileged: false
    elk.vm.provider "virtualbox" do |virtualbox|
      virtualbox.memory = 5120
    end
    elk.vm.synced_folder "docker/images/", "/docker/images"
  end
end
