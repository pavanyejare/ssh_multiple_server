#!/usr/bin/python3

from pssh.pssh_client import ParallelSSHClient
import os
import sys

def man():
    print('=================== help ==========================')
    print('Pass the hostname as argument using comma separated')
    print("Eg - python3 ssh_server.py hostname1,hostname2,so_on.. ")
    print('===================================================')
    exit()

#Following function is used to read the argument as hostname and store it in  hosts veriable 
def read_hostname():
    if len(sys.argv) <= 1 :
        man()
    else:
        host = str(sys.argv[1])
        host = host.split(",")
        return host

#Following function is used to read and return user input 
#also checked keyboard interrupt if ctrl+c pressed script will be terminated 
def read_cmd():
    try:
        command = str(input('[Enter Command ~]# '))
        return command
    except KeyboardInterrupt:
        exit()

#Mail program start here 
def main():
    hosts=read_hostname()
    #considerd as all server have common user_name and password
    #using "pssh.pssh_client" lib login each server  parallel using password based auth (possible ssh key file also)
    client = ParallelSSHClient(hosts, user='root', password='qwaszx')
    while True :
        cmd = read_cmd()
        if cmd == 'exit':
            exit()
        #Fired command using the following method 
        output = client.run_command(cmd)
       # print (output)
       #collect output of each host and pring on screen 
        for i in output:
            print('[root @ {0} ~]#'.format(i))
            for line in output[i]['stdout']:
                print(" ", line)
        print()
main()

