#!/bin/bash

# Funzione per mostrare il menu
show_menu() {
    echo "Seleziona il disco da smontare:"
    echo "1) Segate 4TB (/mnt/exfat)"
    echo "0) Esci"
    read -p "Scegli un'opzione: " choice
    case $choice in
        1)
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

# Smonta il disco
echo "Smontando $DESCRIPTION..."
sudo umount $MOUNT_POINT

# Verifica se il disco è stato smontato correttamente
if mount | grep -q "$MOUNT_POINT"; then
  echo "Errore: il disco $DESCRIPTION non è stato smontato correttamente."
  exit 1
else
  echo "Il disco $DESCRIPTION è stato smontato correttamente da $MOUNT_POINT."
fi
