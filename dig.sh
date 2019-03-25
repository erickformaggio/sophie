#!/bin/bash
# dig.sh
# Criação: 24/03/2019
# Propósito: Verificando dados de servidor...
# Autor: Erick Formaggio

clear

echo "=================================================="
echo "DIG"
echo "=================================================="

dig "$host" -t mx > Testes/"$host"/"$host"_dig-$DATE.txt
cat Testes/"$host"/"$host"_dig-$DATE.txt
sleep 5
