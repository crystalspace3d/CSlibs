#!/bin/sh

scripts/svn-get libcal3d http://svn.gna.org/svn/cal3d/tags/release-0_11_0/cal3d/
scripts/svn-get libCEGUI https://crayzedsgui.svn.sourceforge.net/svnroot/crayzedsgui/cegui_mk2/branches/v0-5/
# Would be nice to find some JS1.6 CVS tag.
scripts/cvs-get libjs :pserver:anonymous@cvs-mirror.mozilla.org:/cvsroot \
  JSRef -r SPIDERMONKEY_1_6_0_BRANCH

scripts/url-get libpng http://mesh.dl.sourceforge.net/sourceforge/libpng/libpng-1.2.22.tar.bz2 \
  libpng-1.2.22 bz2
scripts/url-get libz http://www.zlib.net/zlib-1.2.3.tar.bz2 \
  zlib-1.2.3 bz2
scripts/url-get libmng http://mesh.dl.sourceforge.net/sourceforge/libmng/libmng-1.0.10.tar.gz \
  libmng-1.0.10 gz
scripts/url-get libogg http://downloads.xiph.org/releases/ogg/libogg-1.1.3.tar.gz \
  libogg-1.1.3 gz
scripts/url-get libvorbis http://downloads.xiph.org/releases/vorbis/libvorbis-1.1.2.tar.gz \
  libvorbis-1.1.2 gz
scripts/url-get libfreetype http://mesh.dl.sourceforge.net/sourceforge/freetype/freetype-2.3.4.tar.bz2 \
  freetype-2.3.4 bz2
scripts/url-get libcaca http://sam.zoy.org/libcaca/libcaca-0.9.tar.bz2 \
  libcaca-0.9 bz2
scripts/url-get libbullet "http://www.continuousphysics.com/ftp/pub/test/index.php?dir=physics/source/&file=bullet-1.9f.zip" \
  bullet-1.9f zip
scripts/url-get libpcre ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-7.1.tar.bz2 \
  pcre-7.1 bz2
scripts/url-get lib3ds http://kent.dl.sourceforge.net/sourceforge/lib3ds/lib3ds-1.3.0.zip \
  lib3ds-1.3.0 zip
scripts/url-get libode "http://downloads.sourceforge.net/opende/ode-src-0.9.zip?use_mirror=surfnet" \
  ode-src-0.9 zip ode-0.9
