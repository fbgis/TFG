 #! /bin/bash
 # Las líneas que empiezan por "#" son comentarios
 # La primera línea o #! /bin/bash asegura que se interpreta como
 # un script de bash, aunque se ejecute desde otro shell.

inici_s=`date +%s`

let arg_p
let arg_nom
let arg_arbres
let arg_atributs

while true; do
    read -p "Nom del model? " yn
    case $yn in
 		[A-Za-z0-9]* ) arg_nom=$yn; break;;
    esac
done

while true; do
    read -p "Vols utilitzar implementació parcial? (S/N) " yn
    case $yn in
        [Ss]* ) arg_p='-p'; break;;
        [Nn]* ) arg_p=''; break;;
        * ) echo "Sisplau, respon sí (S) o no (N).";;
    esac
done

while true; do
    read -p "Número d'arbres? " yn
    case $yn in
        [0-9]* ) arg_arbres=$yn; break;;
        * ) echo "Sisplau, introdueix el número d'arbres.";;
    esac
done

while true; do
    read -p "Número d'atributs escollits aleatòriament en cada node? " yn
    case $yn in
        [0-9]* ) arg_atributs=$yn; break;;
        * ) echo "Sisplau, introdueix el número d'atributs.";;
    esac
done

hdfs dfs -mkdir /user/mahout/tfg/$arg_nom

hadoop jar $MAHOUT_HOME/mahout-examples-0.11.0-job.jar  org.apache.mahout.classifier.df.mapreduce.BuildForest -Dmapred.max.split.size=2336740 -d /user/mahout/tfg/entrenament.txt -ds /user/mahout/tfg/entrenament.info -sl $arg_atributs $p -t $arg_arbres -o /user/mahout/tfg/$arg_nom/model

hadoop jar $MAHOUT_HOME/mahout-examples-0.11.0-job.jar  org.apache.mahout.classifier.df.mapreduce.TestForest -i /user/mahout/tfg/test.txt -ds /user/mahout/tfg/entrenament.info -m /user/mahout/tfg/model -a -mr -o /user/mahout/tfg/$arg_nom/prediccions

fi_s=`date +%s`
let total_s=$fi_s-$inici_s

echo
echo "--------------------------- FI ---------------------------"
echo "Model d'aprenentage automàtic generat"
echo "Temps de processament: $total_s segons"
echo "--------------------------- FI ---------------------------"
