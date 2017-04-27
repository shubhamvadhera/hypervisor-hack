#!/bin/bash
sudo insmod printcount.ko
sudo rmmod printcount
dmesg
