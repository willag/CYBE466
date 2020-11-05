I found that in order to run my powershell script on the server I needed to disable a security policy restricting the running of scripts to only signed ones. I did this with: 

Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

Upon a fresh Server installation the IP address info and DNS info needs to be manually set (157.182.203.110) so that the server can access the internet. Once the internet can be accessed the git repo with the scripts can be downloaded and the setup script can be run. After the script has been run the DNS server will be setup and then the servers DNS server should be pointed to itself (127.0.0.1). 