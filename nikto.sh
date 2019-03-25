#!/bin/bash
# nikto.sh
# Criação: 24/03/2019
# Propósito: Fazer teste de vulnerabilidade do NIKTO
# Autor: Erick Formaggio

clear

echo "=================================================="
echo "NIKTO"
echo "=================================================="

echo "Analisando..."
nikto -h "$host" > Testes/"$host"/"$host"_nikto-$DATE.txt
cat Testes/"$host"/"$host"_nikto-$DATE.txt
sleep 5
