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