#output=$(ls -l)
#Controlla ip
internal_ip=$(ip addr show | grep 'inet ' | grep -v '127.0.0.1' | grep -v 'docker0' | awk '{print $2}' | cut -d/ -f1 | head -n 1)
external_ip=$(curl -s ifconfig.me)
echo -e "IP interno: $internal_ip\nIP esterno: $external_ip"
#Connessione alla vpn
sudo surfshark-vpn --help;
echo "\r" | sudo surfshark-vpn attack;
sudo surfshark-vpn status;
#Ricontrolla ip
internal_ip=$(ip addr show | grep 'inet ' | grep -v '127.0.0.1' | grep -v 'docker0' | awk '{print $2}' | cut -d/ -f1 | head -n 1)
external_ip=$(curl -s ifconfig.me)
echo -e "IP interno: $internal_ip\nIP esterno: $external_ip"
exec bash;
