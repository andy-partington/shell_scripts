#!/bin/bash

# Update an A record on Ddigital Ocean via their API.
# API documents here:  https://developers.digitalocean.com/documentation/v2
# Will update and tidy the code later

# Load config file with api/domain etc

source .do_creds

# Your domain name
# IE : example.com
domain_id=$DOMAIN_ID

# Which record to update, you can get a json list by running :
# curl -X GET -H "Content-Type: application/json" -H "Authorization: Bearer replace_with_your_token" "https://api.digitalocean.com/v2/domains/example.com/records" 
# Should return something like this {"id":8193260}
record_id=$RECORD_ID

# Your api key
# You can create a key in your DO area, follow the doc links above for more info
api_key=$API_KEY

# Get your current A record for the record IP to compare against your current IP
# This is dependant on a program called jq ( apt install jq )
#currentip="$(curl -s -X GET -H "Content-Type: application/json" -H "Authorization: Bearer $api_key" "https://api.digitalocean.com/v2/domains/$domain_id/records/$record_id" | jq -r ".domain_record"  | jq -r ".data")"
currentip="82.69.12.215"
echo $currentip

# Retrieve your current IP
# The -s makes it quiet and the -4 for IPv4
ip="$(curl -s -4 icanhazip.com)"

echo $ip

if [ "$currentip" != "$ip" ] ; then 
    echo "IP has changed"
else
    echo "Still the same..."
fi
# Now push the data to DO
#curl -s -X PUT -H "Content-Type: application/json" -H "Authorization: Bearer $api_key" -d "{\"data\":\"$ip\"}" "https://api.digitalocean.com/v2/domains/$domain_id/records/$record_id"
