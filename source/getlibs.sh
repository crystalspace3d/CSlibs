#!/bin/sh

scripts/svn-get libcal3d http://svn.gna.org/svn/cal3d/tags/release-0_11_0/cal3d/
scripts/svn-get libode https://svn.sourceforge.net/svnroot/opende/branches/0.6/
scripts/cvs-get lib3ds :pserver:anonymous@lib3ds.cvs.sourceforge.net:/cvsroot/lib3ds \
  lib3ds
scripts/svn-get libCEGUI https://svn.sourceforge.net/svnroot/crayzedsgui/cegui_mk2/tags/v0-5-0-RC1/
# Would be nice to find some JS1.6 CVS tag.
scripts/cvs-get libjs :pserver:anonymous@cvs-mirror.mozilla.org:/cvsroot \
  JSRef -r HEAD

scripts/url-get libpng ftp://ftp.simplesystems.org/pub/libpng/png/src/libpng-1.2.12.tar.bz2 \
  libpng-1.2.12 bz2
scripts/url-get libz http://www.zlib.net/zlib-1.2.3.tar.bz2 \
  zlib-1.2.3 bz2
scripts/url-get libmng http://mesh.dl.sourceforge.net/sourceforge/libmng/libmng-1.0.9.tar.gz \
  libmng-1.0.9 gz
scripts/url-get libogg http://downloads.xiph.org/releases/ogg/libogg-1.1.3.tar.gz \
  libogg-1.1.3 gz
scripts/url-get libvorbis http://downloads.xiph.org/releases/vorbis/libvorbis-1.1.2.tar.gz \
  libvorbis-1.1.2 gz
scripts/url-get libfreetype http://mesh.dl.sourceforge.net/sourceforge/freetype/freetype-2.2.1.tar.bz2 \
  freetype-2.2.1 bz2
scripts/url-get libcaca http://sam.zoy.org/libcaca/libcaca-0.9.tar.bz2 \
  libcaca-0.9 bz2
scripts/url-get libbullet "http://www.continuousphysics.com/ftp/pub/test/index.php?dir=physics/source/&file=bullet-1.6a-source.zip" \
  bullet-1.6a zip bullet
