#!/bin/sh

# Makes a backup of the user data.

mkdir bck_$$ && \
  cd bck_$$ && \
  adb shell stop b2g && \
  adb pull /data/local ./local >/dev/null 2>&1 && \
  adb pull /data/b2g/mozilla ./mozilla >/dev/null 2>&1 && \
  adb shell start b2g

echo "bck_$$"

