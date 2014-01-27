# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"
NODES = 10
BASEIP = 5
IP_PRE = "10.42.0."
DOMAIN = "yeti"

opts = []

Dir.glob('./system/hosts.d/*.host').each { |f| File.delete(f) }

(1..NODES).each do |n|
    opts[n] = { :name => "node#{n}", :hostname => "node#{n}.#{DOMAIN}", :ip => "#{IP_PRE}#{BASEIP + n.to_i}" }
    File.open("./system/hosts.d/03-#{opts[n][:name]}.hosts", 'w') do |hostfile|
      hostfile.puts "#{opts[n][:ip]}       #{opts[n][:name]} #{opts[n][:hostname]} "  
    end
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |vagrant|

  (1..NODES).each do |n|

    name = opts[n][:name]
    hostname = opts[n][:hostname]
    ip   = opts[n][:ip]

    vagrant.vm.define name do |config|
      config.vm.box = "ubuntu-server-12042-x64-vbox4210.box"
      config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-12042-x64-vbox4210.box"
      
      config.vm.provider "virtualbox" do |v|
        v.name = hostname
        v.customize ["modifyvm", :id, "--cpus", "2"]
        v.customize ["modifyvm", :id, "--memory", "512"]
      end

      config.vm.host_name = hostname

      config.vm.network :private_network, ip: "#{ip}"
      config.vm.network "forwarded_port", guest: 80, host: "800#{n}".to_i
      config.vm.network "forwarded_port", guest: 8098, host: "809#{n}".to_i
      config.vm.network "forwarded_port", guest: 8080, host: "808#{n}".to_i
      #config.vm.network "forwarded_port", guest: 22, host: "220#{n}".to_i
      
      config.vm.synced_folder ".", "/opt/occam"

      # config.ssh.forward_agent = true
      config.vm.provision :shell, :inline => "sudo sh -c 'cat /opt/occam/system/hosts.d/*.hosts >> /etc/hosts'"
      config.vm.provision "puppet" do |puppet|
        #puppet.working_directory = "/tmp/vagrant-puppet"
        #puppet.options = "--hiera_config /opt/occam/hiera.yaml"
        puppet.manifests_path = "puppet/manifests"
        puppet.module_path = "puppet/modules"
        puppet.manifest_file = "site.pp"
        puppet.options = [ '--verbose', '--debug', 
          '--hiera_config /opt/occam/hiera.yaml', 
          '--graph', "--graphdir /opt/occam/puppet/graphs/#{name}/"]
      end
    end
  end
end
