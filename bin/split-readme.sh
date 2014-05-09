#!/bin/sh
# Pattern from (and explained): http://austinmatzko.com/2008/04/26/sed-multi-line-search-and-replace/
cat $1 | sed -n '1h;1!H;${;g;s/@BEGIN_STATICONLY@.*@END_STATICONLY@/\\par }\\pard {/g;p;}' > $2/Readme-shared.rtf
cat $1 | sed -e 's/@BEGIN_STATICONLY@//' -e 's/@END_STATICONLY@//' > $2/Readme-static.rtf
