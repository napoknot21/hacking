fd = open('./msg.enc','r')
 
secret = fd.read()
ct = bytes.fromhex(secret)
 
decrypted_str = ""
 
for char in ct:
    for brute_val in range(33, 126):
        if ((123 * brute_val + 18) % 256) == char:
            decrypted_str += chr(brute_val)
            break
 
print(decrypted_str)
