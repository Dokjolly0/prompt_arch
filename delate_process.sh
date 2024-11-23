#!/bin/bash

# Chiedi all'utente quale porta eliminare
porta=$(zenity --entry --title="Elimina Processo su Porta" --text="Inserisci il numero della porta da controllare:")

# Controlla se l'utente ha inserito qualcosa
if [ -z "$porta" ]; then
    zenity --error --text="Non hai inserito nessuna porta."
    exit 1
fi

# Trova il processo che utilizza la porta
pid=$(lsof -t -i :"$porta")

# Controlla se è stato trovato un processo
if [ -z "$pid" ]; then
    zenity --error --text="Nessun processo trovato sulla porta $porta."
    exit 1
fi

# Elimina il processo
if kill -9 "$pid"; then
    zenity --info --text="Il processo sulla porta $porta (PID: $pid) è stato eliminato con successo."
else
    zenity --error --text="Errore nell'eliminazione del processo sulla porta $porta. Assicurati di avere i permessi necessari."
fi

# Mantieni aperto il terminale
read -p "Premi invio per chiudere..."


















# #!/bin/bash

# # Apri un terminale
# #xfce4-terminal --hold --execute bash -c '

# # Chiedi all'utente quale porta eliminare
# porta=$(zenity --entry --title="Elimina Processo su Porta" --text="Inserisci il numero della porta da controllare:")

# # Controlla se l'utente ha inserito qualcosa
# if [ -z "$porta" ]; then
#     zenity --error --text="Non hai inserito nessuna porta."
#     exit 1
# fi

# # Trova il processo che utilizza la porta
# pid=$(lsof -t -i :"$porta")

# # Controlla se è stato trovato un processo
# if [ -z "$pid" ]; then
#     zenity --error --text="Nessun processo trovato sulla porta $porta."
#     exit 1
# fi

# # Elimina il processo
# if kill -9 "$pid"; then
#     zenity --info --text="Il processo sulla porta $porta (PID: $pid) è stato eliminato con successo."
# else
#     zenity --error --text="Errore nell'eliminazione del processo sulla porta $porta. Assicurati di avere i permessi necessari."
# fi
# '
