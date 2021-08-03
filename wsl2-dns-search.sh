#!/usr/bin/env bash

function patch_etc_resolv()
{
  for domain in $("%%SYSTEM_ROOT%%/system32/WindowsPowerShell/v1.0/powershell.exe" -NoProfile -Command "(Get-DnsClientGlobalSetting).SuffixSearchList" | tr -d "\\r"); do
    domain="${domain//./\\.}"
    if ! grep -q "^ *search" /etc/resolv.conf; then
      sed -i '$asearch '"${domain}" /etc/resolv.conf
    else
      sed -Ei '/^ *search .*'"${domain}"'( |$)/n;
              s/^ *search .*/& '"${domain}/" /etc/resolv.conf
    fi
  done
}

while patch_etc_resolv; do
  if ! inotifywait -e close_write /etc/resolv.conf; then
    # Returns 1 if the files was deleted
    while [ ! -e /etc/resolv.conf ]; do
      sleep 1
    done
    # Wait for file to regenerate, it usually happens so fast, it's recreated
    # this look even checks, and zero sleeps occur
  fi
done