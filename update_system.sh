#!/bin/bash

echo "Aggiorna app ufficiali pacman"
sudo pacman -Syu --noconfirm

echo "Aggiorna pacchetti yay"
yay -Syu --noconfirm

echo "Aggiorna pacchetti snap"
sudo snap refresh

echo "Aggiorna pacchetti flatpak"
flatpak update --assumeyes

# Pulizia delle cache e dei file temporanei
echo "Pulizia delle cache di pacman"
sudo paccache -r  # Rimuovi l'opzione --noconfirm

echo "Pulizia della cache di yay"
yay -Sc --noconfirm

echo "Pulizia della cache di flatpak"
flatpak uninstall --unused  # Rimuovi l'opzione --noconfirm

echo "Pulizia della cache di snap"
sudo snap remove --purge $(sudo snap list --all | awk '/disabled/{print $1, $3}')

echo "Pulizia dei file temporanei"
sudo rm -rf /var/tmp/*
rm -rf ~/.cache/*

# Chiedi se si vuole riavviare il sistema
read -p "Vuoi riavviare il sistema? (s/N) " risposta

if [[ "$risposta" == "s" || "$risposta" == "S" ]]; then
    echo "Riavvio del sistema in corso..."
    sudo reboot
else
    echo "Aggiornamento e pulizia completati senza riavvio."
fi



















# #!/bin/bash

# echo "Aggiorna app ufficiali pacman"
# sudo pacman -Syu

# echo "Aggiorna pacchetti yay"
# yay -Syu

# echo "Aggiorna pacchetti snap"
# sudo snap refresh

# echo "Aggiorna pacchetti flatpak"
# flatpak update

# # Pulizia delle cache e dei file temporanei
# echo "Pulizia delle cache di pacman"
# sudo paccache -r

# echo "Pulizia della cache di yay"
# yay -Sc

# echo "Pulizia della cache di flatpak"
# flatpak uninstall --unused

# echo "Pulizia della cache di snap"
# sudo snap remove --purge $(sudo snap list --all | awk '/disabled/{print $1, $3}')

# echo "Pulizia dei file temporanei"
# sudo rm -rf /var/tmp/*
# rm -rf ~/.cache/*

# # Chiedi se si vuole riavviare il sistema
# read -p "Vuoi riavviare il sistema? (s/N) " risposta

# if [[ "$risposta" == "s" || "$risposta" == "S" ]]; then
#     echo "Riavvio del sistema in corso..."
#     sudo reboot
# else
#     echo "Aggiornamento e pulizia completati senza riavvio."
# fi
