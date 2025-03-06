#!/bin/bash

cd
cd open5gs-k8s
./remove-all.sh
cd ..
rm -rf open5gs-k8s

cd testbed-automator
sudo ./uninstall.sh
cd ..
rm -rf testbed-automator
