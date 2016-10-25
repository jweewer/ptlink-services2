#!/bin/sh
# Fix the following path for services binary 
cd $HOME/services
./listnicks -e 5 > todayexpires.list
./mail.pl < todayexpires.list