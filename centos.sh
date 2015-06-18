#!/bin/bash

URL="http://www.centos.org/download/full-mirrorlist.csv"
INFILE=$(mktemp -t mirror-list-centos.XXXXXX)

wget --no-check-certificate -q -O "${INFILE}" "${URL}"
cat ${INFILE} | awk -F '","' '{print $5,$6,$7}' | sed -e 's/"//g' -e 's/ /\n/g' | sort -u | grep -v "^$"
rm -f ${INFILE}
