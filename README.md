# Getting DNS Search in WSL2

WSL2 does not support copying the DNS Search like WSL1. This is a workaround for until someone does something better

## Problem

`search myorg.com` is missing from `/etc/resolv.conf`

You can't just use the `wsl.conf` file to disable the auto generation of `/etc/resolv.conf` and create a static `/etc/resolv.conf` file, because the WSL2 network (and the WSL2 DNS repeater) is likely to change. 😥

## Solution

So every time a WSL window is opened (running bash) the profile files are run, and this added one to patch the `/etc/resolv.conf` file. If you use multiple WSL2 distros, you will need to install this (and its dependencies) in each WSL2 distro.

## Installation

Dependencies:

- `sudo`. You can use gosu or su-exec, but these are not secure like `sudo`. If you _must_, run these commands before running `wsl2-dns-search-setup.sh`:

  ```bash
  function sudo()
  {
    gosu root "${@}"
  }
  export -f sudo
  ```

- `supervisord` - Allows us to maintain daemons the _same_ way on many different Linux distros
- `inotifywait` - Allows us to monitor `resolv.conf` changes.


1. git Clone this repo in WSL2
2. `sudo ./wsl2-dns-search-setup.sh`

## Uninstall

1. `sudo ./wsl2-dns-search-unsetup.sh`
