#!/bin/sh

# Libs fetched from source code repos
scripts/svn-get libcal3d http://svn.gna.org/svn/cal3d/tags/release-0_11_0/cal3d/
scripts/svn-get libCEGUI https://crayzedsgui.svn.sourceforge.net/svnroot/crayzedsgui/cegui_mk2/tags/v0-6-0/

# Base libs
scripts/url-get libpng http://mesh.dl.sourceforge.net/sourceforge/libpng/libpng-1.2.29.tar.bz2 \
  libpng-1.2.29 bz2
scripts/url-get libz http://www.zlib.net/zlib-1.2.3.tar.bz2 \
  zlib-1.2.3 bz2
scripts/url-get libmng http://mesh.dl.sourceforge.net/sourceforge/libmng/libmng-1.0.10.tar.gz \
  libmng-1.0.10 gz
scripts/url-get libogg http://downloads.xiph.org/releases/ogg/libogg-1.1.3.tar.gz \
  libogg-1.1.3 gz
scripts/url-get libvorbis http://downloads.xiph.org/releases/vorbis/libvorbis-1.2.0.tar.gz \
  libvorbis-1.2.0 gz
scripts/url-get libfreetype http://mesh.dl.sourceforge.net/sourceforge/freetype/freetype-2.3.5.tar.bz2 \
  freetype-2.3.5 bz2
scripts/url-get libbullet http://bullet.googlecode.com/files/bullet-2.69.zip \
  bullet-2.69 zip
scripts/url-get libpcre ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-7.7.tar.bz2 \
  pcre-7.7 bz2
scripts/url-get lib3ds http://kent.dl.sourceforge.net/sourceforge/lib3ds/lib3ds-1.3.0.zip \
  lib3ds-1.3.0 zip
scripts/url-get libode "http://downloads.sourceforge.net/opende/ode-src-0.9.zip?use_mirror=surfnet" \
  ode-src-0.9 zip ode-0.9
  
# Extra libs
scripts/url-get libjs ftp://ftp.mozilla.org/pub/mozilla.org/js/js-1.7.0.tar.gz js-1.7.0 gz js
scripts/url-get libwx http://surfnet.dl.sourceforge.net/sourceforge/wxwindows/wxMSW-2.8.7.zip wxMSW-2.8.7 zip

# A bit of manual setup
mkdir -p libwx/lib/vc_lib/mswu/wx/
cp libwx/include/wx/msw/setup.h libwx/lib/vc_lib/mswu/wx
mkdir -p libwx/lib/vc_lib/mswud/wx/
cp libwx/include/wx/msw/setup.h libwx/lib/vc_lib/mswud/wx
