#!/bin/bash

URL="http://mirrors.ubuntu.com/"
INFILE=$(mktemp -t mirror-list-ubuntu.XXXXXX)
OUTFILE1=$(mktemp -t mirror-list-ubuntu.XXXXXX)
OUTFILE2=$(mktemp -t mirror-list-ubuntu.XXXXXX)

wget --no-check-certificate -q -O "${INFILE}" "${URL}"
for F in `grep -o '<a .*href=.*>' ${INFILE} | sed -e's/<a .*href=\([^>]*\).*/\1/' -e's/"//g' | grep ".txt"`; do
	wget --no-check-certificate -q -O ${OUTFILE1} ${URL}/${F}
	cat ${OUTFILE1} >> ${OUTFILE2}
done

cat ${OUTFILE2} | sort -u > list.ubuntu

rm -f ${INFILE}
rm -f ${OUTFILE1}
rm -f ${OUTFILE2}
