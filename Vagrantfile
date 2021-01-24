# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/bionic64"

  config.vm.define "foreman" do |foreman|
    config.vm.provider "virtualbox" do |v|
      v.memory = 4096
      v.cpus = 2
    end
    foreman.vm.hostname = "foreman.local"
    foreman.vm.network "private_network", ip: "10.0.0.2"
    foreman.vm.network "forwarded_port", guest: 80, host: 80, host_ip: "127.0.0.1"
    foreman.vm.network "forwarded_port", guest: 443, host: 443, host_ip: "127.0.0.1"
    foreman.vm.provision "file", source: "./files/hosts", destination: "/tmp/hosts"
    foreman.vm.provision "shell", path: "./scripts/install_foreman.sh"
    foreman.vm.synced_folder "puppet/", "/etc/puppetlabs/code/environments/production/manifests/", owner: "root", group: "root"
  end
  
  config.vm.define "gitlab" do |gitlab|
    config.vm.provider "virtualbox" do |v|
      v.memory = 4096
      v.cpus = 2
    end
    gitlab.vm.hostname = "gitlab.local"
    gitlab.vm.network "private_network", ip: "10.0.0.3"
    gitlab.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
    gitlab.vm.network "forwarded_port", guest: 443, host: 4434, host_ip: "127.0.0.1"
    gitlab.vm.provision "file", source: "./files/hosts", destination: "/tmp/hosts"
    gitlab.vm.provision "shell", inline: "sudo mv /tmp/hosts /etc/hosts"
    gitlab.vm.provision "shell", path: "./scripts/install_puppet_agent.sh"
  end
  

  # config.vm.define "puppet_master" do |puppet|
  #   puppet.vm.hostname = "puppet.local"
  #   puppet.vm.network "private_network", ip: "10.0.0.2"
  #   puppet.vm.provision "shell", path: "./install_puppet_agent.sh"
  #   puppet.vm.provision "shell", inline: <<-SHELL
  #     wget https://apt.puppet.com/puppet7-release-bionic.deb && \
  #     sudo dpkg -i puppet7-release-bionic.deb && \
  #     sudo apt-get update && \
  #     sudo apt install openjdk-11-jdk -y && \
  #     sudo apt-get install puppetserver -y && \
  #     sudo sed -i 's/-Xms2g -Xmx2g/-Xms512m -Xmx512m/g' /etc/default/puppetserver && \
  #     sudo systemctl enable puppetserver && \
  #     sudo systemctl start puppetserver && \
  #     sleep 30 && \
  #     puppetserver -v 
      
  #     sudo sh -c "echo '10.0.0.3 jenkins.local jenkins' >> /etc/hosts"
  #     sudo sh -c "echo '*' > /etc/puppetlabs/puppet/autosign.conf"
  #     sleep 40
      
  #   SHELL
  #   puppet.vm.provision "file", source: "./puppet/site.pp", destination: "/tmp/site.pp"
  #   puppet.vm.provision "shell", inline: "mv /tmp/site.pp /etc/puppetlabs/code/environments/production/manifests/site.pp"
  
  # end

  # config.vm.define "jenkins_master" do |jenkins|
  #   jenkins.vm.network "private_network", ip: "10.0.0.3"
  #   jenkins.vm.network "forwarded_port", guest: 8080, host: 8080, host_ip: "127.0.0.1"
  #   jenkins.vm.hostname = "jenkins.local"
  #   jenkins.vm.provision "shell", path: "./install_puppet_agent.sh"
    
  #   jenkins.vm.provision "shell", inline: <<-SHELL
  #     sudo sh -c "echo '10.0.0.2 puppet.local puppet' >> /etc/hosts"
  #     sleep 40
  #     # wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
  #     # sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
  #     # sudo apt-get update
  #     # sudo apt install openjdk-11-jdk -y && sudo apt-get install jenkins -y && sudo systemctl start jenkins
      
  #   SHELL
  #   jenkins.vm.provision "puppet_server" do |puppet|
  #     puppet.puppet_server = "puppet.local"
  #   end
  # end
end
