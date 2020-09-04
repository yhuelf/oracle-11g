#!/usr/bin/env bash

set -e
source /assets/colorecho

ACCEPT_CIDR="192.168.0.0/24"
iptables -A INPUT -s $ACCEPT_CIDR -j ACCEPT
iptables -A INPUT -j DROP
iptables -A OUTPUT -d $ACCEPT_CIDR -j ACCEPT
iptables -A OUTPUT -j DROP

if [ ! -d "/opt/oracle/app/product/11.2.0/dbhome_1" ]; then
	echo_yellow "Database is not installed. Installing..."
	/assets/install.sh
fi

su oracle -c "/assets/entrypoint_oracle.sh"

