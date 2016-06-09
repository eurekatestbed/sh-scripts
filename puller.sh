#!/bin/bash
# 13:07 08/06/2016
# REM dl prices files from web
PREV_DAYS=3650
homeDir=/home/ec2-user
datDir=${homeDir}/data/dat

#debug
echo ----START $0 : `date` ----

#mkdir for datDir
if [ ! -d $datDir ]; then
	mkdir -p $datDir
fi 

#get file from server
for i in `seq 0 $PREV_DAYS`
do
	#iterate dates
	fdate=`date -d "-${i}days" +%F`
	#check file exists, else dl files
	if [ ! -f ${datDir}/SESprice_${fdate}.dat ]; then
		wget "http://infopub.sgx.com/Apps?A=COW_Prices_Content&B=SecuritiesHistoricalPrice&F=4451&G=SESprice.dat&H=${fdate}" -O ${datDir}/SESprice_${fdate}.dat
	else
		echo $fdate found
	fi
done 

#echo "http://infopub.sgx.com/Apps?A=COW_Prices_Content&B=SecuritiesHistoricalPrice&F=4451&G=SESprice.dat&H=$(date +%F)" -O ${datDir}SESprice_$(date --date='-$i day' +%F).dat

#wget "http://infopub.sgx.com/Apps?A=COW_Prices_Content&B=SecuritiesHistoricalPrice&F=4704&G=SESprice.dat&H=2016-06-07"

echo ----END $0 : `date` 