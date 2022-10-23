# hacking utils

In this repository, you will find some *hacking* scripts that will make enumerations ports and discovering hosts more easier.

First of all, we need to clone the repository.
```
git clone https://github.com/napoknot21/hacking-utils.git
```

Make sure to install the following packages: ```nmap```, ```awk```, ```xargs```, ```tr``` and ```xclip```


## Shortcuts

In order to use these scripts in any current directory, you need to add their path to your ```$TERM``` config file !

Here are some examples depending on your shell

### Bash
Add the following lines to your ```~/.bashrc``` file
```
# hacking-utils shortcuts
alias extractPorts="PATH/TO/FILE/hacking-utils/extractPorts.sh"
alias scanPorts="PATH/TO/FILE/hacking-utils/scanPorts.sh"
alias hostDiscovery="PATH/TO/FILE/hacking-utils/hostDiscovery.sh"
alias osDiscovery="PATH/TO/FILE/hacking-utils/osDiscovery.sh"
```
> Replace "PATH/TO/FILE" for the path where the cloned repository is located


### Fish
Add the following lines in the ```~/.config/fish/config.fish``` file
```
# hacking-utils shortcuts
alias extractPorts "PATH/TO/FILE/hacking-utils/extractPorts.sh"
alias scanPorts "PATH/TO/FILE/hacking-utils/scanPorts.sh"
alias hostDiscovery "PATH/TO/FILE/hacking-utils/hostDiscovery.sh"
alias osDiscovery "PATH/TO/FILE/hacking-utils/osDiscovery.sh"
```
> Replace "PATH/TO/FILE" for the path where the cloned repository is located


### Zsh
Add the following lines in the ```~/.zshrc``` file
```
# hacking-utils shortcuts
alias extractPorts="PATH/TO/FILE/hacking-utils/extractPorts.sh"
alias scanPorts="PATH/TO/FILE/hacking-utils/scanPorts.sh"
alias hostDiscovery="PATH/TO/FILE/hacking-utils/hostDiscovery.sh"
alias osDiscovery="PATH/TO/FILE/hacking-utils/osDiscovery.sh"
```
> Replace "PATH/TO/FILE" for the path where the cloned repository is located


## Scripts
Now, let's explain what each script does and how to use them !

### **extractPorts**
> *Attention*:
> For using the tool, you must to export your nmap scan ports on a grep format:
> In other words, add ```-oG allPorts``` at the end of your nmap scan

this script is a helper tool for ```nmap``` scans. This will allow you to grep all open ports after your nmap scan for visualizing them and at the end, the script copies them in order to paste them if you need them for other nmap commands.

```$1``` : The grepeable scan nmap file.

For example:
```
extractPorts allPorts
```

### **scanPorts**
The same result as a classic scanning ports by ```nmap```. Otherwise, this script is less *"louder"* than the standard nmap scanning ports. So this will allow you to discover open ports without being detected.

```$1``` : the IP address of the targeted machine.


```
scanPorts 123.232.213.132
```

### **hostDiscovery**
Allows to discover all devices connected to a hostPot (wifi, mobile hostPot, etc) and shows the potential operating system.

```$1``` : the IP address of the targeted hostPot.

For example :
```
hostDiscovery 123.232.213.132
```
If you are connected to the hostPot that you will analyze, then run the script without any arguments/parameter !
```
hostDiscovery
```

### **osDiscovery**
Gives you a potential operating systems from a IP address machine
> make sure the machine is active

```$1``` : the IP address of the targeted machine.

Example :
```
osDiscovery 123.232.213.132
```

Made by Charly Martin-Avila (@napoknot21)