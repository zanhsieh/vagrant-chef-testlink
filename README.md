vagrant-chef-testlink
=====================
This git intends to automate [Install testlink on CentOS](http://blog.codylab.com/install-testlink-on-centos/) with Ubuntu 12.04. It's also heavily influenced by [Chef-Metasploit](https://github.com/rapid7/Chef-Metasploit).

#### Requirements
 * [Vagrant](http://www.vagrantup.com/)
 * [VirtualBox](https://www.virtualbox.org/ "Oracle")

#### Installation
 1. Install Vagrant and VirtualBox.
 2. Clone vagrant-chef-testlink repository to a directory on your host machine.
 3. Initialize and update git submodules (run git submodule init; git submodule update; in cloned repo directory).
 4. Change bootstrap.sh in the directory you clone (sed line) with your local ubuntu official mirror.
 5. Invoke "vagrant up"

The included Vagrantfile will create a virtual machine and install TestLink.  Once the Vagrant guest machine is running TestLink can be accessed at http://localhost:8180/testlink.

#### Upgrade TestLink
Current TestLink installed is 1.9.2. To upgrade TestLink, follow these instructions:

 1. Copy the new version to {your clone path}/cookbooks/testlink/files/.
 2. Change {your clone path}/cookbooks/testlink/recipes/default.rb with new version filename (currently it's "testlink-1.9.2").

