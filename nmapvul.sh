#!/bin/bash
# nmapvul.sh
# Criação: 23/03/2019
# Propósito: Fazer teste de vulnerabilidade do Nmap
# Autor: Erick Formaggio

clear

echo "=================================================="
echo "NMAP VULNERABILIDADES"
echo "=================================================="
echo "Analisando... O teste pode demorar alguns minutos"
echo "Se quiser acompanhar os detalhes, em outra aba digite: tcpdump host ip-do-site -v"
nmap -Pn --script vuln "$host" -v -oN  Testes/"$host"/"$host"_nmap-vulnerabilidades-$DATE.txt
