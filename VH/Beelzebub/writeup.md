# Beelzebub

Let's begin by discovering the IP of the target machine
```
apr-scan -I eth0 --localnet -g
```

Following the output, we find out the ip
```
Starting arp-scan 1.10.0 with 256 hosts (https://github.com/royhills/arp-scan)
192.168.1.55	08:00:27:f8:b7:31	PCS Systemtechnik GmbH
...
```

We have as ```IP```: 192.168.1.55

Let's start the scanning and enumerating the machine
```
nmap -p- -sS --open --min-rate 5000 -n -Pn -vvv 192.168.1.55 -oG allPorts
```

We have the ```22``` and ```80``` open ports, let's deep into details
```
nmap -sC -sV -p22,80 192.168.1.55 -oN targeted
```

For now, can't do a lot with the ssh service, let's dig into the http service
```
whatweb http://192.168.1.55/
```

The output gives information about the server
```
http://192.168.1.55/ [200 OK] Apache[2.4.29], Country[RESERVED][ZZ], HTTPServer[Ubuntu Linux][Apache/2.4.29 (Ubuntu)], IP[192.168.43.22], Title[Apache2 Ubuntu Default Page: It works]
```

