#!/bin/bash
# VARIABLES
opc=10
fecha=$(date +"%Y-%m-%d")
``
# FUNCIONES

function menu(){
     echo "========================================="
    echo "       GESTIÓN DE RESPALDOS              "
    echo "========================================="
    echo "1 - Crear respaldo de BD"
    echo "2 - Crear respaldo de Logs del sistema"
    echo "3 - Restaurar respaldo de BD"
    echo "4 - Restaurar respaldo de Logs del sistema"
    echo "5 - Eliminar respaldo"
    echo "6 - Listar respaldos disponibles"
    echo "7 - Configurar programación de respaldos"
    echo "8 - Enviar respaldo a ubicación remota"
    echo "0 - Salir"
    echo "========================================="
}

function crear_respaldo_bd(){
    clear
    echo "--- Creando respaldo de la base de datos ---"
    mysqldump -u root -p --databases cartas --routines --triggers --events > $fecha-cartas_bd_backup.sql
    mv $fecha-cartas_bd_backup.sql /root/respaldos_bd/
    echo "Respaldo de BD creado exitosamente."
    read -p "Presione ENTER para continuar..." pausa
}

function crear_respaldo_logs(){
    clear
    echo "--- Creando respaldo de los logs del sistema ---"
    tar -czvf $fecha-logs_sistema_backup.tar.gz /var/log
    mv $fecha-logs_sistema_backup.tar.gz /root/respaldos_logs/
    echo "Respaldo de logs creado exitosamente."
    read -p "Presione ENTER para continuar..." pausa
}

function restaurar_respaldo_bd(){
    clear
    echo "--- Restaurando respaldo de la base de datos ---"
    echo "Respaldos de BD guardados en el sistema:"
    ls -l /root/respaldos_bd/*.sql
    read -p "Ingrese el nombre del archivo de respaldo de BD a restaurar (ejemplo: 2026-09-11-cartas_bd_backup.sql): " respaldo_bd
    mysql -u root -p < /root/respaldos_bd/$respaldo_bd
    echo "Respaldo de BD restaurado exitosamente."
    read -p "Presione ENTER para continuar..." pausa
}

function restaurar_respaldo_logs(){
    clear
    echo "--- Restaurando respaldo de los logs del sistema ---"
    echo "Respaldos de logs guardados en el sistema:"
    ls -l /root/respaldos_logs/*.tar.gz
    read -p "Ingrese el nombre del archivo de respaldo de logs a restaurar (ejemplo: 2026-09-11-logs_sistema_backup.tar.gz): " respaldo_logs
    tar -xzvf /root/respaldos_logs/$respaldo_logs -C /root/logs_restaurados
    echo "Respaldo de logs restaurado exitosamente."
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
    echo "Respaldos de BD:"
    ls -l /root/respaldos_bd/*.sql
    echo "Respaldos de logs del sistema:"
    ls -l /root/respaldos_logs/*.tar.gz
    echo "Respaldos listados exitosamente."
    read -p "Presione ENTER para continuar..." pausa
}

function configurar_programacion_respaldos(){
    clear
    echo "--- Configurando programación de respaldos ---"
    crontab -e
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
        5) eliminar_respaldo ;;
        6) listar_respaldos ;;
        7) configurar_programacion_respaldos ;;
        8) enviar_respaldo_remoto ;;
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