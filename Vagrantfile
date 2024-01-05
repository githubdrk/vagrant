# Specify the base box for your virtual machines
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"  # Replace with your preferred box

  # Define a master node with 2 CPUs
  config.vm.define "k8s-master" do |master|
    master.vm.provider "virtualbox" do |vb|
      vb.cpus = 2
      vb.memory = "2048"  # Adjust memory as needed
    end
    master.vm.hostname = "k8s-master"
    config.vm.network "public_network", bridge: "Your_Physical_Network_Interface_Name"
    # Provisioning script for Kubernetes installation on master
    master.vm.provision "shell", path: "provision-master.sh"
  end

  # Define a worker node with 2 CPUs
  config.vm.define "k8s-worker" do |worker|
    worker.vm.provider "virtualbox" do |vb|
      vb.cpus = 2
      vb.memory = "2048"  # Adjust memory as needed
    end
    worker.vm.hostname = "k8s-worker"
    # Provisioning script for Kubernetes worker node setup
    config.vm.network "public_network", bridge: "Your_Physical_Network_Interface_Name"
    worker.vm.provision "shell", path: "provision-worker.sh"
  end
end
