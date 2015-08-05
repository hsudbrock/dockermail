#!/bin/bash

# configure mail delivery to dovecot
cp /dockermail-config/aliases /etc/postfix/virtual
cp /dockermail-config/domains /etc/postfix/virtual-mailbox-domains

# map virtual aliases and user/filesystem mappings
postmap /etc/postfix/virtual
postmap /etc/postfix/virtual-mailbox-maps

# todo: this could probably be done in one line
mkdir /etc/postfix/tmp; awk < /etc/postfix/virtual '{ print $2 }' > /etc/postfix/tmp/virtual-receivers
sed -r 's,(.+)@(.+),\2/\1/,' /etc/postfix/tmp/virtual-receivers > /etc/postfix/tmp/virtual-receiver-folders
paste /etc/postfix/tmp/virtual-receivers /etc/postfix/tmp/virtual-receiver-folders > /etc/postfix/virtual-mailbox-maps

# Add password file
cp /dockermail-config/passwords /etc/dovecot/passwd
