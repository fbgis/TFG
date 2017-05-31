 #! /bin/bash


inici_s=`date +%s`

#Generació del conjunt de casos, el conjunt d'entrenament i el conjunt de test
hive -f conjunt_casos.sql

fi_s=`date +%s`
let total_s=$fi_s-$inici_s

echo
echo "--------------------------- FI ---------------------------"
echo "Les taules s'han unit."
echo "Temps de processament: $total_s segons"
echo "--------------------------- FI ---------------------------"

