#!/usr/bin/python

username = input('enter username: ')
filepath = input('enter filepath: ')

import os


file1 = open("{filepath}", "r")

while(True):
        #read next line
        line = file1.readline()
        #check if line is not null
        if not line:
                break
        #you can access the line
        print(line.strip())
        hostname = line.strip()
        # stream = os.popen(f'ssh {username}@{hostname} copy ./test.sh /tmp/test.sh')
        # stream = os.popen(f'ssh {username}@{hostname} ./test.sh')
        stream = os.popen(f'ls')
        output = stream.readlines()
        print output
#close file
file1.close
