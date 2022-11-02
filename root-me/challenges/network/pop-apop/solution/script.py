import hashlib

wd = "/home/charly/.wordlists/rockyou.txt"
hash_apop = "4ddd4137b84ff2db7291b568289717f0"
banner = "<1755.1.5f403625.BcWGgpKzUPRC8vscWn0wuA==@vps-7e2f5a72>"

with open (wd, encoding="ISO-8859-1") as f :
    word_line = f.read().splitlines()

for passwd in word_line :
    print ("[*] Testing - " + passwd)
    concat_hash = banner + passwd
    md5_hash = hashlib.md5(concat_hash.encode("utf-8")).hexdigest()
    if md5_hash == hash_apop :
        print ("[!] FOUND - " + passwd)
        exit(0)
