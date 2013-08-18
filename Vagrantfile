# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  config.vm.network :forwarded_port, guest: 80, host: 8080

  config.vm.synced_folder "../acid", "/var/www"

  config.vm.provision :shell, :inline => "apt-get update --fix-missing"
  
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests/"
    puppet.module_path = "modules"
    puppet.manifest_file  = "project.pp"
  end

end
