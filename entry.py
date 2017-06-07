#!/usr/bin/env python

import json
import yaml
from base64 import b64decode
from boto3.session import Session
from os import environ, makedirs, path
from subprocess import Popen

aws = Session()
kms = aws.client('kms')

with open('/opt/secrets.yml', 'r') as secretYAML:
    secrets = yaml.load(secretYAML)

for f in secrets['files'].keys():
    plaintext = kms.decrypt(
        CiphertextBlob=b64decode(secrets['files'][f]),
    )['Plaintext']

    if not path.isdir(path.dirname(f)):
        makedirs(path.dirname(f))

    with open(f, 'w') as secretFile:
        secretFile.write(plaintext)

cmd_apache = 'httpd-foreground'
p = Popen(cmd_apache.split())
p.communicate()

