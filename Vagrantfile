Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.network :forwarded_port, guest: 80, host: 80
  config.vm.provision :shell, :path => ".provision/bootstrap.sh"
end