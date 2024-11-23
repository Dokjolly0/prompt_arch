#!/bin/bash

# Verifica se l'utente è root
if [ "$EUID" -ne 0 ]; then
  echo "Si prega di eseguire lo script come root"
  exit
fi

# Verifica se lsblk e smartctl sono installati
if ! command -v lsblk &> /dev/null; then
    echo "lsblk non è installato. Si prega di installarlo con 'sudo pacman -S util-linux'."
    exit
fi

if ! command -v smartctl &> /dev/null; then
    echo "smartctl non è installato. Si prega di installarlo con 'sudo pacman -S smartmontools'."
    exit
fi

echo "Raccolta informazioni sui dispositivi di memoria di massa (HDD/SSD)..."

# Usa lsblk per ottenere informazioni sui dispositivi di memoria
lsblk_output=$(lsblk -o NAME,SIZE,TYPE,MOUNTPOINT)

# Stampa le informazioni raccolte
echo "Informazioni sui dispositivi di memoria:"
echo "$lsblk_output"

echo -e "\nDettagli sui dispositivi di memoria:"

# Ottieni una lista dei dispositivi di blocco (solo dischi, non partizioni)
disks=$(lsblk -nd --output NAME,TYPE | grep disk | awk '{print $1}')

for disk in $disks; do
  echo -e "\nInformazioni per /dev/$disk:"
  smartctl -i /dev/$disk | grep -E "Device Model:|Serial Number:|Firmware Version:|User Capacity:|Sector Sizes:"
done

echo -e "\nVerifica delle interfacce di archiviazione disponibili:"
lspci | grep -i storage

echo -e "\nScript completato."
