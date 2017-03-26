#!/bin/sh

FTP_HOST="124.108.10.55"
FTP_USERNAME="ott_ts_tplay"
FTP_PASSWORD="ott_ts_tplay"

function upload_file()
{
lftp -e "set net:timeout 10;set net:max-retries 5; \
set net:reconnect-interval-base 10; \
set net:reconnect-interval-max 300; \
set net:reconnect-interval-multiplier 2; \
at now + 15 minutes -- exit top kill&; \
cd; \
mput ${_zipfile}; \
exit top kill;" ftp://$FTP_USERNAME:$FTP_PASSWORD@$FTP_HOST:21
[ $? = 0 ] && echo "file upload successfully." 
}

splitname=`date +%Y-%m-%d-%H-%M`;
names=("TONOFF" "TAPP" "TUPGRADE" "TPLAY" "TSPLAY" "TPLAYDOWNAVGRATE" "TPLAYLOADING" "TERR" "TSERVICEACCESQOS" "TRECOMMENDCLICK" "TVISITPAGE");
logDir="";
path="";
dir=`dirname $0`
cat $dir/config.properties | while read line
do
   arr=(${line//=/ }); 
   if [ "$arr" = "tmlogDir" ];then 
     logDir=${arr[1]};
     for var in ${names[@]};do
        path=$logDir/${var};
        if [ -f $path ];then
         mkdir -p $logDir/bak;
         mv $path  $logDir/bak/${var}.$splitname;
         _logdir="$logDir/bak/${var}/"
         _logfile="${var}_`date +%Y%m%d%H00`_OTT_.log"
         _zipfile="${var}_`date +%Y%m%d%H00`_OTT_.zip"
         mkdir -p $_logdir
         mv $path ${_logdir}/$_logfile
         cd ${_logdir}
         /usr/bin/zip ./$_zipfile ./$_logfile && rm -f ./$_logfile
         #upload_file
        fi
     done
     /usr/bin/find $logDir/bak -type f -name '*.zip' -mtime +15 -exec rm -rf {} \; 
   fi
done
