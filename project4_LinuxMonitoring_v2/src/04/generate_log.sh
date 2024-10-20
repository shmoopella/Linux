#!/bin/bash

date=$(date +"%d%b%Y")
record_count=$(( $RANDOM % 1000 + 100 ))
count_logfile=5

for (( num_logfile = 1; num_logfile <= $count_logfile; num_logfile++ ))
do
    for (( i = 0; i < $record_count; i++ ))
    do
            
           echo -n "$(shuf -n 1 -i 0-255).$(shuf -n 1 -i 0-255).$(shuf -n 1 -i 0-255).$(shuf -n 1 -i 0-255) " >> $num_logfile.log  #generate IP address
           echo -n "- - [$(date -d $date +"%d/%b/%Y:")$(shuf -i 0-23 -n 1):$(shuf -i 0-59 -n 1):$(shuf -i 0-59 -n 1) +0000] " >> $num_logfile.log   #generate date and time of the request 
           echo -n "\"$(shuf -n 1 HTTP_methods) $(shuf -n 1 PathToResource) HTTP/1.0\" " >> $num_logfile.log  #generate request line from the client
           echo -n "$(shuf -n 1 HTTP_code) " >> $num_logfile.log     #generate HTTP status code returned to the client
           echo -n "$(shuf -n 1 -i 3-3000) "  >> $num_logfile.log    #generate size of the response sent to the client
           echo -n "$(shuf -n 1 URL) "  >> $num_logfile.log          #generate referrer URL
           echo "\"$(shuf -n 1 agent)\" "  >> $num_logfile.log    #generate user agent string
    done
    date=$(date -d "$date - 1 day" +"%d%b%Y")

done


# 200 OK: The request was successful and the response contains the requested information.
# 201 Created: The request was successful and a new resource has been created as a result.
# 400 Bad Request: The server was unable to understand the request due to invalid syntax or a missing parameter.
# 401 Unauthorized: The request requires authentication, but the user has not provided valid credentials.
# 403 Forbidden: The server understood the request, but refuses to authorize it. This usually means that the user does not have sufficient permissions to access the resource.
# 404 Not Found: The server was unable to find the requested resource.
# 500 Internal Server Error: An unexpected error occurred on the server while processing the request.
# 501 Not Implemented: The server does not support the requested feature or functionality.
# 502 Bad Gateway: The server acting as a gateway or proxy received an invalid response from the upstream server.
# 503 Service Unavailable: The server is currently unable to handle the request due to temporary overload or maintenance.