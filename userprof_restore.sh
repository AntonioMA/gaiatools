#!/bin/bash

# Restores a backup of the user data.
# Note: it doesn't restart b2g intentionally
# So you can do a make install-gaia after this (or before)
# If you want to also simulate a first run you can chain this with resetApps.sh
# Although that's only needed if the backup is for the same version than the current gaia

# So a typical execution to replace a Gaia for v1.x with another with v2.0 would be:

# BCK=`./userprof_bck.sh`
# make reset-gaia
# userprof_restore.sh $BCK
# ./resetApps.sh

case $1 in
  "")
    echo "Select the backup that you want to restore"
    select BCK_ORIG in ./bck_[0-9]*;
    do
       break;
    done
    ;;
  *) BCK_ORIG=$1
esac

cd $BCK_ORIG &&\
  adb shell stop b2g &&
  adb shell "rm -r /data/local/*" && \
  adb shell rm -r /data/b2g/mozilla && \
  adb shell mkdir /data/b2g/mozilla && \
  adb push local /data/local && \
  adb push mozilla /data/b2g/mozilla

echo "Backup restored on bck_$$"

