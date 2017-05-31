 #! /bin/bash

inici_s=`date +%s`

#Creació de la taula temporal on s'emmagatzemaran les dades prèviament tractades
hive -f 1CrearTaulaTemporal.sql

echo "----------------------------------------------------------"
echo "Taula Trànsit creada."
echo "----------------------------------------------------------"

#Obtenció dels directors on es troben les dades de trànsit
ls -d */ > directoris.txt

#Per a cada directori es tracten els arxius amb dades de trànsit
for directori in $(cat directoris.txt)
	do

	direc=${directori%?}

	cd $directori

	ls *.txt > taules.txt

	#Càrrega i tractament de cadascun dels arxius amb dades de trànsit
	for line in $(cat taules.txt)
	do 
		#Càrrega i tractament d'un arxiu mensual
	    hive -hiveconf flag2=${line%%.*} -f ../2CarregarDadesSensor.sql

	    #Càrrega de les dades tractades a la taula temporal
	    hive -hiveconf flag1=${direc} -f ../3CarregarDadesTaulaTemporal.sql

	    echo "----------------------------------------------------------"
		echo "Dades del fitxer: " $line " tractades i carregades."
		echo "----------------------------------------------------------"
	done

	rm taules.txt

	echo "----------------------------------------------------------"
	echo "S'han tractat les dades del directori: "$direc
	echo "----------------------------------------------------------"

	cd ..

done

rm directoris.txt

#Suma dels valors dels diversos sensors i elimianció dels casos amb valors nuls
hive -f 4CarregarDadesFinal.sql

fi_s=`date +%s`
let total_s=$fi_s-$inici_s
echo
echo "--------------------------- FI ---------------------------"
echo "Dades de trànsit carregades i tractades."
echo "Temps de processament: $total_s segons"
echo "--------------------------- FI ---------------------------"

