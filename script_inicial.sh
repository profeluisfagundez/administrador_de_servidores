#!/bin/bash
#SCRIPT INICIAL DEL SERVIDOR
opc=0

function menu(){
    echo "MENÚ PRINCIPAL"
    echo "1 - Gestión de usuarios"
    echo "2 - Gestión de grupos"
    echo "3 - Gestión de respaldos"
    echo "4 - Gestión de redes"
    echo "5 - Gestión de Bases de datos"
    echo "6 - Gestión de Firewall"
    echo "7 - Gestión de Logs del Sistema"
    echo "8 - Salir"
    echo "Ingrese una opción: "
}


while [ $opc -ne 8 ];
do
    menu
    read opc
    case $opc in
        1)
            echo "Gestión de Usuarios";;
        2)
            echo "Gestión de Grupos";;
        3)
            echo "Gestión de Respaldos";;
        4)
            echo "Gestión de Redes";;
        5)
            echo "Gestión de Bases de Datos";;
        6)
            echo "Gestión de Firewall";;
        7)
            echo "Gestión de Logs";;
        8)
            echo "Hasta pronto!, buena jornada"; break ;;
        *)
            echo "Opción no soportada por el sistema";;

    esac
done
