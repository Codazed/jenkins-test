#!/bin/bash
bootloader_efi() {
  bootctl install
  sed '/^HOOKS=/ s/)/ systemd)/' /etc/mkinitcpio.conf
  mkinitcpio -P
}

bootloader_mbr() {
  pacman -S grub
  grub-intall --target=i386-pc /dev/sda1
  grub-mkconfig -o /boot/grub/grub.cfg
}

if [[ $(ls /sys/firmware/efi/efivars 2>/dev/null) ]]; then
  EFI=true
else
  EFI=false
fi

if [[ $EFI=="true" ]]; then
  bootloader_efi
else
  bootloader_mbr
fi