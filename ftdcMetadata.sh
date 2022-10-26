#!/bin/bash
bsondump --quiet $1 | jq -s '.[] | select(.type | ."$numberInt" == "0")' | less
