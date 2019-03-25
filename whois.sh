#!/bin/bash
# whois.sh
# Criação: 24/03/2019
# Propósito: Verificando dados de registro...
# Autor: Erick Formaggio

clear

echo "=================================================="
echo "WHOIS"
echo "=================================================="
whois "$host" > Testes/"$host"/"$host"_whois-$DATE.txt
cat Testes/"$host"/"$host"_whois-$DATE.txt
sleep 5
