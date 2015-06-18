#!/bin/bash

URL="https://www.debian.org/mirror/mirrors_full"
INFILE=$(mktemp -t mirror-list-debian.XXXXXX)
PROTOCOLS="HTTP FTP"

get_mirrors() {
	SEARCH=$1
	FILE=$2

	grep "${SEARCH}" ${INFILE} | grep -o '<a .*href=.*>' | sed -e 's/<a .* href=\([^>]*\).*/\1/' -e "s/\"//g" >> ${FILE}
}

create_mirror_list() {
	TYPE=$1
	FILE=$2

	[ -f ${FILE} ] && rm -f ${FILE}

	for PROTO in ${PROTOCOLS}; do
		get_mirrors "${TYPE} ${PROTO}" ${FILE}
	done
}

wget --no-check-certificate -q -O "${INFILE}" "${URL}"
create_mirror_list "Packages over" list.ng.debian
create_mirror_list "Security updates over" list.debian-security
create_mirror_list "backports-over" list.debian-backports
create_mirror_list "Volatile packages over" list.debian-volatile
create_mirror_list "Old releases over" list.debian-archive

rm -f ${INFILE}
