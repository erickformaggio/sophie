#!/bin/bash


#===================== S0PH1E========================
#
# Autor: Erick Formaggio (erick.beltrami@gmail.com)
# 
# Criacao: 	05/12/2016
# Atualizacao:	
# 04/03/2019 - aplicações de função "dominios" e um teste só para blog. 
# 07/03/2019 - o ataque slowloris ainda não está funcionando
# Descricao: 	Testa um site para varios itens de seguranca.
# 		Funcionamento somente no Kali Linux, pois ele precisa dos programas instalados.

DATE=$(date +%D-%H%M | tr -d /)

dominiopuro ()
{
echo "HOST SEM WWW"
read host
mkdir -p Testes/"$host"
}

dominioblog ()
{ 

echo "ENTRE COM O NOME DA EMPRESA"
read nomeempresablog
echo "URL DO BLOG"
read host
mkdir -p Testes/blog_"$nomeempresablog"
}

# Chama menu de opções
clear

echo "Escolha uma das alternativas:"
echo "1 - Teste de vulnerabilidades"
echo "2 - Dados de dominio"
echo "3 - Todos os testes para sites"
echo "4 - DOS atack teste"
echo "5 - Ataque Slowloris"
echo "6 - Localizar"
echo "7 - Análise de blogs"
echo "8 - Vulnerabilidades recentes"

read opcao


case $opcao in

# Opcao 1 Teste de Vulnerabilidades
1)
clear
dominiopuro
source nmapvul.sh
;;

# Opcao 2 Dados de dominio	
2)
clear
dominiopuro
echo "**************************************************************"
echo "WHOIS"
whois "$host" > Testes/"$host"/"$host"_whois-$DATE.txt
cat Testes/"$host"/"$host"_whois-$DATE.txt
;;

# Opcao 3 Todos os testes
3)
clear
dominiopuro

echo "**************************************************************"
echo "1. HOST"
host "$host" > Testes/"$host"/"$host"_host-$DATE.txt
cat Testes/"$host"/"$host"_host-$DATE.txt 
sleep 5

clear
echo "**************************************************************"
echo "2. DIG"
dig "$host" -t mx > Testes/"$host"/"$host"_dig-$DATE.txt
cat Testes/"$host"/"$host"_dig-$DATE.txt
sleep 5 

clear
echo "**************************************************************"
echo "3. WHOIS"
whois "$host" > Testes/"$host"/"$host"_whois-$DATE.txt
cat Testes/"$host"/"$host"_whois-$DATE.txt
sleep 5

clear
echo "**************************************************************"
echo "4. NIKTO"
echo "Analisando..."
nikto -h "$host" > Testes/"$host"/"$host"_nikto-$DATE.txt
cat Testes/"$host"/"$host"_nikto-$DATE.txt
sleep 5

clear
echo "**************************************************************"
echo "5. THE HARVESTER"
theharvester -d "$host" -b google > Testes/"$host"/"$host"_tharvester-$DATE.txt
cat Testes/"$host"/"$host"_tharvester-$DATE.txt


source nmapvul.sh

clear
echo "**************************************************************"
echo "7. DETERMINANDO LOCAL SERVER"
nmap -sV --script ip-geolocation-geoplugin "$host" > Testes/"$host"/"$host"_localizacao-$DATE.txt
;;


# OPCAO 4 TESTE SLOWLORIS
4)
clear
dominiopuro
echo "**************************************************************"
echo "Iniciando teste..."
nmap --script http-slowloris --max-parallelism 400 "$host" -v
;;

# OPCAO 5 ATAQUE SLOWLORIS
5)
clear
dominiopuro
echo "**************************************************************"
echo "Iniciando ataque..."
./slowloris.pl -dns "$host"
;;

6)
clear
dominiopuro
echo "**************************************************************"
echo "Iniciando teste..."
nmap -sV --script ip-geolocation-geoplugin "$host" > Testes/"$host"/"$host"_localizacao-$DATE.txt
;;

#ANÁLISE DE BLOGS
7)
clear
dominioblog

#PRIMEIRO VAI ATUALIZAR O WPSCAN
echo "**************************************************************"
echo "7. WPSCAN"
echo "Iniciando... aguarde pois pode demorar alguns minutos"
#wpscan --update

#blog=$host | sed 's/[.|/d]/_/g' - comando que eu estava testando para transformar ponto em underline

y | wpscan --url "$host" --random-agent > Testes/blog_"$nomeempresablog"/"$nomeempresablog"_blog-$DATE.txt
;;

#Vulnerabilidades recentes
8)
clear
grep -rl vulnerable
;;

esac


echo "**************************************************************"
echo "*                           FIM                              *"
echo "**************************************************************"

RETURN_CODE=$?

