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
