#!/bin/bash
#bsondump --quiet $1 | jq -s -r '.[] | select(.type | ."$numberInt" == "1")'
linez=$(bsondump --quiet /Users/nitin.katkam/Documents/landd/mdb/mdb01/diagnostic.data/metrics.2022-10-16T11-32-51Z-00000 | jq -s -c -r '.[] | select(.type | ."$numberInt" == "1")')
for iterline in $linez
do
# echo " --- START LINE --- "
# epochMicros=$(echo "$iterline" | jq -r '."_id"."$date"."$numberLong"')
# epochSecs=$(( $epochMicros / 1000 ))
# humanTimestamp=$(date -r $epochSecs)
# echo "TS: $humanTimestamp"  # MetricsChunk has this in .start
 echo "$iterline" | jq -r -c -M '.data."$binary".base64' | ruby -rzlib -rbase64 -e 'd=STDIN.read; print Zlib::Inflate.new.inflate(Base64.decode64(d)[4..-1])' | bsondump --quiet | jq -C '.'
# echo " --- END LINE --- "
done

# For color output, use:  jq -C ... | less -R  
