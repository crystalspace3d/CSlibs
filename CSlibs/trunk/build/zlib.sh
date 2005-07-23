#!/bin/sh

platform=$1

cp -R source/libz temp/${platform}/
chmod -R a+w temp/${platform}/libz
cd temp/${platform}/libz
prefix=$(pwd)/../prefix ./configure
make
make install
