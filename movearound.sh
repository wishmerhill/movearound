#!/bin/bash
# Move around little script

#Set the maximum numeber you like per directory
MAX_FILES_PER_DIR=40
DIR_PREFIX="dir_"

if [ -z $1 ]
  then
    echo "Specify a directory"
    exit 0
fi

if [ ! -d $1 ]
  then
    echo "Argument 1 must be a directory"
    exit 0
fi

WDIR=$1
DIRCOUNT=0
FILESCOUNT=0
DIR=${DIR_PREFIX}$DIRCOUNT
if [ ! -a $WDIR/$DIR ]
  then
    mkdir $WDIR/$DIR
fi
for filename in $WDIR/*; do
  if [ -f $filename ]
    then
      FILESCOUNT=$((FILESCOUNT+1))
      #echo "Moving: " $filename
      #echo "Dircount: " $DIRCOUNT
      #echo "Filecount: " $FILESCOUNT
      #echo "Dir: " $DIR
      mv "$filename" $WDIR/$DIR
      if [ $FILESCOUNT -eq $MAX_FILES_PER_DIR ]
        then
	  DIRCOUNT=$((DIRCOUNT+1))
          FILESCOUNT=0
          DIR=${DIR_PREFIX}$DIRCOUNT
          if [ ! -a $WDIR/$DIR ]
            then
              mkdir $WDIR/$DIR
          fi

      fi
   fi
done;
