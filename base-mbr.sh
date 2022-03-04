#!/bin/bash

ln -sf /usr/share/zoneinfo/America/Araguaina /etc/localtime
hwclock --systohc
sed -i '/pt_BR.UTF-8 UTF-8/s/^#//' /etc/locale.gen
locale-gen
echo "LANG=pt_BR.UTF-8" >> /etc/locale.conf
echo "KEYMAP=br-abnt2" >> /etc/vconsole.conf
echo "archlinux" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 archlinux.localdomain archlinux" >> /etc/hosts
echo root:admin | chpasswd

# You can add xorg to the installation packages, I usually add it at the DE or WM install script
# You can remove the tlp package if you are installing on a desktop or vm

pacman -S grub networkmanager network-manager-applet iwd dialog wpa_supplicant mtools dosfstools reflector base-devel linux-headers util-linux avahi xdg-user-dirs xdg-utils git nano vim gvfs gvfs-afc gvfs-goa gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-google gvfs-smb nfs-utils inetutils dnsutils bash-completion openssh rsync reflector acpi acpi_call tlp virt-manager qemu qemu-arch-extra qemu-guest-agent edk2-ovmf bridge-utils spice-vdagent dnsmasq vde2 openbsd-netcat iptables-nft ipset firewalld flatpak sof-firmware  nss-mdns acpid os-prober ntfs-3g terminus-font

# pacman -S --noconfirm xf86-video-amdgpu
pacman -S nvidia nvidia-utils nvidia-settings nvidia-dkms opencl-nvidia

grub-install --target=i386-pc /dev/sda # replace sdx with your disk name, not the partition
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
#systemctl enable bluetooth
#systemctl enable cups.service
systemctl enable sshd
systemctl enable avahi-daemon
#systemctl enable tlp # You can comment this command out if you didn't install tlp, see above
systemctl enable reflector.timer
#systemctl enable fstrim.timer
systemctl enable libvirtd
systemctl enable firewalld
systemctl enable acpid

useradd -m -g users -G audio,lp,optical,storage,video,wheel,games,power,scanner -s /bin/bash ghost	
echo ghost:admin | chpasswd
usermod -aG libvirt ghost
cp -v /etc/sudoers /etc/sudoers.back
sed -i '/%wheel ALL=(ALL) ALL/s/^#//' /etc/sudoers
mkdir -p /etc/sudoers.d/
touch /etc/sudoers.d/ghost
echo "ghost ALL=(ALL) ALL" >> /etc/sudoers.d/ghost


printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"




