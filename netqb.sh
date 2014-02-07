#!/usr/bin/bash
#by Hoang Le P
#version1, 8/12/2013 8:18AM
Y=$(date +"%Y")
M=$(date +"%m")
D=$(date +"%d")
H=$(date +"%H")
D1=$(($D - 1))
D2=$(($D - 2))
D3=$(($D - 3))
month=$(date +"%b")


function get_axe {
echo "Collect NETQB for AXE node"
cd /home/ericsson/netqb/log/axe
if [ ! -d $month ]; then
  mkdir $month
fi

cd /var/opt/ericsson/sgw/outputfiles/asn1/apg_sts
ls > /home/ericsson/netqb/list_ne.txt
while read ne_folder
do
  echo $ne_folder
  cd $ne_folder
    zip /home/ericsson/netqb/log/axe/$month/$ne_folder.zip *$Y$M*$D1.10* *$Y$M*$D1.11* *$Y$M*$D1.12* *$Y$M*$D1.13* *$Y$M*$D1.14*
    zip /home/ericsson/netqb/log/axe/$month/$ne_folder.zip *$Y$M*$D2.10* *$Y$M*$D2.11* *$Y$M*$D2.12* *$Y$M*$D2.13* *$Y$M*$D2.14*
    zip /home/ericsson/netqb/log/axe/$month/$ne_folder.zip *$Y$M*$D3.10* *$Y$M*$D3.11* *$Y$M*$D3.12* *$Y$M*$D3.13* *$Y$M*$D3.14*
  cd ..
done < /home/ericsson/netqb/list_ne.txt
rm /home/ericsson/netqb/list_ne.txt

echo
echo \>\>\>Log files is store in: /home/ericsson/netqb/log/axe/$month
}

function get_rnc {
	echo "collecting rnc log"
cd /home/ericsson/netqb/log/cpp
if [ ! -d $month ]; then
  mkdir $month
fi

cd /var/opt/ericsson/nms_umts_pms_seg/segment1/XML
ls > /home/ericsson/netqb/list_rnc.txt
while read rnc_folder
do
  echo $rnc_folder
  cd $rnc_folder
  rm /home/ericsson/netqb/tmp_rbs_list.txt
  ls | egrep 'MeContext' > /home/ericsson/netqb/tmp_rbs_list.txt
  while read rbs_folder
  do
    cd $rbs_folder
    zip /home/ericsson/netqb/log/cpp/$month/$rnc_folder.zip A$Y$M*$D1.17* A$Y$M*$D1.18* A$Y$M*$D1.19* A$Y$M*$D1.20* A$Y$M*$D1.21*
    zip /home/ericsson/netqb/log/cpp/$month/$rnc_folder.zip A$Y$M*$D2.17* A$Y$M*$D2.18* A$Y$M*$D2.19* A$Y$M*$D2.20* A$Y$M*$D2.21*
    zip /home/ericsson/netqb/log/cpp/$month/$rnc_folder.zip A$Y$M*$D3.17* A$Y$M*$D3.18* A$Y$M*$D3.19* A$Y$M*$D3.20* A$Y$M*$D3.21*
    cd ..
  done < /home/ericsson/netqb/tmp_rbs_list.txt
  cd ..
done < /home/ericsson/netqb/list_rnc.txt

rm /home/ericsson/netqb/tmp_rbs_list.txt
echo
echo \>\>\>Log files is store in: /home/ericsson/netqb/log/cpp/$month
}

function get_mgw {
	echo "collecting mgw log"
	cd /home/ericsson/netqb/log/cpp
if [ ! -d $month ]; then
  mkdir $month
fi

cd /var/opt/ericsson/sgw/outputfiles/xml/mgw
ls > /home/ericsson/netqb/list_ne.txt
while read ne_folder
do
  echo $ne_folder
  cd $ne_folder
    zip /home/ericsson/netqb/log/cpp/$month/$ne_folder.zip A$Y$M*$D1.17* A$Y$M*$D1.18* A$Y$M*$D1.19* A$Y$M*$D1.20* A$Y$M*$D1.21*
    zip /home/ericsson/netqb/log/cpp/$month/$ne_folder.zip A$Y$M*$D2.17* A$Y$M*$D2.18* A$Y$M*$D2.19* A$Y$M*$D2.20* A$Y$M*$D2.21*
    zip /home/ericsson/netqb/log/cpp/$month/$ne_folder.zip A$Y$M*$D3.17* A$Y$M*$D3.18* A$Y$M*$D3.19* A$Y$M*$D3.20* A$Y$M*$D3.21*
  cd ..
done < /home/ericsson/netqb/list_ne.txt
rm /home/ericsson/netqb/list_ne.txt
echo
echo \>\>\>Log files is store in: /home/ericsson/netqb/log/cpp/$month
}


function usage {
cat <<EOF
Usage:
 1) Collect netqb for RNC node: $0 rnc
 2) Collect netqb for AXE node: $0 axe 
 3) Collect netqb for MGW node: $0 mgw 
EOF
}


if [[ $1 = "rnc" ]] ; then get_rnc
elif [[ $1 = "axe" ]] ; then get_axe
elif [[ $1 = "mgw" ]] ; then get_mgw
else
	usage
fi
