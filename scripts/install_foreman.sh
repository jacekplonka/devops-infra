#!/bin/sh
sudo mv /tmp/hosts /etc/hosts
#sudo sh -c 'echo "Defaults        secure_path=\"/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin:/opt/puppetlabs/bin/puppet\"" > /etc/sudoers.d/path'
sudo apt-get -y install ca-certificates
cd /tmp && wget https://apt.puppet.com/puppet6-release-bionic.deb
sudo dpkg -i /tmp/puppet6-release-bionic.deb
echo "deb http://deb.theforeman.org/ bionic 2.3" | sudo tee /etc/apt/sources.list.d/foreman.list
echo "deb http://deb.theforeman.org/ plugins 2.3" | sudo tee -a /etc/apt/sources.list.d/foreman.list
sudo apt-get -y install ca-certificates
wget -q https://deb.theforeman.org/pubkey.gpg -O- | sudo apt-key add -
sudo apt-get update && sudo apt-get -y install foreman-installer
sudo foreman-installer --foreman-initial-admin-password admin
sleep 60
sudo /opt/puppetlabs/bin/puppet agent --test
sudo /opt/puppetlabs/bin/puppet module install puppet-gitlab
sudo sh -c "echo '*' > /etc/puppetlabs/puppet/autosign.conf"

