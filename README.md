# SetDHCPTrue
CURL against Icon API to configure set network DHCP = true. 
USAGE: You can invoke this script in two ways

- ./setDHCPTrue.sh password ipAddress
- ./batchRun.sh password ExampleFile.txt
  
Notes* <br />
Customer will need a Linux or MAC machine with CURL utility installed.  
Password parameter is optional.  
Script assumes a default password of ‘admin/admin’ if no password parameter is given.  

Optional batchRun.sh calls setDHCPTrue.sh against a file with a list of IPs the script will operate over. See ExampleFile.txt for formatting examples.

