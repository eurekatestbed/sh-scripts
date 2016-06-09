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
idx=$dbDir/idx.ini
loadFile=load.tex
backupFile=${dbDir}/all.tex
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
#backup old ptr
echo `cat ${idx}`: `date` >> $idx.bak

##for all file, import to db
echo @@@Concating  data..
for file in ${texDir}/${files}; do
	
	#check if file is after last processed file
	if [[ ${file##*/} > `cat $idx` ]]; then
		#process file
		if [ $(wc -c < $file ) -lt 10000 ]; then
			#reject error / non table files
			echo ${file##*/}: file size is under 10kb, skipping..
		else
			#echo -e ".separator ;\n.import '${file}' ${tname}" | sqlite3 $dbDir/$dbname 
			#combine the file into one giant text file for more efficient bulk importing
			cat ${file} >> ${dbDir}/${loadFile} ##JEXREM change to >>later
			echo ${file##*/} processed... 
			echo ${file##*/} > $idx
		fi
		
	else
	#skip file
		echo pointer skip ${file##*/} till `cat $idx`
	fi


done

#do actual import here
echo @@@ Importing files to db now... `date`
#echo -e ".separator ';'\n.import ${dbDir}/${loadFile} ${tname}" 
#echo $dbDir/$dbname 

echo -e ".separator ';'\n.import ${dbDir}/${loadFile} ${tname}" | sqlite3 $dbDir/$dbname 
cat ${dbDir}/${loadFile} >> ${backupFile}
rm ${dbDir}/${loadFile}

echo ----END $0 : `date` ----




	# echo grep: `grep $file $idx`
	# if [ -z `grep $file $idx` ]; then
		# echo pointer skip $file
		# echo cat $idx
	# else
		# echo found
	# fi
