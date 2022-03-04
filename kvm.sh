#!/bin/bash
# Virtualização ARCHLINUX

sudo pacman -S virt-manager qemu qemu-arch-extra ovmf vde2 ebtables dnsmasq bridge-utils openbsd-netcat spice-vdagent

sudo systemctl enable libvirtd.service

sudo systemctl start libvirtd.service

sudo usermod -aG libvirt shaka

sudo virsh net-autostart --network default

exit

