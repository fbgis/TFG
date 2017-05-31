#! /bin/bash
# Execució del cas pràctic TFG.

inici_s=`date +%s`

#Càrrega a Hadoop i tractament previ de les dades meteorològiques
bash meteorologia/meteorologia.sh

#Càrrega a Hadoop i tractament previ de les dades d'inversió tèrmica
bash inverio_temica/inversio_termica.sh

#Càrrega a Hadoop i tractament previ de les dades de trànsit
bash transit/transit.sh

#Càrrega a Haddop i tractament previ de les dades de contaminació atmosfèrica
bash contaminacio/contaminacio.sh

#Unió de les dades, obtenció del conjunt de casos, del conjunt d'entrenament i del conjunt de test
bash conjunt_casos/conjunt_casos.sh

#Obtenció del model d'aprenentatge i avaluació de la seva qualitat
bash model/preparacio.sh
bash model/model.sh

fi_s=`date +%s`
let total_s=$fi_s-$inici_s

echo
echo "--------------------------- FI ---------------------------"
echo "S'ha finalitzat l'execució del cas pràctic"
echo "Temps total d'execució del cas pràctic: $total_s segons"
echo "--------------------------- FI ---------------------------"
