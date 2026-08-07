#!/bin/bash
# VARIABLES
opc=10
fecha=$(date +"%Y-%m-%d")

# FUNCIONES

function menu(){
    clear
    echo "========================================="
    echo "       GESTIÓN DE FIREWALLD              "
    echo "========================================="
    echo "1 - Verificar estado de FirewallD"
    echo "2 - Permitir HTTP y HTTPS"
    echo "3 - Bloquear una IP"
    echo "4 - Establecer políticas restrictivas"
    echo "5 - Habilitar solicitudes de ping"
    echo "6 - Listar servicios permitidos"
    echo "7 - Bloquear dirección MAC"
    echo "8 - Agregar servicio"
    echo "0 - Salir"
    echo "========================================="
}

function verificar_firewall(){
    clear
    echo "--- Estado de FirewallD ---"
    firewall-cmd --state
    read -p "Presione ENTER para continuar..." pausa
}

function permitir_http_https(){
    clear
    echo "--- Permitiendo tráfico HTTP y HTTPS ---"
    firewall-cmd --permanent --add-service=http
    firewall-cmd --permanent --add-service=https
    firewall-cmd --reload
    echo ""
    read -p "Presione ENTER para continuar..." pausa
}

function bloquear_ip(){
    clear
    echo "--- Bloquear una Dirección IP ---"
    read -p "Ingrese la dirección IP a bloquear (Ej. 192.168.1.50): " ip
    #firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address="192.168.1.200" drop'
    firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='$ip' drop"
    firewall-cmd --reload
    read -p "Presione ENTER para continuar..." pausa
}

function politicas_restrictivas(){
    clear
    echo "--- Estableciendo Políticas Restrictivas en el Servidor---"
    echo "Cambiando la zona por defecto a 'drop'- Descarta todo tráfico no explícitamente permitido"
    firewall-cmd --set-default-zone=drop
    echo ""
    read -p "Presione ENTER para continuar..." pausa
}

function habilitar_ping(){
    clear
    echo "--- Habilitar solicitudes de PING ---"
    firewall-cmd --permanent --add-rich-rule='rule protocol value="icmp" accept'
    firewall-cmd --reload
    echo "Solicitudes de Ping habilitadas."
    echo ""
    read -p "Presione ENTER para continuar..." pausa
}

function listar_servicios(){
    clear
    echo "--- Servicios permitidos en la zona actual ---"
    zona=$(firewall-cmd --get-default-zone)
    echo "Zona actual: $zona"
    echo "Servicios habilitados:"
    firewall-cmd --list-services
    echo ""
    read -p "Presione ENTER para continuar..." pausa
}

function bloquear_mac(){
    clear
    echo "--- Bloquear una Dirección MAC ---"
    read -p "Ingrese la dirección MAC a bloquear (Ej. 00:1A:2B:3C:4D:5E): " mac
    firewall-cmd --permanent --add-rich-rule="rule source mac='$mac' drop"
    firewall-cmd --reload
    echo "Dirección MAC $mac bloqueada exitosamente."
    read -p "Presione ENTER para continuar..." pausa
}

function agregar_servicio(){
    clear
    echo "--- Agregar Nuevo Servicio a FirewallD ---"
    read -p "Ingrese el nombre del servicio (Ej. mysql, mariadb, dns): " servicio
    
    if [ -n "$servicio" ]; then
        # Intentamos agregar el servicio. Redirigimos stderr a null temporalmente para capturar el error limpio.
        if firewall-cmd --permanent --add-service=$servicio 2>/dev/null; then
            firewall-cmd --reload
            echo -e "\n[OK] Servicio '$servicio' agregado correctamente."
        else
            echo -e "\n[ERROR] El servicio '$servicio' no es válido o no existe en FirewallD."
        fi
    else
        echo -e "\n[ERROR] El nombre del servicio no puede estar vacío."
    fi
    echo ""
    read -p "Presione ENTER para continuar..." pausa
}

# MAIN

while [ $opc -ne 0 ]
do
    menu
    read -p "Ingrese la opción: " opc

    case $opc in
        1) verificar_firewall ;;
        2) permitir_http_https ;;
        3) bloquear_ip ;;
        4) politicas_restrictivas ;;
        5) habilitar_ping ;;
        6) listar_servicios ;;
        7) bloquear_mac ;;
        8) agregar_servicio ;;
        0)
            echo "Saliendo del programa... ¡Hasta luego!"
        ;;
        *)
            echo "[ERROR] Opción incorrecta. Por favor ingrese un número del 0 al 8."
            read -p "Presione ENTER para continuar..." pausa
        ;;
    esac
done