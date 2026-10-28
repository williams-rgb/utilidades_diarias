#!/bin/bash

# Colores para que sea más visual
verde="\e[32m"
azul="\e[34m"
rojo="\e[31m"
amarillo="\e[33m"
fin="\e[0m"

while true; do
    clear
    echo -e "${azul}=============================="
    echo -e "   UTILIDADES DIARIAS - LINUX"
    echo -e "==============================${fin}"
    echo "1) Actualizar el sistema completo"
    echo "2) Limpiar caché y paquetes huérfanos"
    echo "3) Ver espacio en disco (Disk Usage)"
    echo "4) Ver uso de memoria RAM y CPU"
    echo "5) Buscar un archivo por nombre"
    echo "6) Crear una nueva carpeta"
    echo "7) Salir"
    echo -e "==============================${fin}"
    read -p "Elige una opción [1-7]: " opcion

    case $opcion in
        1)
            echo -e "\n${verde}Actualizando el sistema...${fin}"
            sudo apt update && sudo apt upgrade -y
            ;;
        2)
            echo -e "\n${verde}Limpiando paquetes innecesarios...${fin}"
            sudo apt autoremove -y && sudo apt clean
            ;;
        3)
            echo -e "\n${verde}Espacio en disco:${fin}"
            df -h
            ;;
        4)
            echo -e "\n${verde}Uso de recursos (Presiona 'q' para salir):{fin}"
            top
            ;;
        5)
            echo -e "\n"
            read -p "Introduce el nombre del archivo a buscar: " nombre
            find . -name "*$nombre*" 2>/dev/null
            ;;
        6)
            echo -e "\n${verde}--- Asistente para Crear Carpeta ---${fin}"
            read -p "Introduce el nombre que quieres darle a la carpeta: " nombre_carpeta

            if [ -z "$nombre_carpeta" ]; then
                echo -e "${rojo}Error: El nombre no puede estar vacío.${fin}"
            else
                echo -e "\n¿Dónde quieres crear la carpeta?"
                echo "1) Carpeta actual ($(pwd))"
                echo "2) Directorio Home (~)"
                echo "3) Documentos (~/Documentos)"
                echo "4) Descargas (~/Descargas)"
                read -p "Elige una opción de ubicación [1-4]: " lugar

                case $lugar in
                    1) ruta_base="." ;;
                    2) ruta_base="$HOME" ;;
                    3) ruta_base="$HOME/Documentos" ;;
                    4) ruta_base="$HOME/Descargas" ;;
                    *) ruta_base="" ;;
                esac

                if [ -n "$ruta_base" ]; then
                    # Ruta completa final donde se intentará crear
                    ruta_completa="$ruta_base/$nombre_carpeta"

                    # Comprobar si ya existe
                    if [ -e "$ruta_completa" ]; then
                        echo -e "\n${amarillo}Aviso: Ya existe un archivo o carpeta con ese nombre en esa ubicación:${fin}"
                        echo -e "${azul}$ruta_completa${fin}"
                    else
                        mkdir -p "$ruta_completa"
                        echo -e "\n${verde}¡Carpeta creada con éxito!${fin}"
                        echo -e "Ubicación: ${azul}$ruta_completa${fin}"
                    fi
                else
                    echo -e "\n${rojo}Opción de ubicación no válida.${fin}"
                fi
            fi
            ;;
        7)
            echo -e "\n${azul}¡Hasta luego!${fin}"
            exit 0
            ;;
        *)
            echo -e "\n${rojo}Opción no válida. Inténtalo de nuevo.${fin}"
            ;;
    esac

    echo -e "\n"
    read -p "Presiona [Enter] para continuar..."
done
