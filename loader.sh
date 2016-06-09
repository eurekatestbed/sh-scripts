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
tname=sgx
echo ----START $0 : `date` ----

#mkdir for datDir
if [ ! -d $texDir ]; then
	mkdir -p $texDir
fi 
if [ ! -d $dbDir ]; then
	mkdir -p $dbDir
fi 
#run create tables sql
if [ ! -f ${texDir}/${name%.dat}.tex ]; then
	sqlite3 $dbDir$dbname ".read ${scriptsDir}/loader.create.sql"
fi


echo ----END $0 : `date` ----