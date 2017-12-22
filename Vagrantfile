# -*- mode: ruby -*-
# vi: set ft=ruby :

##
## Application Security Threat Attack Modeling (ASTAM)
##
## Copyright (C) 2017 Applied Visions - http://securedecisions.com
##
## Written by Aspect Security - http://aspectsecurity.com
##
## Licensed under the Apache License, Version 2.0 (the "License");
## you may not use this file except in compliance with the License.
## You may obtain a copy of the License at
##
##     http://www.apache.org/licenses/LICENSE-2.0
##
## Unless required by applicable law or agreed to in writing, software
## distributed under the License is distributed on an "AS IS" BASIS,
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
## See the License for the specific language governing permissions and
## limitations under the License.
##

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
	config.vm.box = "ubuntu/trusty64"
	config.vm.box_check_update = true
   
	# Create a public network, which generally matched to bridged network.
	# Bridged networks make the machine appear as another physical device on
	# your network.
	
	config.vm.network "forwarded_port", guest: 8080, host: 8080 
   
   config.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
      vb.cpus = 2
   end
 
#   config.vm.provision "shell", inline: <<-SHELL
#	apt-get update

#SHELL
	config.vm.provision :shell, path: "bootstrap.sh"
	config.vm.provision :shell, inline: "/downloadedApps/dotcms-3.3.1/bin/startup.sh", run: "always"
end
