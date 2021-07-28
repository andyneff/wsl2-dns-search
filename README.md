# Fix DNS Search in WSL2

WSL2 does not support copying the DNS Search like WSL1. This is a fix for until someone does something better

## Problem

`search myorg.com` is missing from `/etc/resolv.conf`

You can't just use the `wsl.conf` file to disable the auto generation of `/etc/resolv.conf` and create a static `/etc/resolv.conf` file, because the WSL2 network (and the WSL2 DNS repeater) is likely to change. 😥

## Solution

So every time a WSL window is opened (running bash) the profile files are run, and this added one to patch the `/etc/resolv.conf` file. If you use multiple WSL2 distros, you will need to install this in each WSL2 distro

## Installation

1. git Clone this repo in WSL2
2. `sudo ./wsl2-dns-search-setup.sh`

## Uninstall

1. `sudo ./wsl2-dns-search-unsetup.sh`

## Problems

1. `/etc/resolv.conf` reverts. Every time `wsl` is called for that distro, it will regenerate `/etc/resolv.conf`. This means every time a new bash is opened, it will be regenerated, but it will be patches a second later by this fix. However, if e.g. `wsl -d {distro name} ls` is called, then the file will be regenerated and not get patched. The easiest way to fix this will be open a new bash or `sudo /usr/local/sbin/wsl2-dns-search.sh`.
    - If other cases continue to prevail, a notify solution will be added.
