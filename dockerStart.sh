#!/bin/sh
service docker start
service jenkins start
/usr/sbin/apache2ctl -D FOREGROUND
