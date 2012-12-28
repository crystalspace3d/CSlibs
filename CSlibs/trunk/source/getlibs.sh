#!/bin/sh

# Libs fetched from source code repos
scripts/svn-get libcal3d http://svn.gna.org/svn/cal3d/trunk/cal3d/ -r 507
scripts/hg-get libCEGUI http://crayzedsgui.hg.sourceforge.net:8000/hgroot/crayzedsgui/cegui_mk2 v0-7-7

# pkg-config & dependencies
scripts/url-get glib http://ftp.gnome.org/pub/gnome/sources/glib/2.18/glib-2.18.3.tar.bz2 \
  glib-2.18.3 bz2
scripts/url-get pkg-config http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/pkg-config-0.23.tar.gz \
  pkg-config-0.23 gz

# Base libs
scripts/url-get libpng ftp://ftp.simplesystems.org/pub/libpng/png/src/libpng-1.5.13.tar.xz \
  libpng-1.5.13 xz
scripts/url-get libz http://zlib.net/zlib-1.2.7.tar.bz2 \
  zlib-1.2.7 bz2
scripts/url-get libjpeg http://ijg.org/files/jpegsrc.v8d.tar.gz \
  jpeg-8d gz
scripts/url-get libmng "http://downloads.sourceforge.net/project/libmng/libmng-devel/1.0.10/libmng-1.0.10.tar.bz2?r=&ts=1356288132&use_mirror=netcologne" \
  libmng-1.0.10 bz2
scripts/url-get libogg http://downloads.xiph.org/releases/ogg/libogg-1.3.0.tar.gz \
  libogg-1.3.0 gz
scripts/url-get libspeex http://downloads.xiph.org/releases/speex/speex-1.2rc1.tar.gz \
  speex-1.2rc1 gz
scripts/url-get libvorbis http://downloads.xiph.org/releases/vorbis/libvorbis-1.3.3.tar.xz \
  libvorbis-1.3.3 xz
scripts/url-get libfreetype http://download.savannah.gnu.org/releases/freetype/freetype-2.4.11.tar.bz2 \
  freetype-2.4.11 bz2
scripts/url-get libbullet http://bullet.googlecode.com/files/bullet-2.81-rev2613.tgz \
  bullet-2.81-rev2613 gz
scripts/url-get libpcre ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.32.tar.bz2 \
  pcre-8.32 bz2
scripts/url-get lib3ds http://lib3ds.googlecode.com/files/lib3ds-1.3.0.zip \
  lib3ds-1.3.0 zip
scripts/url-get libode "http://downloads.sourceforge.net/project/opende/ODE/0.11.1/ode-0.11.1.zip?use_mirror=dfn" \
  ode-0.11.1 zip
scripts/url-get openal-soft http://kcat.strangesoft.net/openal-releases/openal-soft-1.13.tar.bz2 \
  openal-soft-1.13 bz2
  
# Extra libs
scripts/url-get libwx ftp://ftp.wxwidgets.org/pub/2.9.4/wxWidgets-2.9.4.tar.bz2 wxWidgets-2.9.4 bz2

# A bit of manual setup
mkdir -p libwx/lib/vc_dll/mswu/wx/
mkdir -p libwx/lib/vc_dll/mswud/wx/
mkdir -p libwx/lib/vc_lib/mswu/wx/
mkdir -p libwx/lib/vc_lib/mswud/wx/
copy_if_differerent() {
  if ! diff "$1" "$2" > /dev/null ; then cp -v "$1" "$2" ; fi
}
copy_if_differerent libwx/include/wx/msw/setup.h libwx/lib/vc_dll/mswu/wx/setup.h
copy_if_differerent libwx/include/wx/msw/setup.h libwx/lib/vc_dll/mswud/wx/setup.h
copy_if_differerent libwx/include/wx/msw/setup.h libwx/lib/vc_lib/mswu/wx/setup.h
copy_if_differerent libwx/include/wx/msw/setup.h libwx/lib/vc_lib/mswud/wx/setup.h
