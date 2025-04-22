#!/bin/bash
#VARIABLES***************
opc=10
year=$(date +%Y-%m-%d)
#************************

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
	echo "0 - Salir"
}

function listarUsuarios(){
    echo "Listando usuarios..."
    cut -d ":" -f1 /etc/passwd | sort | more
    echo "Presione una tecla para continuar..."
    read pausa
}

function buscarUsuario(){
    echo "Ingrese el nombre del usuario a buscar en el sistema"
    read usuario
    user=$(echo $usuario | tr [:upper:] [:lower:])
    $existeUsuario(cat /etc/passwd | grep -w -c $usuario)
    if [ $existeUsuario -eq 0 ]; then
        echo "El usuario $usuario no existe en el sistema"
    else
        echo "El usuario $usuario existe en el sistema"
        cat /etc/passwd | grep -w $usuario
    fi
}

function agregarUsuarios(){
    clear
    echo "Ingrese el nombre del usuario a dar de alta en el sistema"
    read usuario
    user=$(echo $usuario | tr [:upper:] [:lower:])
    existeUsuario=$(cat /etc/passwd | grep -w -c $user)
    if [ $existeUsuario -eq 0 ]; then
        echo "Ingrese el nombre del grupo existente en el sistema"
        read grupo
        existeGrupo=$(cat /etc/group | grep -w -c $grupo)
        if [ $existeGrupo -eq 0 ]; then
            echo "El grupo $grupo no existe, por favor verifique el nombre del grupo"
        else
            useradd -g $grupo -c "$grupo $year" -d /home/$user -m -s /bin/bash $user    
            echo "Usuario dado de alta"
        fi
    else
        echo "El usuario $usuario ya existe."
    fi
}

function borrar_usuario(){
	clear
	echo "Ingrese el apellido y nombre del usuario en formato: apellidonombre: "
	read nombre
	user=$(echo $nombre | tr [:upper:] [:lower:])
	nomb=$(cat /etc/passwd | grep -c -w $user)
	if [ $nomb -eq 1 ]; then
		echo "El usuario $user será eliminado del sistema, está seguro que desea eliminarlo S/N ?"
        read letra
        if [ $letra == 'S' -o == 's' ]; then
            echo "Usuario eliminado del sistema, presione enter para continuar"
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


while [ $opc -ne 0 ]
do
	clear
	menu
	read -p "Ingrese la opción correspondiente: " opc
	case $opc in
	1)
		echo "agregar_usuario"; read a ;;
	2)
		echo "borrar_usuario"; read a ;;
	3)
		listarUsuarios ;;
	4)
		echo "buscar_usuario"; read a ;;
	5)
		echo "cambiar_contra_usuario"; read a ;;
	6)
		echo "bloquear_usuario"; read a ;;
	7)
		echo "desbloquear_usuario" ; read a ;;
	0)
		echo "Volviendo al menú principal"; break ;; 
	*)
		echo "Seleccionó una opción incorrecta"; read a ;;
	esac
done