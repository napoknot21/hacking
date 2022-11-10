# Level 1

## Level goal
The password for the next level is stored in a file called readme located in the home directory. Use this password to log into bandit1 using SSH. Whenever you find a password for a level, use SSH (on port 2220) to log into that level and continue the game.

## Write up

First, we exec a ```ls``` command to list the directory files and then we notice there's only one file named ```readme```, so for see the content
```
cat readme
```

Then, we have the password:
```
NH2SXQwcBdpmTEzi3bvBHMM9H66vVXjL
```

So, we log out from the ssh connexion with ```exit```

Then, connext to ssh this time with the **bandit1** user
```
bandit1@bandit.labs.overthewire.org -p 2220
```

And Finally, we enter the password we find before !
