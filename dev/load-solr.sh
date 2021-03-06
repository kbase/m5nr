#!/bin/bash

set -e
set -x

SOLR_DIR=$1
SOLR_PORT=$2
M5NR_VER=$3
M5NR_NAME=$4
FILES=(source ontology taxonomy annotation)
DATA_FTP=ftp://ftp.metagenomics.anl.gov/data/M5nr/solr/v${M5NR_VER}
DATA_SIZE=500000

# load as we download
cp chunk_post.pl $SOLR_DIR/example/exampledocs
cd $SOLR_DIR/example/exampledocs
for F in ${FILES[@]}; do
    FILE=m5nr_v${M5NR_VER}.${F}.gz
    echo "loading data from $FILE"
    wget -q -O - $DATA_FTP/$FILE | zcat | ./chunk_post.pl $DATA_SIZE ${M5NR_NAME}_${M5NR_VER} $SOLR_PORT
done
echo "done loading data"
