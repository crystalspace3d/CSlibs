#!/bin/sh

# Libs fetched from source code repos
scripts/svn-get libcal3d http://svn.gna.org/svn/cal3d/tags/release-0_11_0/cal3d/
scripts/svn-get libCEGUI https://crayzedsgui.svn.sourceforge.net/svnroot/crayzedsgui/cegui_mk2/tags/v0-6-1/

# pkg-config & dependencies
scripts/url-get glib http://ftp.gnome.org/pub/gnome/sources/glib/2.18/glib-2.18.3.tar.bz2 \
  glib-2.18.3 bz2
scripts/url-get pkg-config http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/pkg-config-0.23.tar.gz \
  pkg-config-0.23 gz

# Base libs
scripts/url-get libpng ftp://ftp.simplesystems.org/pub/libpng/png/src/libpng-1.2.33.tar.bz2 \
  libpng-1.2.33 bz2
scripts/url-get libz http://www.zlib.net/zlib-1.2.3.tar.bz2 \
  zlib-1.2.3 bz2
scripts/url-get libmng http://mesh.dl.sourceforge.net/sourceforge/libmng/libmng-1.0.10.tar.gz \
  libmng-1.0.10 gz
scripts/url-get libogg http://downloads.xiph.org/releases/ogg/libogg-1.1.3.tar.gz \
  libogg-1.1.3 gz
scripts/url-get libspeex http://downloads.xiph.org/releases/speex/speex-1.2rc1.tar.gz \
  speex-1.2rc1 gz
scripts/url-get libvorbis http://downloads.xiph.org/releases/vorbis/libvorbis-1.2.0.tar.gz \
  libvorbis-1.2.0 gz
scripts/url-get libfreetype http://download.savannah.gnu.org/releases/freetype/freetype-2.3.7.tar.bz2 \
  freetype-2.3.7 bz2
scripts/url-get libbullet http://bullet.googlecode.com/files/bullet-2.73-final.zip \
  bullet-2.73 zip
scripts/url-get libpcre ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-7.8.tar.bz2 \
  pcre-7.8 bz2
scripts/url-get lib3ds http://kent.dl.sourceforge.net/sourceforge/lib3ds/lib3ds-1.3.0.zip \
  lib3ds-1.3.0 zip
scripts/url-get libode "http://heanet.dl.sourceforge.net/sourceforge/opende/ode-0.10.1.zip" \
  ode-0.10.1 zip
  
# Extra libs
scripts/url-get libjs ftp://ftp.mozilla.org/pub/mozilla.org/js/js-1.7.0.tar.gz js-1.7.0 gz js
scripts/url-get libwx ftp://ftp.wxwidgets.org/pub/2.8.9/wxMSW-2.8.9.zip wxMSW-2.8.9 zip

# A bit of manual setup
mkdir -p libwx/lib/vc_dll/mswu/wx/
mkdir -p libwx/lib/vc_dll/mswud/wx/
mkdir -p libwx/lib/vc_lib/mswu/wx/
mkdir -p libwx/lib/vc_lib/mswud/wx/
cp libwx/include/wx/msw/setup.h libwx/lib/vc_dll/mswu/wx
cp libwx/include/wx/msw/setup.h libwx/lib/vc_dll/mswud/wx
cp libwx/include/wx/msw/setup.h libwx/lib/vc_lib/mswu/wx
cp libwx/include/wx/msw/setup.h libwx/lib/vc_lib/mswud/wx
