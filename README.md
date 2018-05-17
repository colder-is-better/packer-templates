# Packer templates for (open)SUSE machine images
This repository initially contained a single Packer template for VirtualBox, VMware Fusion, and QEMU machine images. All three VMs host openSUSE Leap 42.3 which, thanks to AutoYaST, is automatically installed during build time. The template (file `leap423srv.json`) is based on [42.3-x86.json](https://raw.githubusercontent.com/openSUSE/vagrant/master/definitions/42.3-x86_64.json), from the [openSUSE/Vagrant](https://github.com/openSUSE/vagrant) repository. Included is also a simple shell provisioner (`leap423srv.prov.sh`). The script is called by Packer immediately after the installation of the guest OS. Its task is to remove the standard offline repository added by the installer, add four new online repositories (OSS, Non-OSS, OSS Updates, and Non-OSS Updates), and then bring the system up-to-date.

_The repository has been created to complement this [extensive presentation and HOWTO of Packer](https://deltahacker.gr/?p=17969), written for [deltaHacker magazine](https://deltahacker.gr) (text in Greek, active subscription may be required)._

__Update 2018-05-17.__ Added a new Packer template, AutoYaST profile, and shell provisioner, for creating QEMU machine images with SLES12SP3. Those files may only be used by SUSE employees, internally.
