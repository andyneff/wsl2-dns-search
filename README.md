# Fix DNS Search in WSL2

WSL2 does not support copying the DNS Search like WSL1. This is a fix for until someone does something better

## Problem

`search myorg.com` is missing from `/etc/resolv.conf`

You can't just use the `wsl.conf` file to disable the auto generation of `resolv.conf` and create a static `resolv.conf` file, because the WSL2 network (and the WSL2 DNS repeater) is likely to change. 😥

## Solution

So everytime a WSL window is opened (running bash) the profile files are run, and this added one to patch the resolv.conf file. If you use multiple WSL2 distros, you will need to install this in each WSL2 distro
