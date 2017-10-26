#!/bin/bash
curl https://apis.opendatani.gov.uk/translink/$1.xml > status.xml

newdir=$(date +"%m%d%y%H%M00")
mkdir -p stations/$newdir

cp status.xml stations/$newdir/$1

xml2json/xml2json.py -t xml2json status.xml

