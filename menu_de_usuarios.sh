#!/bin/bash
#VARIABLES********
opc=0
year=$(date +%Y-%m-%d)
#*****************

#FUNCIONES**********************************************************************************************************
function menu() {
	clear
	echo "MENÚ DE GESTIÓN DE USUARIOS"
	echo "1 - Agregar usuario"
	echo "2 - Borrar usuario"
	echo "3 - Listar usuarios del sistema"
	echo "4 - Buscar un usuario en el sistema"
	echo "5 - Cambiar contraseña de un usuario"
	echo "6 - Bloquear usuario"
	echo "7 - Desbloquear usuario"
	echo "8 - Salir"
}

function agregar_usuario(){
	clear
	#Nomeclatura del usuario apellidonombre
	echo "Ingrese el apellido y nombre del usuario en formato: apellidonombre: "
	read nombre
	usuario=$(echo $nombre | tr [:upper:] [:lower:])
	nomb=$(cat /etc/passwd | grep -c $usuario)
	if [ $nomb -eq 1 ]; then
		echo "El usuario ya existe"
		echo "$(date +%Y-%m-%d-%H:%M:%S) Se trato de crear un usuario con el nombre $nomb pero el usuario ya existe en /etc/passwd" >> /root/log/log_propios/usuarios.txt
		read pausa
	else
		echo "Ingrese el grupo: "
		read grupo
		user_group=$(echo $grupo | tr [:upper:] [:lower:])
		grup=$(cat /etc/group | grep -c $user_group)
		if [ $grup -eq 1 ]; then
			useradd -g $user_group -c "$user_group $year" -mk /etc/skel -s /bin/bash $usuario
			echo "$(date +%Y-%m-%d-%H:%M:%S) se agrego el usuario $usuario perteneciente al grupo $grup al sistema" >> /root/log/log_propios/usuarios.txt
			passwd -e -d $usuario
			echo "usuario dado de alta"
			read pausa
		else
			echo "El grupo no existe"
            echo "$(date +%Y-%m-%d-%H:%M:%S) se trato de agregar el grupo $grup al sistema pero el grupo ya existe." >> /root/log/log_propios/grupos.txt
			read pausa
		fi
	fi
}

#********************************************************************************************************************
