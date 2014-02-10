#!/bin/bash

for i in addedcerts/*
do
  echo "Adding $i"
  certutil -d sql:. -A -n "$i" -t "C,C,TC" -i $i
done