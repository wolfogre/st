#!/bin/sh
#adjust date time

set -e

echo "adjusting, please wait..."
ntpdate 0.asia.pool.ntp.org 1.asia.pool.ntp.org 2.asia.pool.ntp.org 3.asia.pool.ntp.org
hwclock -w

date -R
