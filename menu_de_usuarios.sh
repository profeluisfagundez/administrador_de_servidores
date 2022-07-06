#!/bin/bash
#VARIABLES********
opc=0
year=$(date +%Y-%m-%d)
#*****************

#FUNCIONES**********************************************************************************************************
function menu(){
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

function borrar_usuario(){
	clear
	#Nomeclatura del usuario apellidonombre
	echo "Ingrese el apellido y nombre del usuario en formato: apellidonombre: "
	read nombre
	usuario=$(echo $nombre | tr [:upper:] [:lower:])
	nomb=$(cat /etc/passwd | grep -c $usuario)
	if [ $nomb -eq 1 ]; then
		echo "El usuario $usuario será eliminado del sistema, está seguro que desea eliminarlo S/N ?"
        read letra
        if [ $letra == 'S' -o == 's' ]; then
            echo "Usuario eliminado del sistema, presione enter para continuar"
            echo "$(date +%Y-%m-%d-%H:%M:%S) Usuario: $nomb eliminado del sistema" >> /root/log/log_propios/usuarios.txt
		    read pausa
        else
            echo "Operación cancelada, presione enter para volver al menú principal"
            read pausa
	else
        echo "Operación cancelada, presione enter para volver al menú principal"
        read pausa
    fi    
}

function listar_usuarios(){
    echo "USUARIOS DEL SISTEMA"
    cut -d ":" -f 1 /etc/passwd | sort | more
    echo "Presione enter para volver al menú principal"
    read pausa
}

function buscar_usuario(){ 
	clear
	#Nomeclatura del usuario apellidonombre
	echo "Ingrese el apellido y nombre del usuario en formato: apellidonombre: "
	read nombre
	usuario=$(echo $nombre | tr [:upper:] [:lower:])
	if [ $nomb -eq 1 ]; then
		echo "El usuario: $usuario existe en el sistema, presione enter para continuar"
		read pausa
	else
		echo "El usuario: $usuario no existe en el sistema, presione enter para continuar"
		read pausa
	fi
}

function cambiar_contra_usuario(){ 
	clear
	#Nomeclatura del usuario apellidonombre
	echo "Ingrese el apellido y nombre del usuario en formato: apellidonombre: "
	read nombre
	usuario=$(echo $nombre | tr [:upper:] [:lower:])
	if [ $nomb -eq 1 ]; then
		echo "Se procede a cambiar la contraseña al usuario $usuario"
		passwd $usuario
		read pausa
	else
		echo "El usuario: $usuario no existe en el sistema, presione enter para continuar"
		read pausa
	fi
}

function bloquear_usuario(){
	clear
	#Nomeclatura del usuario apellidonombre
	echo "Ingrese el apellido y nombre del usuario en formato: apellidonombre: "
	read nombre
	usuario=$(echo $nombre | tr [:upper:] [:lower:])
	if [ $nomb -eq 1 ]; then
		echo "Se procede a bloquear la cuenta del usuario $usuario"
		 passwd -lock usuario
		read pausa
	else
		echo "El usuario: $usuario no existe en el sistema, presione enter para continuar"
		read pausa
	fi
}

function desbloquear_usuario{
	clear
	#Nomeclatura del usuario apellidonombre
	echo "Ingrese el apellido y nombre del usuario en formato: apellidonombre: "
	read nombre
	usuario=$(echo $nombre | tr [:upper:] [:lower:])
	if [ $nomb -eq 1 ]; then
		echo "Se procede a desbloquear la cuenta del usuario $usuario"
		 passwd -u usuario
		read pausa
	else
		echo "El usuario: $usuario no existe en el sistema, presione enter para continuar"
		read pausa
	fi
}	
}
#********************************************************************************************************************
