#!/usr/bin/perl

while(<>)
{
	/^(.*?)\ (.*?)$/;
	$mail = $1;
	$nick = $2;

	if($mail eq "" || $nick eq "" || $mail =~ /\ / || $nick =~ /\ / || !($mail =~ /\@/))
	{
		die "wrong format";
	}

	open(SENDMAIL, "|/usr/sbin/sendmail \"-FPTLink Services\" -fnoreply\@ptlink.net -t");
# EMAIL DEFINITION
	print SENDMAIL <<EOT;
From: PTlink Services\@network.net
To: $mail
Subject: Nick expiring soon
Your nick, $nick, will expire in about 5 days. 
If you intend tu keep the registration please come to IRC Network
using the command /server irc.network.net from your irc client and
then just identify your nick with /NickServ IDENTIFY password

For more informations email to irc\@some.net 
PTlink Services
http://www.ptlink.net
.
EOT
	close(SENDMAIL);
}


