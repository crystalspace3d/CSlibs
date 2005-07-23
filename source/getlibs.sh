#!/bin/sh

scripts/cvs-get libcal3d :pserver:anonymous@cvs.sourceforge.net:/cvsroot/cal3d \
  cal3d HEAD
scripts/cvs-get libode :pserver:anonymous@cvs.sourceforge.net:/cvsroot/opende \
  ode ode-05
scripts/cvs-get lib3ds :pserver:anonymous@cvs.sourceforge.net:/cvsroot/lib3ds \
  lib3ds HEAD

scripts/url-get libpng ftp://ftp.simplesystems.org/pub/libpng/png/src/libpng-1.2.8-config.tar.gz \
  libpng-1.2.8-config gz
scripts/url-get libz http://www.zlib.net/zlib-1.2.3.tar.bz2 \
  zlib-1.2.3 bz2
scripts/url-get libmng http://mesh.dl.sourceforge.net/sourceforge/libmng/libmng-1.0.9.tar.gz \
  libmng-1.0.9 gz
scripts/url-get libogg http://downloads.xiph.org/releases/ogg/libogg-1.1.2.tar.gz \
  libogg-1.1.2 gz
scripts/url-get libvorbis http://downloads.xiph.org/releases/vorbis/libvorbis-1.1.0.tar.gz \
  libvorbis-1.1.0 gz
scripts/url-get libmikmod http://mikmod.raphnet.net/files/libmikmod-3.1.11.tar.gz \
  libmikmod-3.1.11 gz
scripts/url-get libfreetype ftp://gd.tuwien.ac.at/publishing/freetype/freetype2/freetype-2.1.9.tar.bz2 \
  freetype-2.1.9 bz2
scripts/url-get libcaca http://sam.zoy.org/libcaca/libcaca-0.9.tar.bz2 \
  libcaca-0.9 bz2
