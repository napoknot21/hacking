## FIRST SOLUTION
Reading the file, we notice that the last 2 words are
```
"[hash_type]"[HASH]
```

For exemple, we have :
```
"MD5"0b306e9db1f819dd824acf3227b60e07
```

What it means that the hash type is MD5 and next to, the word hashed.

So, in the first line we see that
```
"PLAIN"1234
```

PLAIN => no hash (free)

So the passwd is : ``` 1234 ```
