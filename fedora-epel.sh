#!/bin/bash

# assume that the EPEL mirror for all archs are the same
# assume that mirrors for EPEL6 and EPEL7 are the same

URL_BASE="http://mirrors.fedoraproject.org"
INFILE=$(mktemp -t mirror-list-fedora-epel.XXXXXX)

ARCH="i386 x86_64 ppc ppc64"
REPO="epel-5 epel-6 epel-7"

for R in ${REPO}; do
	for A in ${ARCH}; do
		wget --no-check-certificate -q -O - "${URL_BASE}/metalink?repo=${R}&arch=${A}" >> ${INFILE}
	done
done

grep "<url" ${INFILE} | sed -e "s/^.*>\(.*\)<.*>/\1/" | rev | cut -d "/" -f 5- | rev | sort -u > list.fedora-epel
rm -f ${INFILE}
