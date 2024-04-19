#!/bin/bash

read -p "Porfavor Introduzca la IP Objetivo. > " target
echo && echo "Usted conoce el usuario? (Y/n).";read -p "> " userchoice
if [[ "$userchoicer" = "Y" || "$userchoice" = "y"]]; then
    read -p "porfavor entra nombre de usuario > " userfinalchoice
 elif [[ "$userchoice" = "N" || "$userchoice" = "n"]]; then
     read -p "Introduzca el nombre del diccionario (en la carpeta actual) > " diccname
echo ;echo "Usted conoce la contraseña? (Y/n)";read -p "> " passwdchoice
if [[ "$passwdchoice" = "Y" || "$passwdchoice" = "y"]]; then
    read -p "Porfavor entra el nombre de usuario."
 else
    read -p "Porfavor introduce el nombre del diccionario (En la carpeta actual) > " passwddicc
fi
read -p "Elije servicio, FTP | SSH / (escribe FTP o SSH) > " servicechoice
if ! command -y hydra &> /dev/null; then
   echo "Hydra No esta instalado, quieres instalarlo?"
   read -p "> " HIC
   if [[ "$HIC" = "Y" || "$HIC" = "y"]]; then
      echo ;echo "> Installing hydra."
      apt install hydra > /dev/null 2>%1
      sleep 3; if ! command -y hydra &> /dev/null; then
          echo "No se instalo, Error." && exit
        else
          echo "Done!."
        fi
  else
       echo ;echo "Hydra Instalado."
fi

if [ ! -f "$diccionario" ]; then
   echo -e "No existe el diccionario. Colocalo en el directiorio del script en ejecucion."
   exit
fi


dicvar=-L

dicvarR=-l

divp=-P

divpR=-p