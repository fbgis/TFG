INSERT OVERWRITE LOCAL DIRECTORY '/home/ubuntu/dades/mapreduce8/model/dades' 
ROW FORMAT 
DELIMITED FIELDS TERMINATED BY ',' 
lines terminated by '\n'  
STORED AS TEXTFILE 
SELECT * FROM ${hiveconf:flag};
