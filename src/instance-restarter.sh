#!/bin/sh

set -e

API_URL=${API_URL:-https://convox.site/instances}
API_KEY=${API_KEY:-somepassword}
INSTANCE_AGE_DAYS=${INSTANCE_AGE_DAYS:-3}

TO_TERMINATE=`curl -k -X GET -s --header 'Content-Type: application/x-www-form-urlencoded' --header 'Accept: text/plain' --header "Authorization: Basic ${API_KEY}" ${API_URL} | INSTANCE_AGE_DAYS="$INSTANCE_AGE_DAYS" jq 'def daysAgo(days): (now | floor) - (days * 86400); map(select(.status == "active")) | sort_by(.started | fromdateiso8601?) | map(select(.started | fromdateiso8601? < daysAgo(env.INSTANCE_AGE_DAYS | tonumber))) | limit(1;.[]) | .id' | sed -e 's/^"//' -e 's/"$//'`

if [ "$TO_TERMINATE" ]
then
  echo "Instance to terminate: ${TO_TERMINATE}"
  curl -k -X DELETE -s -o /dev/null --header 'Content-Type: application/x-www-form-urlencoded' --header 'Accept: text/plain' --header "Authorization: Basic ${API_KEY}" "${API_URL}/${TO_TERMINATE}"
else
  echo "No instance to be terminated"
fi
