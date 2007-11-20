#!/bin/sh

platform=$1

build/lib.sh ${platform} libode "install" --enable-release
