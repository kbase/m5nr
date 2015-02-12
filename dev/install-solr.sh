#!/bin/bash

target=/kb/runtime

if [[ $# -gt 0 ]] ; then
	target=$1
	shift
fi

set -e
set -x

# install solr
export SOLR-VERSION="4.10.3"

wget http://apache.mirrors.hoobly.com/lucene/solr/${SOLR-VERSION}/solr-${SOLR-VERSION}.tgz
tar -xzf solr-${SOLR-VERSION}.tgz -C $target
ln -s $target/solr-${SOLR-VERSION} $target/solr
rm solr-${SOLR-VERSION}.tgz

# init.d file
tpage --define target=$target solr.tt > /etc/init.d/solr
chmod +x /etc/init.d/solr
