#!/bin/sh
# Pattern from (and explained): http://austinmatzko.com/2008/04/26/sed-multi-line-search-and-replace/
cat Readme.rtf | sed -n '1h;1!H;${;g;s/@BEGIN_STATICONLY@.*@END_STATICONLY@/\\par }\\pard {/g;p;}' > Readme-standard.rtf
cat Readme.rtf | sed -e 's/@BEGIN_STATICONLY@//' -e 's/@END_STATICONLY@//' > Readme-static.rtf
