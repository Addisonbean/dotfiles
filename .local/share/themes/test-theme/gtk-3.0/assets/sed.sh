#!/bin/sh
sed -i \
         -e 's/#fffbf0/rgb(0%,0%,0%)/g' \
         -e 's/#333333/rgb(100%,100%,100%)/g' \
    -e 's/#333333/rgb(50%,0%,0%)/g' \
     -e 's/#1982c4/rgb(0%,50%,0%)/g' \
     -e 's/#fffbf0/rgb(50%,0%,50%)/g' \
     -e 's/#fffbf0/rgb(0%,0%,50%)/g' \
	"$@"
