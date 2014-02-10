#!/bin/sh

ROOT_DIR_DB=/data/b2g/mozilla
CERT=cert9.db
KEY=key4.db
PKCS11=pkcs11.txt
DB_DIR=`adb shell "ls -d ${ROOT_DIR_DB}/*.default 2>/dev/null" | sed "s/default.*$/default/g"`
CPREF=custom-prefs.js

if [ "${DB_DIR}" = "" ]; then
  echo "Profile directory does not exists. Please start the b2g proccess at least once before running this script."
  exit 1
fi

#Sobreescrir ficheros con certs
adb shell stop b2g

echo "copying ${CERT}: adb push ./${CERT} ${DB_DIR}/${CERT}"
adb push ./${CERT} ${DB_DIR}/${CERT}
echo "copying ${KEY}: adb push ./${KEY} ${DB_DIR}/${KEY}"
adb push ./${KEY} ${DB_DIR}/${KEY}
echo "copying ${PKCS11}: adb push ./${PKCS11} ${DB_DIR}/${PKCS11}"
adb push ./${PKCS11} ${DB_DIR}/${PKCS11}

# Hey this is Unix! I can check if I already did this!
if adb shell cat /system/b2g/defaults/pref/user.js | grep "dom.mozApps.signed_apps_installable_from" > /dev/null
then
  echo "Store preferences are already in user.js file. Skipping!"
else 
  echo "Store preferences not found in user.js file. Adding them"
  adb remount
  adb push ./$CPREF /system/b2g/defaults/pref/$CPREF
  adb shell "cat /system/b2g/defaults/pref/user.js /system/b2g/defaults/pref/$CPREF > /system/b2g/defaults/pref/user2.js"
  adb shell mv /system/b2g/defaults/pref/user2.js /system/b2g/defaults/pref/user.js
  adb shell rm /system/b2g/defaults/pref/$CPREF
fi

adb shell start b2g

echo "Finished." 
