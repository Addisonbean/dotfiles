#!/bin/sh
sed -i \
         -e 's/rgb(0%,0%,0%)/#fffbf0/g' \
         -e 's/rgb(100%,100%,100%)/#333333/g' \
    -e 's/rgb(50%,0%,0%)/#333333/g' \
     -e 's/rgb(0%,50%,0%)/#1982c4/g' \
 -e 's/rgb(0%,50.196078%,0%)/#1982c4/g' \
     -e 's/rgb(50%,0%,50%)/#fffbf0/g' \
 -e 's/rgb(50.196078%,0%,50.196078%)/#fffbf0/g' \
     -e 's/rgb(0%,0%,50%)/#fffbf0/g' \
	"$@"
