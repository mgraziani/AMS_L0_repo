#!/bin/bash

if [ $# -eq 0 ]
  then
    echo "You have to pass: FIRST AMS BLOCK - LAST AMS BLOCK - AMS CALIBRATION"
    echo "****** example ******"
    echo "./Process_XXXX_AMS_DATA.sh 0007/719 0007/721 0007/756"
    echo "*********************"
    exit 1
fi

#*******AMS*****

INPUT1=$1
INPUT2=$2
INPUT=$3

DIR=${INPUT:0:4}
FILE=${INPUT:5:8}

#Calibration (after conversion)
./AMS_convert DATA/$INPUT1 compressed/AMS_L0_$DIR"_"$FILE.root
./calibration --fast --output calibrations/L0_PS_CAL_$DIR"_"$FILE compressed/AMS_L0_$DIR"_"$FILE.root

#Join run files
./joinAMSfiles.sh $INPUT1 $INPUT2

##Convert joined files
./AMS_convert DATA_joined/AMS_L0_${INPUT1:0:4}"."${INPUT1:5:8}"_"${INPUT2:0:4}"."${INPUT2:5:8} compressed/AMS_L0_${INPUT1:0:4}"."${INPUT1:5:8}"_"${INPUT2:0:4}"."${INPUT2:5:8}".root"

./raw_clusterize --version 2023 --output analysis/AMS_L0_${INPUT1:0:4}"."${INPUT1:5:8}"_"${INPUT2:0:4}"."${INPUT2:5:8}"_withCAL_"$DIR"."$FILE --calibration calibrations/L0_PS_CAL_$DIR"_"$FILE.cal compressed/AMS_L0_${INPUT1:0:4}"."${INPUT1:5:8}"_"${INPUT2:0:4}"."${INPUT2:5:8}".root" --max_histo_ADC 1500


#Output
echo
echo "AMS data have been processed and saved in analysis/AMS_L0_"${INPUT1:0:4}"."${INPUT1:5:8}"_"${INPUT2:0:4}"."${INPUT2:5:8}"_withCAL_"$DIR"."$FILE".root"
echo
