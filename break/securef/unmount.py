#! /usr/bin/env python

import os

inf = raw_input("encrypted file: ")
print "decrypting..."
os.system("openssl aes-256-cbc -d -a -in " + inf " -out temp.tgz")
print "expanding..."
os.system("tar -zxf temp.tgz; rm temp.tgz")
print "mounted successfully\n"
