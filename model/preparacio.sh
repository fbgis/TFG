 #! /bin/bash

inici_s=`date +%s`

hdfs dfs -mkdir /user/mahout/
hdfs dfs -mkdir /user/mahout/tfg

hive -hiveconf flag="entrenament" -f 7CarrerarDadesHDFS.sql
mv dades/000000_0 dades/entrenament.txt
hdfs dfs -put dades/entrenament.txt /user/mahout/tfg
rm dades/entrenament.txt

hive -hiveconf flag="test" -f 7CarrerarDadesHDFS.sql
mv dades/000000_0 dades/test.txt
hdfs dfs -put dades/test.txt /user/mahout/tfg
rm dades/test.txt

mahout org.apache.mahout.classifier.df.tools.Describe -p /user/mahout/tfg/entrenament.txt -f /user/mahout/tfg/entrenament.info -d I 9 N L

hadoop jar $MAHOUT_HOME/mahout-examples-0.11.0-job.jar  org.apache.mahout.classifier.df.mapreduce.BuildForest -Dmapred.max.split.size=1874231 -d /user/mahout/tfg/entrenament.txt -ds /user/mahout/tfg/entrenament.info -sl 5 -p -t 100 -o /user/mahout/tfg/model

hadoop jar $MAHOUT_HOME/mahout-examples-0.11.0-job.jar  org.apache.mahout.classifier.df.mapreduce.TestForest -i /user/mahout/tfg/test.txt -ds /user/mahout/tfg/entrenament.info -m /user/mahout/tfg/model -a -mr -o /user/mahout/tfg/prediccions

fi_s=`date +%s`
let total_s=$fi_s-$inici_s

echo
echo "--------------------------- FI ---------------------------"
echo "Dades per a la generació del model preparades."
echo "Temps de processament: $total_s segons"
echo "--------------------------- FI ---------------------------"
