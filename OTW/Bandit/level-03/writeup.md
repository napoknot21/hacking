# Level 3

## Level Goals
The password for the next level is stored in a file called **spaces in this filename** located in the home directory

## Write up

Logged in with **bandit1** username, we can try to find where the filename location is by
```
cd / ; grep -R "spaces in this filename" 2> /dev/null
```

The first lines of the out are
```
var/tmp/first.txt:/home/bandit2/spaces in this filename
var/tmp/text.text:spaces in this filename.swi
var/tmp/text.text:spaces in this filename.swj
var/tmp/text.text:spaces in this filename.swk
var/tmp/text.text:spaces in this filename.swl
var/tmp/text.text:spaces in this filename.swm
var/tmp/text.text:spaces in this filename.swn
var/tmp/text.text:spaces in this filename.swo
var/tmp/text.text:spaces in this filename.swp
...
```

The first line shows that there's a file in the ``` /home/bandit2 ``` directory

So, we need to log out and log in with **bandit2** credentials
> We log out of the **bandit1** by
```
exit
```

Connect with **bandit2 user**
```
ssh bandit2@bandit.labs.overthewire.org -p 2220
```

Then, enter the password we found in the [level-2]("../level-02/writeup.md")

Once logged in with **bandit2**, we show the filename content by
```
cat spaces\ in\ this\ filename
```

We have the password for the next level !
```
aBZ0W5EmUfAf7kHTQeOwd8bauFJ2lAiG
```

And we finished the level !
