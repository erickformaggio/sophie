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

#Inicia a busca de dados de registro de domínio
source whois.sh

#Inicia busca de dados de domínio
source dig.sh

#Procurando local do servidor de hospedagem
source localserver.sh

#Busca por email e outros dados
source harvester.sh

#Inicia Teste de Vulnerabilidade
source nmapvul.sh

#Inicia Teste do Nikto
source nikto.sh

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

