 #! /bin/bash

inici_s=`date +%s`

#Càrrega i tractament de les dades de contaminació
hive -f contaminacio.sql

fi_s=`date +%s`
let total_s=$fi_s-$inici_s

echo
echo "--------------------------- FI ---------------------------"
echo "Dades de contaminació carregades i tractades correctament."
echo "Temps de processament: $total_s segons"
echo "--------------------------- FI ---------------------------"

