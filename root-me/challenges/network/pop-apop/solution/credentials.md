We have as banner :
```
<1755.1.5f403625.BcWGgpKzUPRC8vscWn0wuA==@vps-7e2f5a72>
```

We have this as diggest md5 hash
```
APOP bsmith 4ddd4137b84ff2db7291b568289717f0
```

the format is :
```
hash_toèmd5(<1755.1.5f403625.BcWGgpKzUPRC8vscWn0wuA==@vps-7e2f5a72>PASSWORD)
```

We create a script to make an force brutting attack :
```
python3 script.py
```

We can alternatively use hashcat or john by :
```
awk '$0="<1755.1.5f403625.BcWGgpKzUPRC8vscWn0wuA==@vps-7e2f5a72>"$0' rockyou.txt > new_file
hashcat -m 0 '4ddd4137b84ff2db7291b568289717f0' new_file
```
```
john --format=dynamic_1520 hash_flag.txt --wordlist=sorted-wordlist-dict --fork=4
john --show --format=dynamic_1520 hash_flag.txt
```
