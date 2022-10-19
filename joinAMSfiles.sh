#!/bin/bash

MOTHERDIR="./DATA"
#SUBDIR="/0004"


INPUT1=$1
INPUT2=$2

SUBDIR_FIRST=${INPUT1:0:4}
SUBDIR_LAST=${INPUT2:0:4}

#FIRST=864
#LAST=923
FIRST=${INPUT1:5:8}
LAST=${INPUT2:5:8}

outfile="${MOTHERDIR}_joined/AMS_L0_$SUBDIR_FIRST.${FIRST}_$SUBDIR_LAST.${LAST}"
echo $outfile
rm -f $outfile
touch $outfile

DIR_FIRST=$((10#$SUBDIR_FIRST))
DIR_LAST=$((10#$SUBDIR_LAST))


if [ $SUBDIR_FIRST -eq $SUBDIR_LAST ]; then
   for i in `seq $FIRST $LAST`
   do
       ls -lh $MOTHERDIR/$SUBDIR_FIRST/$(printf %03d $i)
       cat $MOTHERDIR/$SUBDIR_FIRST/$(printf %03d $i) >> $outfile
   done
else
    for i in `seq $FIRST 999`
    do
	ls -lh $MOTHERDIR/$SUBDIR_FIRST/$(printf %03d $i)
	cat $MOTHERDIR/$SUBDIR_FIRST/$(printf %03d $i) >> $outfile
    done

    while [ $(($DIR_FIRST)) -lt $(($DIR_LAST)) ]
    do
	DIR_FIRST=$(($DIR_FIRST+1))
	if [  $(($DIR_FIRST)) -eq $(($DIR_LAST)) ]; then
	    for i in `seq 000 $LAST`
	    do
		ls -lh $MOTHERDIR/$SUBDIR_LAST/$(printf %03d $i)
		cat $MOTHERDIR/$SUBDIR_LAST/$(printf %03d $i) >> $outfile
	    done
	else
	    for i in `seq 000 999`
	    do
		ls -lh $MOTHERDIR/$(printf %04d $(($DIR_FIRST)))/$(printf %03d $i)
		cat $MOTHERDIR/$(printf %04d $(($DIR_FIRST)))/$(printf %03d $i) >> $outfile
	    done     
	fi
    done
fi
   
