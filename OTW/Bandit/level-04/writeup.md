# Level 4

## Level Goals
The password for the next level is stored in a hidden file in the inhere directory.

## Write up

Connect to **bandit3** user by
```
ssh bandit3@bandit.labs.overthewire.org -p 2220
```

We enter the password found in the last [level]("../level-03/writeup.md") !

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

We print the content of the ```.hidden``` file (found in the last output) by
```
cat .hidden
```

We get the password for the next level !
```
2EW7BBsr6aMMoJ2HjW067dm8EgX26xNe
```

We finish it !
