#!/bin/sh

# makes a APP-restricted fresh build (aka replaces just one app and restarts as
# if from a new build
adb shell stop b2g && \
  adb shell "rm -r /data/local/*" && \
  adb shell rm -r /data/b2g/mozilla && \
  APP=$1 PRODUCTION=1 make install-gaia install-default-data &&\
  adb shell start b2g
