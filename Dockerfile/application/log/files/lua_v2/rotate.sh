#!/bin/sh
#set -xv
splitname=`date +%Y-%m-%d-%H-%M`;
names=("TONOFF" "TAPP" "TUPGRADE" "TPLAY" "TSPLAY" "TPLAYDOWNAVGRATE" "TPLAYLOADING" "TERR" "TSERVICEACCESQOS" "TRECOMMENDCLICK" "TVISITPAGE" "TPROPAGE" "TBIND" "TFAVORITES");
logDir="";
path="";
dir=$(cd "$(dirname "$0")"; pwd)
cat $dir'/config.properties' |while read line
 do
   arr=(${line//=/ }); 
  if [ "$arr" = "tmlogDir" ];
  then 
    logDir=${arr[1]};
 for var in ${names[@]}
  do
   path=$logDir/${var};
   if [ -f $path ];
   then
    mv $path  $logDir/bak/${var}.$splitname;
   fi
done
  fi
done
