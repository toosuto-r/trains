#!/bin/bash
stations=$(cat stationcodes)

for code in $stations
do
 curl https://apis.opendatani.gov.uk/translink/$code.xml > stations/$code
done

