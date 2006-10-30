diff -ur libcaca.old/src/bitmap.c libcaca/src/bitmap.c
--- ../libcaca.old/src/bitmap.c	Mon Feb  2 03:00:19 2004
+++ ./src/bitmap.c	Sat Jul 23 15:33:48 2005
@@ -313,7 +313,7 @@
         case 3:
         {
 #if defined(HAVE_ENDIAN_H)
-            if(__BYTE_ORDER == __BIG_ENDIAN)
+            if(BYTE_ORDER == BIG_ENDIAN)
 #else
             /* This is compile-time optimised with at least -O1 or -Os */
             uint32_t const rmask = 0x12345678;
