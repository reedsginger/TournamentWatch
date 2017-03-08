#!/usr/bin/env python2.7

import requests
import os
import re



r = requests.get('http://www.dota2.com/heroes/')
lst = re.findall('.*(http://www.dota2.com/hero/[^\/]+\/).*', r.text)
h_lst = re.findall('.*http://www.dota2.com/hero/([^\/]+)\/.*', r.text)


list2 = []
for i in lst:
	l2temp=[]
	while (True):
		try:
			r2 = requests.get(i)
			l2_temp = re.findall('http://cdn.dota2.com/apps/dota2/images/heroes/.*_full.png',r2.content)
			list2.append(l2_temp[0])
			print l2_temp[0]
			break
		except:
			print "Trying again... ", r2.status_code

j = 0
for i in list2:
	temp = requests.get(i)
	with open(h_lst[j]+'.png',"wb") as img:
		img.write(temp.content)
	j += 1
