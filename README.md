# rock64-kubernetes
My home rock64 kubernetes setup. The cluster consists of the following hardware:
* 3x Rock64 4GB SBCs with power supplies and heatsinks
* 3x 32GB eMMC memory cards
* Serial to USB adapter (important to debug and initial config)
* USB to eMMC adapter to flash the images to the eMMC module
* TP-Link 8-Port Gigabit Ethernet Easy Smart Switch
* A stackable case 
* Ethernet cables


## step 1: install Etcher on your laptop
You can install [Etcher](https://etcher.io/) on your laptop or desktop. You need the [USB to eMMC adapter](https://www.pine64.org/?product=usb-adapter-for-emmc-module) to flash the image to the eMMC module.

## step 2: flash the eMMC with Debian 
Download the [Debian Stretch](http://wiki.pine64.org/index.php/ROCK64_Software_Release#Debian_Stretch) for Rock64.

## step 3: Planning
- The network  : 192.168.178.0/24
- Gateway      : 192.168.178.1
- DNS          : 192.168.178.33 (Route55 on Synology)
- MetalLB CIDR : 192.168.178.16/28
    - 192.168.178.17 - 192.168.178.30
- Traefik (Int): 192.168.178.20
- Traefik (Ext): 192.168.178.21

Setup your local DNS, my nodes are called rock1, rock2 and rock3 (aka master).
Found the MAC addresses in the DHCP server (also on the Synology) and put them on the reserved IP list:

- Master Node: 192.168.178.212 (rock3 master)
- Slave2 Node: 192.168.178.211 (rock2)
- Slave1 Node: 192.168.178.210 (rock1)

## step 4: Configure each node
Perform the following steps to configure the nodes:

* Change the hostname on each node

    sudo vi /etc/hosts
    sudo vi /etc/hostname
    sudo hostname rock1   

    sudo service networking restart

* Disable IPv6

    sudo vi /etc/sysctl.conf

    net.ipv6.conf.all.disable_ipv6 = 1
    net.ipv6.conf.default.disable_ipv6 = 1
    net.ipv6.conf.lo.disable_ipv6 = 1
    net.ipv6.conf.eth0.disable_ipv6 = 1
    
    sudo sysctl -p
* Add user to Sudoers:

    visudo # Add to end of file:
    rock64 ALL=(ALL) NOPASSWD:ALL
    
## step 5: Install Docker/Kubernetes on each node ##
Execute the following script on each node:
./install_container_services.sh

## step xx: install the cluster

sudo kubeadm init







## Configure Loadbalancer ##
The loadbalancer in the Kubernetes Clusters is [MetalLB](https://metallb.universe.tf/installation/). Install metallb with:

kubectl apply -f https://raw.githubusercontent.com/google/metallb/v0.7.3/manifests/metallb.yaml

Now my home network has a range of 192.168.178.16/28 (this means that we have 4 bits available, 16 addresses but we can only use (192.168.178.17 - 192.168.178.30) that is specified 

kubectl apply -f metallb-conf.yaml
