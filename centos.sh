#!/bin/bash

URL="http://www.centos.org/download/full-mirrorlist.csv"
INFILE=$(mktemp -t mirror-list-centos.XXXXXX)
OUTFILE="list.centos"

wget --no-check-certificate -q -O "${INFILE}" "${URL}"

tail -n+2 "${INFILE}" | awk -F '","' '{print $5}' > ${OUTFILE} 
tail -n+2 "${INFILE}" | awk -F '","' '{print $6}' >> ${OUTFILE}

sed -i'' '/^\s*$/d' ${OUTFILE}
 
rm -f ${INFILE}
