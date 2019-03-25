#!/bin/bash
# harvester.sh
# Criação: 23/03/2019
# Propósito: 
# Autor: Erick Formaggio

clear

echo "=================================================="
echo "THE HARVESTER"
echo "=================================================="
echo "Analisando... O teste pode demorar alguns minutos"
theharvester -d "$host" -b google > Testes/"$host"/"$host"_tharvester-$DATE.txt
cat Testes/"$host"/"$host"_tharvester-$DATE.txt
