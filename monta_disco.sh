#!/bin/bash

# Funzione per mostrare il menu
show_menu() {
    echo "Seleziona il disco da montare:"
    echo "1) Segate 4TB (/dev/sdb2)"
    echo "0) Esci"
    read -p "Scegli un'opzione: " choice
    case $choice in
        1)
            DEVICE="/dev/sdb2"
            MOUNT_POINT="/mnt/exfat"
            DESCRIPTION="Segate 4TB"
            ;;
        0)
            exit 0
            ;;
        *)
            echo "Opzione non valida."
            exit 1
            ;;
    esac
}

# Mostra il menu
show_menu

# Monta il disco
echo "Montando $DESCRIPTION..."
sudo mount -t exfat $DEVICE $MOUNT_POINT

# Verifica se il disco è montato correttamente
if mount | grep -q "$MOUNT_POINT"; then
  echo "Il disco $DESCRIPTION è stato montato correttamente su $MOUNT_POINT."
else
  echo "Errore: il disco $DESCRIPTION non è stato montato correttamente."
  exit 1
fi
