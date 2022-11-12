# Level 8

## Level Goals
The password for the next level is stored in the file data.txt next to the word millionth

## Write up

Connect to **bandit7** user by
```
ssh bandit7@bandit.labs.overthewire.org -p 2220
```

We enter the password found in the last [level]("../level-06/writeup.md") !

Once logged in, we need to see the content of current directory
```
ls -la
```

We find there's a file called ```data.txt```

The next one-line command will filter by the word **millionth**
```
cat data.txt | grep millionth
```

The output shows that there's only one line ! 
```
millionth	TESKZC0XvTetK0S9xNwm25STk5iWrBvP
```

So, we get the password (next to millionth) for the next level !
```
TESKZC0XvTetK0S9xNwm25STk5iWrBvP
```

We finish it !
