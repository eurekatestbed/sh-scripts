#!/bin/bash
# 16:01 08/06/2016
# REM after dl prices file 
# rem load into table

homeDir=/home/ec2-user
scriptsDir=${homeDir}/scripts

texDir=${homeDir}/data/tex
files=*.tex

dbDir=${homeDir}/data
dbname=stocks.db
tname=prices

echo ----START $0 : `date` ----

#mkdir for datDir
if [ ! -d $texDir ]; then
	mkdir -p $texDir
fi 
if [ ! -d $dbDir ]; then
	mkdir -p $dbDir
fi 
#run create tables sql
if [ ! -f $dbDir/$dbname ]; then
	echo creating tables..
	sqlite3 $dbDir/$dbname ".read ${scriptsDir}/loader.create.sql"
fi

##for all file, import to db
echo importing data..
for file in ${texDir}/${files}; do
	if [ $(wc -c < $file ) -lt 10000 ]; then
		echo ${file##*/}: file size is under 10kb, skipping..
	else
		echo -e ".separator ;\n.import '${file}' ${tname}" | sqlite3 $dbDir/$dbname 
		echo ${file##*/} processed...
	fi
done
echo ----END $0 : `date` ----