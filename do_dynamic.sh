#!/bin/bash

# Update an A record on Ddigital Ocean via their API.
# API documents here:  https://developers.digitalocean.com/documentation/v2
# Will update and tidy the code later

# Your domain name
# IE : example.com
domain_id=""

# Which record to update, you can get a json list by running :
# curl -X GET -H "Content-Type: application/json" -H "Authorization: Bearer replace_with_your_token" "https://api.digitalocean.com/v2/domains/example.com/records" 
# Should return something like this {"id":8193260}
record_id=""

# Your api key
# You can create a key in your DO area, follow the doc links above for more info
api_key=""

# Retrieve your current IP
# The -s makes it quiet and the -4 for IPv4
ip="$(curl -s -4 icanhazip.com)"

# Now push the data to DO
curl -s -X PUT -H "Content-Type: application/json" -H "Authorization: Bearer $api_key" -d "{\"data\":\"$ip\"}" "https://api.digitalocean.com/v2/domains/$domain_id/records/$record_id"
