I found that in order to run my powershell script on the server I needed to disable a security policy restricting the running of scripts to only signed ones. I did this with: 

Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

