#!/bin/bash

url="$domain$" #change it

temp_file=$(mktemp)

etag=$(curl -s -I $url | grep -i etag | awk '{print $2}' | tr -d '\r')

response=$(curl -s -I $url -H "If-None-Match: $etag" --dump-header $temp_file)

if grep -q "HTTP/1.1 304 Not Modified" "$temp_file"; then
    echo "True"
else
    echo "False"
fi

rm "$temp_file"
