#! /bin/bash

for i in workflow*.xml; do
    sed -i 's/host=".*" port=".*"/host="'$1'" port="'$2'" type="tcp"/' $i
    tsung -f $i start
done


