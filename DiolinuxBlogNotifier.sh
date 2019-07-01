#!/usr/bin/env bash
# ----------------------------------------------------------------------------------- #
# DiolinuxBlogNotifier.sh
#
# E-mail:     luciobrito2012@gmail.com
# Autor:      Luciano Brito
# Telefone:   +55 61 995175170
# Manutenção: Luciano Brito
#
# ----------------------------------------------------------------------------------- #
#  Descrição: Faz a extração de títulos de posts do Blog Diolinux.
#
#  Exemplos:
#      $ ./DiolinuxBlogNotifier.sh
#
#      	Neste exemplo será executado o programa que fará o checkin no blog Diolinux 
#		e armazenará o títlulo e o link de cada post encontrado e emitirá uma notificação
#		GTK através do zenity com os mesmos.
# ----------------------------------------------------------------------------------- #
# Histórico:
#
#   v1.0 30/06/2019, Luciano
#		- Adicionado a variável TITULO que armazenará cada título do arquivo de dados DiolinuxBlogNotifier"
#		- Adicionado a variável LINK que armazenará o link de cada título do arquivo de dados DiolinuxBlogNotifier"
#		- Adicionado a variável SEP que fará separação entre o link e o título do arquivo de dados DiolinuxBlogNotifier"
#		- Adicionado comando zenity para emitir notificações dos post encontrado no blog Diolinux.
#
# ----------------------------------------------------------------------------------- #
# Testado em:
#   bash 4.4.19
#
# ------------------------------- VARIÁVEIS ----------------------------------------- #
TITULOS_BLOG_DIOLINUX="titulosDiolinux.txt"
TITULO=
LINK=
SEP="|"

# ------------------------------- TESTES -------------------------------------------- #
[ ! -x $(which lynx) ]	 && sudo apt install lynx -y 	# Lynx 	 Instalado?
[ ! -x $(which zenity) ] && sudo apt install zenity -y 	# Zenity Instalado?

# ------------------------------- EXECUÇÃO ------------------------------------------ #
clear
lynx -source https://www.diolinux.com.br/ | grep -A 1 "post-title entry-title" |\
grep "^<a href" | sed "s/<a\ href=\"//;s/\">/$SEP/;s/<\/a>//" > "$TITULOS_BLOG_DIOLINUX"

while read -r linha ; do

	[ ! "$linha" ] && continue	
	LINK="$(	echo $linha | cut -d $SEP -f1)"
	TITULO="$(	echo $linha | cut -d $SEP -f2)"
	zenity --notification --text="$TITULO.\n$LINK"

done < "$TITULOS_BLOG_DIOLINUX"

exit