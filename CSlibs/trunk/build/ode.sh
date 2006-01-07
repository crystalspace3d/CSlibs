#!/bin/sh

platform=$1

cp -r source/libode temp/${platform}/
chmod -R a+w temp/${platform}/libode
cp build/ode-user-settings temp/${platform}/libode/config/user-settings
chmod -R a+w temp/${platform}/libode/config/user-settings
echo "PLATFORM=${platform}" >> temp/${platform}/libode/config/user-settings
cd temp/${platform}/libode
make configure
make ode-lib
mkdir -p ../prefix/lib/
cp lib/libode.a ../prefix/lib/
cd ../../..
