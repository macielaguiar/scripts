#!/bin/bash

sudo pacman -Sy lfs duf lnav fd tldr fdkaac vorbis-tools alacarte scrcpy python-pip vulkan-tools speedtest-cli bashtop zip unzip lzop cpio p7zip unace sharutils uudeview arj p7zip-plugins qt5ct testdisk unrar tar mesa rsync ffmpeg libdvdnav libdvdcss cdrdao cdrtools ffmpeg ffmpegthumbnailer ffmpegthumbs drawing grub-customizer gst-plugins-ugly gst-plugins-good gst-plugins-base gst-plugins-base-libs gst-plugins-bad gst-libav gst-plugins-ugly curl wget pipewire pipewire-alsa pipewire-pulse pipewire-jack pavucontrol gstreamer exa testdisk nethogs neofetch cmatrix glava htop zsh zsh-completions lshw firefox firefox-i18n-pt-br chromium gimp inkscape kdenlive kdeconnect virtualbox virtualbox-ext-vnc virtualbox-guest-iso catfish plocate telegram-desktop qbittorrent brasero bitwarden clipgrab darktable audacity calibre ciano converseen tilix asunder acetoneiso2 soundconverter sound-juicer flameshot discord filezilla gparted grsync handbrake kid3 krita libreoffice-fresh libreoffice-fresh-pt-br kshutdown kronometer meld lollypop ksnip mediainfo-gui youtube-dl mixxx clementine pinta persepolis onboard onionshare shotcut remmina gcolor3 scribus syncthing warpinator psensor exfat-utils exfatprogs f2fs-tools fuse fuse-exfat mtpfs

#sudo systemctl enable plocate-updatedb.service
sudo systemctl enable plocate-updatedb.timer 

sudo updatedb

printf "\e[1;32mDone! Please reboot your system.\e[0m"

#AUR - FIRMWARE
#linux-firmware-qlogic 
#wd719x-firmware
#upd72020x-fw
#aic94xx-firmware


### Pacotes AUR INSTALADOS.
## albert-bin brave-bin bullky chrome-gnome-shell goverlay-bin teamviewer cpu-x davinci-resolve easyssh ferdi-bin flareget freedownloadmanager freeoffice gdm-tools genymotion google-chrome google-earth-pro hypnotix hashbrown i-nex inxi komorebi pamac-aur archlinux-appstream-data-pamac makemkv masterpdfeditor-free metadata-cleaner ocenaudio-bin onlyoffice-bin paru pdfsam quickgui-bin sejda-desktop spotify sublime-text-4 system-monitoring-center timeshift ttf-ms-fonts video-downloader visual-studio-code-bin xboxdrv xdman yay-bin zramdx

### Pacotes FLATPAK INSTALADOS.
#org.xiphos.Xiphos
#org.olivevideoeditor.Olive
#org.nmap.Zenmap
#org.goldendict.GoldenDict
#org.gnome.gitlab.YaLTeR.VideoTrimmer  
#org.gabmus.hydrapaper 
#me.kozec.syncthingtk 
#io.github.peazip.PeaZip    
#io.github.mimbrero.WhatsAppDesktop
#io.github.JaGoLi.ytdl_gui 
#io.freetubeapp.FreeTube 
#com.stremio.Stremio   
#com.poweriso.PowerISO 
#com.mattjakeman.ExtensionManager   
#com.ktechpit.wonderwall 
#com.github.tchx84.Flatseal 
#com.github.hugolabe.Wike 
#com.anydesk.Anydesk 
#co.headsetapp.headset
