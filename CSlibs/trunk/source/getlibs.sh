#!/bin/sh

# Libs fetched from source code repos
scripts/svn-get libcal3d http://svn.gna.org/svn/cal3d/tags/release-0_11_0/cal3d/
scripts/svn-get libCEGUI https://crayzedsgui.svn.sourceforge.net/svnroot/crayzedsgui/cegui_mk2/tags/v0-7-1/

# pkg-config & dependencies
scripts/url-get glib http://ftp.gnome.org/pub/gnome/sources/glib/2.18/glib-2.18.3.tar.bz2 \
  glib-2.18.3 bz2
scripts/url-get pkg-config http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/pkg-config-0.23.tar.gz \
  pkg-config-0.23 gz

# Base libs
scripts/url-get libpng ftp://ftp.simplesystems.org/pub/libpng/png/src/libpng-1.2.40.tar.xz \
  libpng-1.2.40 xz
scripts/url-get libz http://www.zlib.net/zlib-1.2.3.tar.bz2 \
  zlib-1.2.3 bz2
scripts/url-get libmng http://mesh.dl.sourceforge.net/sourceforge/libmng/libmng-1.0.10.tar.gz \
  libmng-1.0.10 gz
scripts/url-get libogg http://downloads.xiph.org/releases/ogg/libogg-1.1.4.tar.gz \
  libogg-1.1.4 gz
scripts/url-get libspeex http://downloads.xiph.org/releases/speex/speex-1.2rc1.tar.gz \
  speex-1.2rc1 gz
scripts/url-get libvorbis http://downloads.xiph.org/releases/vorbis/libvorbis-1.2.3.tar.gz \
  libvorbis-1.2.3 gz
scripts/url-get libfreetype http://download.savannah.gnu.org/releases/freetype/freetype-2.3.11.tar.bz2 \
  freetype-2.3.11 bz2
scripts/url-get libbullet http://bullet.googlecode.com/files/bullet-2.75.tgz \
  bullet-2.75 gz
scripts/url-get libpcre ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.00.tar.bz2 \
  pcre-8.00 bz2
scripts/url-get lib3ds http://kent.dl.sourceforge.net/sourceforge/lib3ds/lib3ds-1.3.0.zip \
  lib3ds-1.3.0 zip
scripts/url-get libode "http://downloads.sourceforge.net/project/opende/ODE/0.11.1/ode-0.11.1.zip?use_mirror=dfn" \
  ode-0.11.1 zip
  
# Extra libs
scripts/url-get libwx ftp://ftp.wxwidgets.org/pub/2.8.10/wxMSW-2.8.10.zip wxMSW-2.8.10 zip

# A bit of manual setup
mkdir -p libwx/lib/vc_dll/mswu/wx/
mkdir -p libwx/lib/vc_dll/mswud/wx/
mkdir -p libwx/lib/vc_lib/mswu/wx/
mkdir -p libwx/lib/vc_lib/mswud/wx/
cp libwx/include/wx/msw/setup.h libwx/lib/vc_dll/mswu/wx
cp libwx/include/wx/msw/setup.h libwx/lib/vc_dll/mswud/wx
cp libwx/include/wx/msw/setup.h libwx/lib/vc_lib/mswu/wx
cp libwx/include/wx/msw/setup.h libwx/lib/vc_lib/mswud/wx
