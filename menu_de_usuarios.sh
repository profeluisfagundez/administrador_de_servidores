#!/bin/bash
#VARIABLES********
opc=10
year=$(date +%Y-%m-%d)
#*****************

#FUNCIONES**********************************************************************************************************
function menu(){
	clear
	echo "========================================="
    echo "       MENÚ DE GESTIÓN DE USUARIOS       "
    echo "========================================="
	echo "1 - Agregar usuario"
	echo "2 - Borrar usuario"
	echo "3 - Listar usuarios del sistema"
	echo "4 - Buscar un usuario en el sistema"
	echo "5 - Cambiar contraseña de un usuario"
	echo "6 - Bloquear usuario"
	echo "7 - Desbloquear usuario"
	echo "0 - Salir"
    echo "========================================="
}

function agregar_usuario(){
	clear
	#Nomeclatura del usuario apellidonombre
	echo "Ingrese el apellido y nombre del usuario en formato: apellidonombre: "
	read nombre
	nomb=$(echo $nombre | tr [:upper:] [:lower:])
	existe=$(cat /etc/passwd | grep -c $nomb)
	if [ $existe -eq 1 ]; then
		echo "El usuario ya existe"
		echo "El usuario $USER en la fecha $(date +%Y-%m-%d-%H:%M:%S) trato de crear un usuario con el nombre $nomb pero el usuario ya existe en /etc/passwd" >> /root/log/log_propios/usuarios.txt
		read pausa
	else
		echo "Ingrese el grupo: "
		read grupo
		user_group=$(echo $grupo | tr [:upper:] [:lower:])
		existe=$(cat /etc/group | grep -c $user_group)
		if [ $existe -eq 1 ]; then
			useradd -g $user_group -c "$user_group $year" -mk /etc/skel -s /bin/bash $nomb
			echo "$nomb:12345" | chpasswd
			echo "El usuario $USER en la fecha $(date +%Y-%m-%d-%H:%M:%S) agrego el usuario $nomb perteneciente al grupo $user_group al sistema" >> /root/log/log_propios/usuarios.txt
			echo "usuario dado de alta, se le asigno la contraseña 12345"
			read pausa
		else
			echo "El grupo no existe"
            echo "$(date +%Y-%m-%d-%H:%M:%S) se trato de agregar el grupo $user_group al sistema pero el grupo ya existe." >> /root/log/log_propios/grupos.txt
			read pausa
		fi
	fi
}

function borrar_usuario(){
	clear
	#Nomeclatura del usuario apellidonombre
	echo "Ingrese el apellido y nombre del usuario en formato: apellidonombre: "
	read nombre
	nomb=$(echo $nombre | tr [:upper:] [:lower:])
	existe=$(cat /etc/passwd | grep -c $nomb)
	if [ $existe -eq 1 ]; then
		echo "El usuario $nomb será eliminado del sistema, está seguro que desea eliminarlo S/N ?"
        read letra
        if [ $letra == 'S' -o $letra == 's' ]; then
            echo "Usuario eliminado del sistema, presione enter para continuar"
            echo "$(date +%Y-%m-%d-%H:%M:%S) Usuario: $nomb eliminado del sistema" >> /root/log/log_propios/usuarios.txt
		    read pausa
        else
            echo "Operación cancelada, presione enter para volver al menú principal"
            read pausa
		fi
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
	nomb=$(echo $nombre | tr [:upper:] [:lower:])
	existe=$(cat /etc/passwd | grep -c $nomb)
	if [ $existe -eq 1 ]; then
		echo "El usuario: $nomb existe en el sistema, presione enter para continuar"
		read pausa
	else
		echo "El usuario: $nomb no existe en el sistema, presione enter para continuar"
		read pausa
	fi
}

function cambiar_contra_usuario(){ 
	clear
	#Nomeclatura del usuario apellidonombre
	echo "Ingrese el apellido y nombre del usuario en formato: apellidonombre: "
	read nombre
	nomb=$(echo $nombre | tr [:upper:] [:lower:])
	existe=$(cat /etc/passwd | grep -c $nomb)
	if [ $existe -eq 1 ]; then
		echo "Se procede a cambiar la contraseña al usuario $nomb"
		passwd $nomb
		read pausa
	else
		echo "El usuario: $nomb no existe en el sistema, presione enter para continuar"
		read pausa
	fi
}

function bloquear_usuario(){
	clear
	#Nomeclatura del usuario apellidonombre
	echo "Ingrese el apellido y nombre del usuario en formato: apellidonombre: "
	read nombre
	nomb=$(echo $nombre | tr [:upper:] [:lower:])
	existe=$(cat /etc/passwd | grep -c $nomb)
	if [ $existe -eq 1 ]; then
		echo "Se procede a bloquear la cuenta del usuario $nomb"
		 usermod -L $nomb
		read pausa
	else
		echo "El usuario: $nomb no existe en el sistema, presione enter para continuar"
		read pausa
	fi
}

function desbloquear_usuario(){
	clear
	#Nomeclatura del usuario apellidonombre
	echo "Ingrese el apellido y nombre del usuario en formato: apellidonombre: "
	read nombre
	nomb=$(echo $nombre | tr [:upper:] [:lower:])
	existe=$(cat /etc/passwd | grep -c $nomb)
	if [ $existe -eq 1 ]; then
		echo "Se procede a desbloquear la cuenta del usuario $nomb"
		 usermod -U $nomb
		read pausa
	else
		echo "El usuario: $nomb no existe en el sistema, presione enter para continuar"
		read pausa
	fi
}	

while [ $opc -ne 0 ]
do
	clear
	menu
	read -p "Ingrese la opción correspondiente: " opc
	case $opc in
	1)
		agregar_usuario;;
	2)
		borrar_usuario;;
	3)
		listar_usuarios;;
	4)
		buscar_usuario;;
	5)
		cambiar_contra_usuario;;
	6)
		bloquear_usuario;;
	7)
		desbloquear_usuario;;
	0)
		echo "Volviendo al menú principal"; break ;; 
	*)
		echo "Seleccionó una opción incorrecta";;
	esac
done
#********************************************************************************************************************
