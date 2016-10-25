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
Subject: Bijnaam verloopt binnenkort
Uw bijnaam, $nick, zal binnen 5 dagen komen te vervallen. 
Als U deze bijnaam geregistreerd wilt blijven houden, log dan 
in op het IRC netwerk met het commando /server irc.netwerk.net op uw
irc client en dan /nickserv identify wachtwoord

Voor meer informatie mail naar: irc\@some.net 
PTlink Services
http://www.ptlink.net
.
EOT
	close(SENDMAIL);
}


