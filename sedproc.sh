#!/bin/bash
# 16:01 08/06/2016
# REM proc to clean spaces from dl files

homeDir=/home/ec2-user
datDir=${homeDir}/data/dat
texDir=${homeDir}/data/tex
files=*.dat
dlm=;

#debug
echo ----START $0 : `date` ----

#mkdir for datDir
if [ ! -d $datDir ]; then
	mkdir -p $datDir
fi 
#mkdir for texDir
if [ ! -d $texDir ]; then
	mkdir -p $texDir
fi 

cd ${datDir}
for file in ${datDir}/*.dat; do
	# echo $file
	
	#remove front filepath
	name=${file##*/}
	# echo $name
	
	#remove ext
	#base=${name%.dat}
	#echo $base
	
	#	REM remove double space/tab
	# echo sed-ing $file
	sed 's/  //g' <$file >tmp.01
	sed 's/	//g' <tmp.01 >tmp.02

	# #	REM remove space between delimiters
	sed 's/$dlm /$dlm/g' <tmp.02 >tmp.03
	sed 's/ $dlm/$dlm/g' <tmp.03 >tmp.04

	# #	REM remove space/tab from begining/end --^ *--(escaped ^)(begining ^)[(space/tab)](multiple *)(end $)
	# sed 's/^^[ \t]*//g' <tmp.04 >tmp.05
	# sed 's/[ \t]*$//g' <tmp.05 >tmp.00
	
	mv tmp.04 "${texDir}/${name%.dat}.tex"
	echo processed ${texDir}/${name%.dat}.tex
	
done

rm tmp.00
rm tmp.01
rm tmp.02
rm tmp.03
#rm tmp.04
#rm tmp.05

echo ----END $0 : `date` ----
