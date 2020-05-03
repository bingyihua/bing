# -*- coding: utf-8 -*-
import paramiko
# import os
hostname='192.168.43.1'
port=8022
username='u0_a105'
pkey='C:/Users/cui/.ssh/id_rsa'  #
key=paramiko.RSAKey.from_private_key_file(pkey)
s=paramiko.SSHClient()
s.load_system_host_keys()
s.connect(hostname,port,username,pkey=key)
stdin,stdout,stderr=s.exec_command("ls")
print (stdout.readlines())
# import cx_Oracle
# db = cx_Oracle.connect('vltdba', 'HyxtTest_9', '192.168.117.223:1521/VLT')
