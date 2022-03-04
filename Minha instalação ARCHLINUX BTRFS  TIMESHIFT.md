ARCHLINUX BTRFS

1. Configurar teclado abnt2.

# loadkeys br-abnt2

2. Verificar modo de inicializaçao.

# ls /sys/firmware/efi/efivars

3. Verificar conexão com internet.

# ip a
# ping archlinux.org

4. Conexão via WIFI.

# iwctl
[iwd]# help
[iwd]# device list
[iwd]# station device(rede-wlan) scan
[iwd]# station device(rede-wlan) get-networks 
[iwd]# station device(rede-wlan) conect SSID(nome da sua rede wifi)

5. Atualize o relógio do sistema.

# timedatectl set-ntp true

6. MIRRORLIST = Espelhos para download dos pacotes.

# pacman -Sy reflector

# reflector --verbose --latest 10 --sort rate --save /etc/pacman.d/mirrorlist      (mirrors sincronizados e atualizados).
 
# reflector -c Brazil – 10 --sort rate --save /etc/pacman.d/mirrorlist       (mirrors por país)

# pacman -Syyy

7.  Particionamento do disco.

# lsblk ou fdisk -l  	(para listar os discos).

# cfdisk /dev/sdaX 	(para particionar o disco escolhido).

OBS.: Criando partição no CFDISK.
1. Partição de boot ( /boot para LEGACY=1024MB - EXT4 ou /boot/efi para UEFI=512mb - FAT32 ).
2. Partição de root ( / = partição raiz para armazenamento do sistema e aplicativos.)
3. Partição de home ( /home = partição do usuário separada da raiz para armazenamento dos dados do usuário. 


8. Formate as partições.

# mkfs.ext4 /dev/sda1                (para legacy = /boot) 
# mkfs.fat -FAT32 /dev/sda1     (para uefi = /boot/efi)

# mkfs.btrfs -f  /dev/sda2 	(para raiz = /)	

# mkfs.ext4 /dev/sda3 	(para home = /home)

9. Montando as partições e criando subvolumes.

# mount /dev/sda2 /mnt

# btrfs su cr /mnt/@

# umount /mnt

# mount -o rw,noatime,ssd,compress=zstd,defaults,space_cache,autodefrag,subvol=@ /dev/sda2 /mnt

# mkdir /mnt/boot			(mkdir -p /mnt/boot/efi = para UEFI)

# mkdir /mnt/home

# mount -o rw,noatime,ssd,compress=zstd,defaults,space_cache,autodefrag,subvol=@home /dev/sda2 /mnt/home

# mount /dev/sda1 /mnt/boot

# mount /dev/sda3 /mnt/home          (para EXT4 ou sem subvolume)

10. Instalando Base do sistema.

# pacstrap /mnt base linux linux-firmware intel-ucode vim nano git btrfs-progs networkmanager 

11. Gerando arquivo do FSTAB.

# genfstab -U /mnt >> /mnt/etc/fstab

# cat /mnt/etc/fstab

12. Entrando no CHROOT da instalação.

# arch-chroot /mnt   (Apartir daqui automatizada via script)

13. Configurando linguagem e localização.

# nano /etc/locale.gem
Descomente o local tirando a hashtag: #pt_BR.UTF-8 UTF-8  
Deixe assim: pt_BR.UTF-8 UTF-8  

# locale-gen
# nano /etc/locale.conf
Digite dentro: LANG=pt_BR.UTF-8

# nano /etc/vconsole.conf
Digite dentro: KEYMAP=br-abnt2

14. Definindo a zona de tempo.

# ln -sf /usr/share/zoneinfo/America/Belem /etc/localtime

# hwclock --systohc --utc

15. Habilitando repositório Multilib.

# nano /etc/pacman.conf
Descomenta as linhas:
[multilib]
Include = /etc/pacman.d/mirrorlist

# pacman -Sy (checa se multilib está habilitado)

16. Definindo o nome da máquina e rede.

# echo archlinux > /etc/hostname

# nano /etc/hosts
127.0.0.1 	localhost
::1 		localhost
127.0.1.1 	archlinux.localdomain 	archlinux

17. Definindo senha do ROOT e criando novo usuário.

# passwd 

# useradd -m -g users -G audio,lp,optical,storage,video,wheel,games,power,scanner -s /bin/bash shaka

# passwd shaka    (shaka=novo usuário)


18. Habilitando usuarios ao grupo wheel e poderes administrativo no sudo.

# EDITOR=nano visudo
Descomente a linha:]
%wheel ALL=(ALL) ALL

19. Instalação e configuração do bootloader.

# mkinitcipio -p linux

# pacman -S grub  os-prober efibootmgr dosfstools mtools		(para boot UEFI)
# pacman -S grub os-prober 						(para boot LEGACY)

20. Instalação do GRUB.

# grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB      (para UEFI) 
# grub-install --target=i386-pc /dev/sda						    (para LEGACY)

# grub-mkconfig -o /boot/grub/grub.cfg


21. Habilitando internet na próxima reinicialização.

# systemctl enable NetworkManager.service

22. Saindo do chroot.

# exit

23. Desmontando partições e reiniciando o sistema.

# umount -R /mnt

# reboot







































INSTALAÇÃO DA INTERFACE GRÁFICA


1. Depois de conectado a internet, instale o drivers de video (placa gráfica).

sudo pacman -S nvidia nvidia-utils nvidia-settings nvidia-dkms			(nvidia)
sudo pacman -S xf86-video-intel intel-ucode					(intel)
sudo pacman -S xf86-video-amdgpu	amd-ucode					(amd)

2. Servidor de exibição.

sudo pacman -S xorg xorg-server xorg-xinit

3. Instalação do ambiente de trabalho.

sudo pacman -S gnome gnome-extra gdm

sudo systemctl enable gdm.service

reboot



INSTALAÇÃO DO TIMESHIFT

sudo pacman -S go git tar curl wget

git clone https://aur.archlinux.org/yay.git

cd yay

makepkg -si

yay -S timeshift
 







