# Level 6

## Level Goals
The password for the next level is stored in a file somewhere under the inhere directory and has all of the following properties:

human-readable
1033 bytes in size
not executable

## Write up

Connect to **bandit5** user by
```
ssh bandit5@bandit.labs.overthewire.org -p 2220
```

We enter the password found in the last [level]("../level-05/writeup.md") !

Once logged in, we need to see the content of current directory
```
ls
```

We see there's a directory named ```inhere```, then
```
cd inhere
```

We have two methods to find the file !

### 1st method
The next one-liner command will just search the number **1033** in the properties of files content
```
ls -Rla | grep 1033
```
We noticed is the only one ! so the ```./maybehere07.file2``` is the file !

> This is not the best accurate method but if we're lucky, so this method could work !

### 2nd method
The next one-line command will search all properties !
```
find . -readable -size 1033c -not -executable
```

The ouput is :
```
./maybehere07/.file2
```

So, we get the password for the next level !
```
P4L4vucdmLnm8I7Vl7jG1ApGSfjYKqJU

```

We finish it !
