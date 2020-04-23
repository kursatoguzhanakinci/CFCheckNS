#!/bin/bash

for domain in $(cat $1);do
records=$(dig +trace $domain @1.1.1.1 | grep cloudflare)
if [ ! -z "$records" ]
then
    a_records=$(dig +short $domain A @1.1.1.1)
    if [ -z "$a_records" ]
    then
        host_check=$(host $domain | grep SERVFAIL)
        if [ ! -z "$host_check" ]
                then
                echo "[+] Domain: $domain -> This domain is not registered to Cloudflare."
        fi
    fi
else
        echo "$domain -> This domain doesn't use CloudFlare."
fi
done
