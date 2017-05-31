 #! /bin/bash

inici_s=`date +%s`

hive -f meteorologia.sql

fi_s=`date +%s`
let total_s=$fi_s-$inici_s
echo
echo "--------------------------- FI ---------------------------"
echo "Dades meteorològiques carregades i tractades correctament."
echo "Temps de processament: $total_s segons"
echo "--------------------------- FI ---------------------------"


