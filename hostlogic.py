import os
count = 0

username = input("Enter username: ")
file_path = input("Enter filepath: ")

try:
    with open(file_path, 'r') as my_file:

        # Using for loop
        for line in my_file:
            count += 1
            host = line.strip()
            print("Line{}: {}".format(count, host))
           
            stream = os.popen('ls -la')
            # stream = os.popen(f'ssh {username}@{hostname} copy ./test.sh /tmp/test.sh')
            # stream = os.popen(f'ssh {username}@{hostname} ./test.sh')
            output = stream.readlines()
            print(output)

except Exception as ex:
    print("*******")
    print(str(ex))
    print("*******")
    raise ex
---------------------------------------------------------------


#!/usr/bin/python

username = input('enter username: ')
filepath = input('enter filepath: ')

import os


file1 = open(filepath, "r")

while(True):
        #read next line
        line = file1.readline()
        #check if line is not null
        if not line:
                break
        #you can access the line
        print(line.strip())
        hostname,tag = line.strip().split(',')
        # stream = os.popen(f'ssh {username}@{hostname} copy ./test.sh /tmp/test.sh')
        # stream = os.popen(f'ssh {username}@{hostname} ./test.sh')
        #stream = os.popen(f'ls')
        #output = stream.readlines()
        print output
        print hostname
        print tag
#close file
file1.close
