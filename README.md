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

## step 3: 

Setup your local DNS, my nodes are called rock1, rock2 and rock3 (aka master).

## step xx: install the cluster

sudo kubeadm init
