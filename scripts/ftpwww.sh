#!/bin/sh
# WWW services stats update script - Lamego@PTlink.net

# Set this to your services data directory
ddir="$HOME/services/data"

# GNU plot full filename
gnup="/usr/bin/gnuplot"

# www host for ftp
webhost="my.webserver.net"
# user
webuser="ftpuser"
# pass
webpass="ftppass"

# directory to put inside home dir
# NOTE: You must creat this dir. yourself
webdir="www/sstats"

################### Do not change ##################
cd $ddir

# Create graph gifs #
echo "Creating graphs..."
tail -n180 history.log > history180.log
tail -n30 history.log > history30.log
$gnup nicks.plot
# Tansfer to web account
echo "Transfering to web account"
ftp -n << EOF
open $webhost
quote user $webuser
quote pass $webpass
cd $webdir
binary
prompt
mput *.png
put index.html
ls
EOF
echo Done
