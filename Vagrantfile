# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "debian/buster64"

  config.vm.provision "shell", inline: <<-SHELL
    apt-get install -y build-essential gcc-multilib
  SHELL
end
