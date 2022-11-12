# Level 5

## Level Goals
The password for the next level is stored in the only human-readable file in the inhere directory. Tip: if your terminal is messed up, try the “reset” command.


## Write up

Connect to **bandit4** user by
```
ssh bandit4@bandit.labs.overthewire.org -p 2220
```

We enter the password found in the last [level]("../level-04/writeup.md") !

Once logged in, we need to see the content of current directory
```
ls
```

We see there's a directory named ```inhere```, then
```
cd inhere
```

Have to list **all** the content directory by
```
ls -la
```

We notice that all files start by **-** (ex. -file00, etc). 

we need to kwon what file is the correct one (because the other ones are not human-readable)
```
file -- -file0*
```

The output tell us the good one !
```
-file00: OpenPGP Public Key
-file01: data
-file02: data
-file03: data
-file04: data
-file05: data
-file06: data
-file07: ASCII text
-file08: data
-file09: data
```

So, the file is ```-file-07```

Print the content by
```
cat -- -file-07
```

We get the password for the next level !
```
lrIWWI6bB37kxfiCQZqUdOIYfr6eEeqR
```

We finish it !
