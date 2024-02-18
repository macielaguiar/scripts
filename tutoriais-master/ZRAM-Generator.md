https://github.com/systemd/zram-generator

Получаем  ROOT  права

sudo su

Создаем и открываем файлик   zram-generator.conf

nano /etc/systemd/zram-generator.conf

Копируем в него следующие строки :

[zram0]
zram-size = ram / 2

[zram1]
mount-point = /var/compressed

[Service]
ExecStartPost=/bin/sh -c 'd=$(mktemp -d); mount "$1" "$d"; chmod 1777 "$d"; umount "$d"; rmdir "$d"' _ /dev/%i

Устанавливаем само приложение zram-generator

 pacman -S zram-generator

или

yay zram-generator

На других дистрибутивах нужно ставить свои пакеты и смотрите статью по ссылке.




Технология zRam ранее известная как compcache - реализована в виде модуля ядра Linux и позволяет сжимать содержимое оперативной памяти, и таким образом увеличивать ее объем в несколько раз. Работает это так: модуль zRam создает сжатое блочное устройство в ОЗУ которое чаще всего используется как swap или монтируется в tmp.

При этом степень сжатия данных получается в среднем 3:1. Это означает что на 1 гигабайт подкачки будет использовано в 333 мегабайт физической памяти. Сейчас оперативная память стоит не так уж дорого, но использование zRam вместо файла подкачки на диске может быть полезным для старых ноутбуков и компьютеров, а также для виртуализации.



## MEU ZRAM GENERATOR CONFIG 
sudo nano /etc/systemd/zram-generator.conf

[zram0]
zram-size = ram / 2
compression-algorithm = zstd
swap-priority = 100
fs-type = swap


sudo systemctl enable systemd-zram-setup@zram0.service