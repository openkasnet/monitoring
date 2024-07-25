#!/bin/bash
## Print horizontal ruler with message
rulem ()  {
	if [ $# -eq 0 ]; then
		echo "Usage: rulem MESSAGE [RULE_CHARACTER]"
		return 1
	fi
	# Fill line with ruler character ($2, default "-"), reset cursor, move 2 cols right, print message
	printf -v _hr "%*s" $(tput cols) && echo -en ${_hr// /${2--}} && echo -e "\r\033[2C$1"
}

rulem '[ OS relesion ]'
printf "\n"
lsb_release -a
printf "\n"

rulem "[ IP addresses ]"
printf "\n"
ip addr | grep -Po '(?!(inet 127.\d.\d.1))(inet \K(\d{1,3}\.){3}\d{1,3})'

printf "\n"
rulem "[ File systems ]"

printf "\n"
df -h | awk '(! /^run/ && ! /^tmpfs/ && ! /^dev/ && ! /^efivarfs/)'
printf "\n"


rulem "[ Network test ]"
ping -c 1 google.com &> /dev/null && echo Network success || echo Network fail

