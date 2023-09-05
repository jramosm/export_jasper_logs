#!/usr/bin/env bash

##  Bring variable file, rename "env_example" and change the varibles.
source $(dirname $0)/env

## If the directory where will put the zip to download is not exist, then create it.
test -d $jasperLogs4DownloadDirectory || mkdir $jasperLogs4DownloadDirectory


cd $jasperLogs4DownloadDirectory && \
(
  ## Zip the files modified in last 2 days.
  zip jasper_logs-$currentDate.zip $(find $jasperDirectory/apache-tomcat/logs -mtime -2) 
  echo ' '
  echo 'Download ZIP from http://$webInterface:$webPort'
  echo ' '

  #### For python3 uncomment next line
  # python3 -m http.server --bind $webInterface $webPort
  
  #### For python2 uncomment next line
  python -c 'import BaseHTTPServer as bhs, SimpleHTTPServer as shs; bhs.HTTPServer(("10.9.1.1", 8099), shs.SimpleHTTPRequestHandler).serve_forever()'
)
