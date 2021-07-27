#!/bin/bash

# --------------------------
# Este software utiliza o Imapsync (https://github.com/imapsync/imapsync)
# Author: Jehud II
# E-mail: jehud2@hotmail.com
# --------------------------

# verifica se o imapsync já está instalado
if which imapsync
then

# VARIÁVEIS
host1=0
host2=0
user1=0
user2=0
password1=0
password2=0

	# Função para coleta das informações necessárias
	coletaInformacoes(){
		host1=$( dialog --stdout \
				--title "INFORMAÇÕES DE ORIGEM" \
				--inputbox "\nEndereço do Servidor:\n" \
				10 60 )

		user1=$( dialog --stdout \
				--title "INFORMAÇÕES DE ORIGEM" \
				--inputbox "\nE-mail completo:\n" \
				10 60 )

		password1=$( dialog --stdout \
				--title "INFORMAÇÕES DE ORIGEM" \
				--inputbox "\nInsira a senha:\n" \
				10 60 )

		host2=$( dialog --stdout \
				--title "INFORMAÇÕES DE DESTINO" \
				--inputbox "\nEndereço do Servidor:\n" \
				10 60 )

		user2=$( dialog --stdout \
				--title "INFORMAÇÕES DE DESTINO" \
				--inputbox "\nE-mail completo:\n" \
				10 60 )

		password2=$( dialog --stdout \
				--title "INFORMAÇÕES DE DESTINO" \
				--inputbox "\nInsira a senha:\n" \
				10 60 )
	}
	
	dialog \
		--title "Transferência de e-mail" \
		--msgbox "\nEsse script tem como base o imapsync para fazer transferência ou \
		backup de e-mails, para tanto vamos precisar de algumas informações. " \
		0 0
		
	# Chama a funcao coletaInformacoes
	coletaInformacoes
	
	while : ;
	do
		confirmacao=$( dialog --stdout \
			--title "INFORMAÇÕES" \
			--yesno "\nAs informações abaixo estão corretas?\n \
			\nServidor Origem: $host1 \
			\nE-mail Origem: $user1 \
			\nSenha E-mail Origem: $password1 \
			\n\nServidor Destino: $host2 \
			\nE-mail Destino: $user2 \
			\nSenha E-mail Destino: $password2" \
			0 0 )
		
		if [ $? = 0 ]
		then
			dialog \
				--title "Aguarde" \
				--sleep 5 \
				--infobox "\nO Processo inicia em 5 segundos..." \
				0 0
				
			# Executa o comando
			clear
			imapsync --host1 $host1 --user1 $user1 --password1 $password1 --host2 $host2 --user2 $user2 --password2 $password2 --ssl1 --ssl2
			
			break
			
		else
			echo "repetir processo"
			coletaInformacoes
		fi
	done

else
	dialog \
		--title "ALERTA" \
		--msgbox "\nPor favor instale o imapsync e execute novamente esse script. \n" \
		0 0
fi
