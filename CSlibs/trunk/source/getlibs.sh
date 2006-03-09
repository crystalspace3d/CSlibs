#!/bin/sh

scripts/cvs-get libcal3d :pserver:anonymous@cvs.sourceforge.net:/cvsroot/cal3d \
  cal3d
scripts/cvs-get libode :pserver:anonymous@cvs.sourceforge.net:/cvsroot/opende \
  ode
scripts/cvs-get lib3ds :pserver:anonymous@cvs.sourceforge.net:/cvsroot/lib3ds \
  lib3ds
scripts/cvs-get libCEGUI :pserver:anonymous@cvs.sourceforge.net:/cvsroot/crayzedsgui \
  cegui_mk2 -r v0-4
# Would be nice to find some JS1.6 CVS tag.
scripts/cvs-get libjs :pserver:anonymous@cvs-mirror.mozilla.org:/cvsroot \
  JSRef -r HEAD

scripts/url-get libpng ftp://ftp.simplesystems.org/pub/libpng/png/src/libpng-1.2.8-config.tar.gz \
  libpng-1.2.8-config gz
scripts/url-get libz http://www.zlib.net/zlib-1.2.3.tar.bz2 \
  zlib-1.2.3 bz2
scripts/url-get libmng http://mesh.dl.sourceforge.net/sourceforge/libmng/libmng-1.0.9.tar.gz \
  libmng-1.0.9 gz
scripts/url-get libogg http://downloads.xiph.org/releases/ogg/libogg-1.1.3.tar.gz \
  libogg-1.1.3 gz
scripts/url-get libvorbis http://downloads.xiph.org/releases/vorbis/libvorbis-1.1.2.tar.gz \
  libvorbis-1.1.2 gz
scripts/url-get libmikmod http://mikmod.raphnet.net/files/libmikmod-3.1.11.tar.gz \
  libmikmod-3.1.11 gz
scripts/url-get libfreetype http://mesh.dl.sourceforge.net/sourceforge/freetype/freetype-2.1.10.tar.bz2 \
  freetype-2.1.10 bz2
scripts/url-get libcaca http://sam.zoy.org/libcaca/libcaca-0.9.tar.bz2 \
  libcaca-0.9 bz2
scripts/url-get libbullet http://www.minet.uni-jena.de/~res/bullet-20060223.tar.bz2 \
  bullet-20060223 bz2
