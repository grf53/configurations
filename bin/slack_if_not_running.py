#!/usr/bin/python3

import os
import sys
import json
import time
import argparse


def routine(container, sleep, message, wait):
    while True:
        status = json.loads(os.popen(f'docker inspect {container}').read())[0]["State"]["Status"]
        if status != 'running':
            os.system(f'toslack {message}')
            break
        elif wait:
            print(wait)
        time.sleep(sleep)


def main():
    parser = argparse.ArgumentParser(description='Send slack message to wrpark when the docker container is not running.')
    parser.add_argument('container',
                        help='container name to check the status')
    parser.add_argument('-s', '--sleep', metavar='<seconds>', type=int, default=60,
                        help='sleep interval for a check in seconds [default: 60s]')
    parser.add_argument('-m', '--message', metavar='<string>', default='Done!',
                        help='message to slack')
    parser.add_argument('--wait', metavar='<string>', default='',
                        help='print this message if the container is still running for a check.')
    
    args = parser.parse_args()
    routine(**args.__dict__)

if __name__ == '__main__':
    main()
