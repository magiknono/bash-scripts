## CREATE A BOOTABLE USB KEY FROM AN ISO

#### Look at your volume disk (sda / sdb ...)
```shell
sudo fdisk -l
```
#### Connect your usb key and find the new volume
```shell
sudo fdisk -l
```
#### Place the shell in your workdir where is the iso file
```shell
cd ~/MyIso
```
#### Create the bootable usb key from your iso
```shell
sudo dd if=MyCustomIso.iso of=/dev/sd{a/b/c/d/e..} bs=4M status=progress && sudo sync
```
#### Wait ..

It's READY ! You can now reboot your pc and load your new system.
