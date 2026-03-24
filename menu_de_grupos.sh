#!/bin/bash
#VARIABLES**************
opc=10
year=$(date +%Y-%m-%d)
#***********************

#FUNCIONES******************************************************************************************************
function menu(){
	clear
	echo "MENÚ DE GESTIÓN DE USUARIOS"
	echo "1 - Agregar grupo"
	echo "2 - Borrar grupo"
	echo "3 - Listar grupo del sistema"
	echo "4 - Buscar un grupo en el sistema"
	echo "0 - Salir"
}

function listar_grupos(){
    echo "GRUPOS DEL SISTEMA"
    cut -d ":" -f 1 /etc/groups | sort | more
    echo "Presione enter para volver al menú principal"
    read pausa
}

function agregar_grupo(){
	read -p "Ingrese el nombre del grupo a agregar: " grupoUsuario
	grupo=$(echo $grupoUsuario | tr [:upper:] [:lower:])
	if [ $(getent group $grupo) ]; then
		echo "El grupo $grupo ya existe en el sistema"
	else
		groupadd $grupo
		if [ $? -eq 0 ]; then
			echo "Grupo $grupo agregado exitosamente"
		else
			echo "Error al agregar el grupo $grupo"
		fi
	fi
	echo "Presione enter para volver al menú principal"
	read pausa
}

function borrar_grupo(){
	read -p "Ingrese el nombre del grupo a borrar: " grupoUsuario
	grupo=$(echo $grupoUsuario | tr [:upper:] [:lower:])
	if [ $(getent group $grupo) ]; then
		groupdel $grupo
		if [ $? -eq 0 ]; then
			echo "Grupo $grupo borrado exitosamente"
		else
			echo "Error al borrar el grupo $grupo"
		fi
	else
		echo "El grupo $grupo no existe en el sistema"
	fi
	echo "Presione enter para volver al menú principal"
	read pausa
}

function buscar_grupo(){
	read -p "Ingrese el nombre del grupo a buscar: " grupoUsuario
	grupo=$(echo $grupoUsuario | tr [:upper:] [:lower:])
	if [ $(getent group $grupo) ]; then
		echo "El grupo $grupo existe en el sistema"
	else
		echo "El grupo $grupo no existe en el sistema"
	fi
	echo "Presione enter para volver al menú principal"
	read pausa
}


#***************************************************************************************************************

#MAIN***********************************************************************************************************
while [ $opc -ne 0 ]
do
	clear
	menu
	read -p "Ingrese la opción correspondiente: " opc
	case $opc in
	1)
		agregar_grupo;;
	2)
		borrar_grupo;;
	3)
		listar_grupos;;
	4)
		buscar_grupo;;
	0)
		echo "Volviendo al menú principal"; break ;; 
	*)
		echo "Seleccionó una opción incorrecta";;
	esac
done
#***************************************************************************************************************