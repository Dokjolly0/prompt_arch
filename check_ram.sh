#!/bin/bash

# Verifica se l'utente è root
if [ "$EUID" -ne 0 ]; then
  echo "Si prega di eseguire lo script come root"
  exit
fi

# Verifica se dmidecode è installato
if ! command -v dmidecode &> /dev/null
then
    echo "dmidecode non è installato. Si prega di installarlo con 'sudo pacman -S dmidecode'."
    exit
fi

echo "Raccolta informazioni sulla RAM installata..."

# Usa dmidecode per ottenere informazioni sulla memoria
dmidecode_output=$(dmidecode -t memory)

# Estrai informazioni rilevanti
total_memory=$(echo "$dmidecode_output" | grep -i "Size" | grep -v "No Module Installed" | awk '{sum += $2} END {print sum}')
memory_type=$(echo "$dmidecode_output" | grep -i "Type:" | grep -v "Unknown" | grep -v "Error Correction Type" | head -n 1 | awk '{print $2}')
memory_speed=$(echo "$dmidecode_output" | grep -i "Speed:" | grep -v "Unknown" | grep -v "Configured" | head -n 1 | awk '{print $2, $3}')
max_memory=$(echo "$dmidecode_output" | grep -i "Maximum Capacity" | awk '{print $3, $4}')
memory_slots=$(echo "$dmidecode_output" | grep -i "Number Of Devices" | awk '{print $4}')

# Stampa le informazioni raccolte
echo "Totale RAM installata: ${total_memory} MB"
echo "Tipo di memoria: ${memory_type}"
echo "Velocità della memoria: ${memory_speed}"
echo "Capacità massima supportata: ${max_memory}"
echo "Numero di slot di memoria: ${memory_slots}"

# Verifica lo stato degli slot di memoria
echo -e "\nStato degli slot di memoria:"
echo "$dmidecode_output" | grep -A 15 "Memory Device" | grep -E "Size:|Locator:|Bank Locator:|Type:|Speed:" | grep -v "No Module Installed" | awk '
/Memory Device/ {printf "\n"}
/Size:/ {printf "  %-18s %s\n", "Size:", $2 " " $3}
/Locator:/ {printf "  %-18s %s\n", "Locator:", $2}
/Bank Locator:/ {printf "  %-18s %s\n", "Bank Locator:", $3}
/Type:/ {printf "  %-18s %s\n", "Type:", $2}
/Speed:/ {printf "  %-18s %s\n", "Speed:", $2 " " $3}
'

echo -e "\nScript completato."
