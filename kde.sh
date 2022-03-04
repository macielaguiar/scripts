#!/bin/bash

sudo timedatectl set-ntp true
sudo hwclock --systohc

sudo reflector -c Brazil -a 6 --sort rate --save /etc/pacman.d/mirrorlist

sudo firewall-cmd --add-port=1025-65535/tcp --permanent
sudo firewall-cmd --add-port=1025-65535/udp --permanent
sudo firewall-cmd --reload

sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay-bin.git
#cd yay-bin/
#makepkg -si 


#pikaur -S --noconfirm system76-power
#sudo systemctl enable --now system76-power
#sudo system76-power graphics integrated
#pikaur -S --noconfirm auto-cpufreq
#sudo systemctl enable --now auto-cpufreq


sudo pacman -S xorg xorg-server sddm plasma plasma-wayland-session ark dolphin okular elisa gwenview ffmpegthumbs spectacle partitionmanager konsole chromium pavucontrol simplescreenrecorder pacman-contrib obs-studio vlc papirus-icon-theme kdenlive materia-kde

#sudo flatpak install -y spotify

sudo systemctl enable sddm
#/bin/echo -e "\e[1;32mREBOOTING IN 5..4..3..2..1..\e[0m"
#sleep 5
#reboot
