#!/bin/bash
# blogproof.sh
# Criação: 25/03/2019
# Propósito: Fazer teste do wscan para WordPress no blog
# Autor: Erick Formaggio

clear

echo "=================================================="
echo "ANALISANDO O BLOG"
echo "=================================================="
echo "Analisando... O teste pode demorar alguns minutos"
echo "Se quiser acompanhar os detalhes, em outra aba digite: tcpdump host ip-do-site -v"

wpscan --update

y | wpscan --url "$host" --random-agent > Testes/blog_"$nomeempresablog"/"$nomeempresablog"_blog-$DATE.txt

