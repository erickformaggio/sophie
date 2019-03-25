
#!/bin/bash
# localserver.sh
# Criação: 24/03/2019
# Propósito: Determinando local do servidor...
# Autor: Erick Formaggio

clear

echo "=================================================="
echo "LOCAL SERVER"
echo "=================================================="
echo "Analisando..."
nmap -sV --script ip-geolocation-geoplugin "$host" > Testes/"$host"/"$host"_localizacao-$DATE.txt
