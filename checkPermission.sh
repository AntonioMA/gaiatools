#!/bin/bash

# Will get try to get the permissions for "$1"
# Requires sqlite3 installed and on the path, and adb of course
TMP_FILE=/var/tmp/permissions_$$.sqlite
adb pull /data/local/permissions.sqlite $TMP_FILE

sqlite3 $TMP_FILE <<EOF | sed -e 's/|3$/|PROMPT/g' -e 's/|1$/|ALLOW/g' -e 's/|2$/|DENY/g' 
select host, type, permission from moz_hosts where host like '${1}%';
EOF

rm $TMP_FILE

