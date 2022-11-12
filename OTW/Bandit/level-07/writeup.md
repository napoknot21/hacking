# Level 7

## Level Goals
The password for the next level is stored somewhere on the server and has all of the following properties:

owned by user bandit7
owned by group bandit6
33 bytes in size

## Write up

Connect to **bandit6** user by
```
ssh bandit6@bandit.labs.overthewire.org -p 2220
```

We enter the password found in the last [level]("../level-06/writeup.md") !

Once logged in, we need to see the content of current directory
```
ls -la
```

Apparently, nothing important appears...

The next one-line command will search all properties !
```
find / -user bandit7 -group bandit6 -size 33c 2>/dev/null
```

We have the only one file in the following path 
```
/var/lib/dpkg/info/bandit7.password
```

So, we get the password for the next level !
```
z7WtoNQU2XfjmMtWA8u5rN4vzqu4v99S
```

We finish it !
