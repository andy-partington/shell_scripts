#!/bin/bash

# Update an A record on Digital Ocean via their API.
# API documents here:  https://developers.digitalocean.com/documentation/v2

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

# Get your current A record for the record_id to compare against your current IP
# This is dependant on a program called jq ( apt install jq ) may do this differently in the future.
currentip="$(curl -s -X GET -H "Content-Type: application/json" -H "Authorization: Bearer $api_key" "https://api.digitalocean.com/v2/domains/$domain_id/records/$record_id" | jq -r ".domain_record"  | jq -r ".data")"

# Retrieve your current IP
# The -s makes it quiet and the -4 for IPv4 
# I want to add different ways of grabbing IP's so will implement  dig +short myip.opendns.com @resolver1.opendns.com as initial option and icanhaz as secondary. 
ip="$(curl -s -4 icanhazip.com)"

if [ "$currentip" != "$ip" ] ; then 
    echo "IP Address differs from the A record, updating A record"
    curl -s -X PUT -H "Content-Type: application/json" -H "Authorization: Bearer $api_key" -d "{\"data\":\"$ip\"}" "https://api.digitalocean.com/v2/domains/$domain_id/records/$record_id"
    exit_status = $?
	if [ $exit_status != 0 ]
	  then
	    exit $exit_status
	else
    	echo "IP Address updated successfully"
	fi
else
    echo "IP Address not changed"
fi