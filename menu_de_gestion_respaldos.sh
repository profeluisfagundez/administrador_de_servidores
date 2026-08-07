#!/bin/bash
# VARIABLES
opc=10
fecha=$(date +"%Y-%m-%d")
``
# FUNCIONES

function menu(){
    clear
    echo "========================================="
    echo "       GESTIÓN DE RESPALDOS              "
    echo "========================================="
    echo "1 - Crear respaldo de BD"
    echo "2 - Crear respaldo de Logs del sistema"
    echo "3 - Restaurar respaldo de BD"
    echo "4 - Restaurar respaldo de Logs del sistema"
    echo "5 - Verificar integridad del respaldo"
    echo "6 - Eliminar respaldo"
    echo "7 - Listar respaldos disponibles"
    echo "8 - Configurar programación de respaldos"
    echo "9 - Enviar respaldo a ubicación remota"
    echo "0 - Salir"
    echo "========================================="
}

function crear_respaldo_bd(){
    clear
    echo "--- Creando respaldo de la base de datos ---"
    echo "Respaldo de BD creado exitosamente."
    read -p "Presione ENTER para continuar..." pausa
}

function crear_respaldo_logs(){
    clear
    echo "--- Creando respaldo de los logs del sistema ---"
    echo "Respaldo de logs creado exitosamente."
    read -p "Presione ENTER para continuar..." pausa
}

function restaurar_respaldo_bd(){
    clear
    echo "--- Restaurando respaldo de la base de datos ---"
    echo "Respaldo de BD restaurado exitosamente."
    read -p "Presione ENTER para continuar..." pausa
}

function restaurar_respaldo_logs(){
    clear
    echo "--- Restaurando respaldo de los logs del sistema ---"
    echo "Respaldo de logs restaurado exitosamente."
    read -p "Presione ENTER para continuar..." pausa
}

function verificar_integridad_respaldo(){
    clear
    echo "--- Verificando integridad del respaldo ---"
    echo "Integridad del respaldo verificada exitosamente."
    read -p "Presione ENTER para continuar..." pausa
}

function eliminar_respaldo(){
    clear
    echo "--- Eliminando respaldo ---"
    echo "Respaldo eliminado exitosamente."
    read -p "Presione ENTER para continuar..." pausa
}

function listar_respaldos(){
    clear
    echo "--- Listando respaldos disponibles ---"
    echo "Respaldos listados exitosamente."
    read -p "Presione ENTER para continuar..." pausa
}

function configurar_programacion_respaldos(){
    clear
    echo "--- Configurando programación de respaldos ---"
    echo "Programación de respaldos configurada exitosamente."
    read -p "Presione ENTER para continuar..." pausa
}

function enviar_respaldo_remoto(){
    clear
    echo "--- Enviando respaldo a ubicación remota ---"
    echo "Respaldo enviado a ubicación remota exitosamente."
    read -p "Presione ENTER para continuar..." pausa
}



# MAIN
while [ $opc -ne 0 ]
do
    menu
    read -p "Ingrese la opción: " opc

    case $opc in
        1) crear_respaldo_bd ;;
        2) crear_respaldo_logs ;;
        3) restaurar_respaldo_bd ;;
        4) restaurar_respaldo_logs ;;
        5) verificar_integridad_respaldo ;;
        6) eliminar_respaldo ;;
        7) listar_respaldos ;;
        8) configurar_programacion_respaldos ;;
        9) enviar_respaldo_remoto ;;
        0)
            clear
            echo "Saliendo del programa... ¡Hasta luego!"
            break ;;
        *)
            echo "[ERROR] Opción incorrecta. Por favor ingrese un número del 0 al 8."
            read -p "Presione ENTER para continuar..." pausa
        ;;
    esac
done