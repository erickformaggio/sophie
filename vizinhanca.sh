#!/bin/bash
# vizinhanca.sh
# Programa para testar os vizinhos de IP de um determinado HOST
# Criado em 14/02/2019 08:55:012 hs
# Atualizado 
# 15/02/2019
# 27/03/2019 - adaptado para rodar com sophie.sh
# Autor Erick B. Formaggio - erick.beltrami@gmail.com

clear

echo "Entre com o host a ser testado"
read host

clear

echo "Iniciando... Pode demorar alguns segundos"

nmap -sn -T4 "$host"/24 -v > Testes/"$host"/"$host"-vizinhanca.txt

clear

cat Testes/"$host"/"$host"-vizinhanca.txt | egrep ".br|.com|.gov|.net" | more


