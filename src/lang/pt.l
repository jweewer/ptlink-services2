# Arquivo do idioma Portugues (de Portugal).
#
# Services e' protegido por direitos autorais (c) 1996-1999 Andy Church.
#     E-mail: <achurch@dragonfire.net>
# Este programa e' gratis porem registado; veja o arquivo COPYING
# para detalhes.

# Quando traduzindo este programa para outra idioma, lembre-se que a
# ordem dos parametros para sprintf() e' fixado no codigo de fonte, entao
# suas mensagens precisam ter os mesmos parametros nos mesmos padroes das
# mensagens em ingles.  (Obviamente, isto nao e' valido para linhas no formato
# strftime() que ficam uma abaixo das outras).  Se nao pode adquirir uma
# traducao das mensagens naturalmente sem mudar as ordens dos parametros, me
# avise (achurch@dragonfire.net) qual mensagem esta causando o problema e eu
# verei o que posso fazer.
#
# Nas mensagens de ajuda, "%S" (S maiusculo, nao minusculo) se refere ao nome
# do servico que envia a mensagem; por exemplo, na mensagem de ajuda do
# Nickserv, "%S" e' substituido por "NickServ" (ou outro nome definido
# no config.h).  Os %S's nao contam como sendo parametros de sprintf(),
# assim podem ser reorganizados, removidos, ou adicionados se necessario.
#
# Finalmente, lembre-se de colocar TAB no comeco de toda linha do texto
# (incluindo linhas vazias). Tem que ser TAB, nao espacos.

###########################################################################
#
# Nome deste idioma
#
###########################################################################

# Para idiomas diferentes do ingles, essa string deve ter o seguinte formato:
#     language-name-in-language (language-name-in-English)
# Por exemplo, "Español (Spanish)" or "Français (French)".

LANG_NAME
	Portugues (Portuguese)

###########################################################################
#
# Mensagens Gerais
#
###########################################################################

# Strings no formato strftime(). "man 3 strftime" para informacoes sobre o
# significado da especificacao do formato.  Versao pequena:
#	%a = nome do dia da semana (pequeno)	%H = hora
#	%b = nome do mes (pequeno)		%M = minuto
#	%d = dia do mes				%S = segundo
#	%Y = ano				%Z = zona de fuso horario

# O seguinte e' usado para o formato de uma string da strftime(), com uma
# data e horario mostrados juntamente.
STRFTIME_DATE_TIME_FORMAT
	%d %b %H:%M:%S %Y %Z
# O seguinte e' usado para o formato de uma string da strftime(), com uma
# data sozinha de formato longo (Para o ingles inclui-se o dia da semana).
STRFTIME_LONG_DATE_FORMAT
	%a %d %b %Y
# O seguinte e' usado para o formato de uma string da strftime(), com apenas
# a data em formato curto (Para o ingles: sem o dia da semana).
STRFTIME_SHORT_DATE_FORMAT
	%d %b %Y

# Estes especificam para a strftime() quais sao os nomes dos dias e meses.
# Se nao usar %a, %A, %b, or %B nas suas strings da strftime(), pode
# deixar essas partes vazias.  No entanto, se colocar nomes, eles DEVEM 
# ficar ordenados, um por linha, e a lista DEVE estar completa!

# %a
STRFTIME_DAYS_SHORT
	Dom
	Seg
	Ter
	Qua
	Qui
	Sex
	Sab
# %A
STRFTIME_DAYS_LONG
	Domingo
	Segunda
	Terca
	Quarta
	Quinta
	Sexta
	Sabado
# %b
STRFTIME_MONTHS_SHORT
	Jan
	Fev
	Mar
	Abr
	Mai
	Jun
	Jul
	Ago
	Set
	Out
	Nov
	Dez
# %B
STRFTIME_MONTHS_LONG
	Janeiro
	Fevereiro
	Marco
	Abril
	Maio
	Junho
	Julho
	Agosto
	Setembro
	Outubro
	Novembro
	Dezembro


# This is used in ChanServ/NickServ INFO displays.
COMMA_SPACE
	,


# Various error messages.
USER_RECORD_NOT_FOUND
	Erro interno - impossivel processar o pedido.
UNKNOWN_COMMAND
	Comando  %s  desconhecido.
UNKNOWN_COMMAND_HELP
	Comando  %s  desconhecido.  "/%s HELP" para ajuda.
SYNTAX_ERROR
	Sintaxe: %s
MORE_INFO
	  /%s HELP %s  para mais informacoes.
NO_HELP_AVAILABLE
	Ajuda nao disponivel para  %s .

BAD_USERHOST_MASK
	hostnames devem estar no formato ident@host.

SERVICE_OFFLINE
	%s esta actualmente desligado.
READ_ONLY_MODE
	 Atencao:  Services estao no modo read-only.  Mudancas nao serao guardadas!
ACCESS_DENIED
	Acesso negado.
PERMISSION_DENIED
	Permissao negada.
PASSWORD_INCORRECT
	Password incorrecta.

MORE_OBSCURE_PASSWORD
	Tente novamente com uma password mais dificil.  As passwords devem ter no 
	minimo cinco caracteres, nao devem ser algo deduzivel (ex: nome ou nick) e nao podem conter espacos ou TAB.
PASSWORD_TRUNCATED
	Notice:  A sua password foi limitada a %d caracteres.

NICK_NOT_REGISTERED
	O nick utilizado nao esta registado.
NICK_NOT_REGISTERED_HELP
	O nick utilizado nao esta registado.  Digite  /%s HELP  para mais
	informacoes sobre como regista-lo.
NICK_X_NOT_REGISTERED
	Nick  %s  nao esta registado.
NICK_X_NOT_IN_USE
	Nick  %s  nao esta em uso neste momento.
NICK_X_NOT_ON_CHAN
	Nick %s isn't on channel %s.
NICK_X_FORBIDDEN
	Nick  %s  nao pode ser utilizado ou registado.
CHAN_X_NOT_REGISTERED
	Canal  %s  nao esta registado.
CHAN_X_NOT_IN_USE
	Canal  %s  nao existe.
CHAN_X_FORBIDDEN
	Canal  %s  nao pode ser utilizado ou registado.
NICK_IDENTIFY_REQUIRED
	Autenticacao de password e requerida para este comando.
	Tente novamente apos digitar  /%s IDENTIFY password .
CHAN_IDENTIFY_REQUIRED
	Autenticacao de password e requerida para este comando.
	Tente novamente apos digitar  /%s IDENTIFY %s password .

###########################################################################
#
# Mensagens do NickServ
#
###########################################################################

# Automatic messages
NICK_IS_REGISTERED
	Este nick esta registado. Se for seu identifique
	( /%s IDENTIFY password ) . Se nao for escolha outro.
NICK_IS_SECURE
	Este nick esta registado e protegido.  
	Se o nick pertencer a si, digite  /%s IDENTIFY password .  
	Caso contrario escolha um nick diferente com /NICK outro_nick
NICK_MAY_NOT_BE_USED
	Este nick nao pode ser utilizado.  Por favor escolha outro.
DISCONNECT_IN_1_MINUTE
	Se nao trocar de nick dentro de  1 minuto , este sera alterado.
DISCONNECT_IN_20_SECONDS
	Se nao trocar de nick dentro de  20 segundos , sera desconectado.
DISCONNECT_NOW
	Este nick esta registado, nao o pode usar.  Por favor
	escolha um outro nick antes de reconectar.
	
# REGISTER responses
NICK_REGISTER_SYNTAX
	REGISTER password email
NICK_REGISTRATION_DISABLED
	Pedimos desculpa. O registo de nicks esta temporariamente desactivado.	
NICK_REGISTRATION_FAILED
	Pedimos desculpa. Ocorreu uma falha na hora do registo.
NICK_REG_PLEASE_WAIT
	Aguarde %d segundos antes de usar o comando REGISTER novamente.
NICK_CANNOT_BE_REGISTERED
	Nick  %s  nao pode ser registado.
NICK_ALREADY_REGISTERED
	Nick  %s  esta registado!
NICK_REGISTERED
	Nick  %s  registado a partir de sua conta: %s
NICK_PASSWORD_IS
	A sua password e  %s  - lembre-se dela para uso posterior.

# IDENTIFY responses
NICK_IDENTIFY_SYNTAX
	IDENTIFY password
NICK_IDENTIFY_FAILED
	Pedimos desculpa. A sua identificacao falhou.
NICK_IDENTIFY_SUCCEEDED
	Password aceite - o seu nick esta reconhecido.
# DROP responses
NICK_DROP_SYNTAX
	DROP
NICK_DROP_DISABLED
	Pedimos desculpa. Cancelamento do registo de nicks esta temporariamente 
	desactivado.
NICK_DROPPED
	O registo do seu nick foi cancelado.
NICK_X_DROPPED
	O registo do nick %s foi cancelado.

# SET responses
NICK_SET_SYNTAX
	SET opcao parametros
NICK_SET_SERVADMIN_SYNTAX
	SET [nick] opcao parametros
NICK_SET_DISABLED
	Pedimos desculpa. A Configuracao de opcoes do nick esta temporariamente 
	desactivada.
NICK_SET_UNKNOWN_OPTION
	Opcao SET  %s  desconhecida.
NICK_SET_UNKNOWN_OPTION_OR_BAD_NICK
	Opcao SET  %s  desconhecida, ou nick nao registado.

# SET PASSWORD responses
NICK_SET_PASSWORD_FAILED
	Pedimos desculpa. E impossivel trocar password.
NICK_SET_PASSWORD_CHANGED
	Password alterada.
NICK_SET_PASSWORD_CHANGED_TO
	Password alterada para %s .

# SET URL responses
NICK_SET_URL_CHANGED
	URL modificado para %s .
NICK_SET_URL_UNSET
	Associacao a URL foi apagada.

# SET EMAIL responses
NICK_SET_EMAIL_CHANGED
	E-mail modificado para %s .
NICK_SET_EMAIL_UNSET
	Associacao ao endereco de e-mail foi apagada.

# SET ICQNUMBER responses
NICK_SET_ICQ_CHANGED
	Numero ICQ alterado para #%s.
NICK_SET_ICQ_UNSET
	Numero ICQ foi apagado.

# SET LOCATION responses
NICK_SET_LOCATION_CHANGED
	Local alterado para %s.
NICK_SET_LOCATION_UNSET
	Local foi apagado.

# SET LANGUAGE responses
NICK_SET_LANGUAGE_SYNTAX
	SET LANGUAGE numero
NICK_SET_LANGUAGE_UNKNOWN
	Numero de linguagem %d desconhecido.  Digite  /%s HELP SET LANGUAGE 
	para uma lista de linguagens.
NICK_SET_LANGUAGE_CHANGED
	Linguagem modificada para Portugues .

# SET KILL responses
NICK_SET_KILL_SYNTAX
	Esta proteccao e agora obrigatoria, nao sendo por isso configuravel.
NICK_SET_KILL_IMMED_SYNTAX
	Esta proteccao e agora obrigatoria, nao sendo por isso configuravel.
NICK_SET_KILL_ON
	Esta proteccao e agora obrigatoria, nao sendo por isso configuravel.
NICK_SET_KILL_QUICK
	Esta proteccao e agora obrigatoria, nao sendo por isso configuravel.
NICK_SET_KILL_IMMED
	Esta proteccao e agora obrigatoria, nao sendo por isso configuravel.
NICK_SET_KILL_IMMED_DISABLED
	Esta proteccao e agora obrigatoria, nao sendo por isso configuravel.
NICK_SET_KILL_OFF
	Esta proteccao e agora obrigatoria, nao sendo por isso configuravel.

# SET PRIVATE responses
NICK_SET_PRIVATE_SYNTAX
	SET PRIVATE {ON | OFF}
NICK_SET_PRIVATE_ON
	Opcao PRIVATE activada.
NICK_SET_PRIVATE_OFF
	Opcao PRIVATE desactivada.

# SET HIDE responses
NICK_SET_HIDE_SYNTAX
	SET HIDE {EMAIL | QUIT} {ON | OFF}
NICK_SET_HIDE_EMAIL_ON
	O seu endereco de e-mail esta agora oculto na exibicao no %s INFO.
NICK_SET_HIDE_EMAIL_OFF
	O seu endereco de e-mail esta agora visivel para exibicao no %s INFO.
NICK_SET_HIDE_QUIT_ON
	A sua ultima mensagem de quit esta agora oculta para exibicao no %s INFO.
NICK_SET_HIDE_QUIT_OFF
	A sua ultima mensagem de quit esta agora visivel para exibicao no %s INFO.

# SET NOEXPIRE responses
NICK_SET_NOEXPIRE_SYNTAX
	SET [nick] NOEXPIRE {ON | OFF}
NICK_SET_NOEXPIRE_ON
	O Nick %s  nao ira expirar.
NICK_SET_NOEXPIRE_OFF
	O Nick %s  ira expirar.

# LINK responses
NICK_LINK_SYNTAX
	LINK nick password
NICK_LINK_DISABLED
	O comando LINK nao esta disponivel.
NICK_LINK_FAILED
	Pedimos desculpa. A ligacao falhou.
NICK_NO_LINK_SAME
	Nao pode fazer uma ligacao para o seu nick actual!
NICK_LINK_CIRCULAR
	Impossivel ligar o nick  %s : ligacao circular detectada.
NICK_LINKED
	Seu nick foi ligado ao nick  %s .

# UNLINK responses
NICK_UNLINK_FAILED
	Pedimos desculpa, desligacao de nicks falhou.
NICK_NOT_LINKED
	O seu nick nao esta ligado.
NICK_X_NOT_LINKED
	Nick %s nao esta ligado.
NICK_UNLINKED
	O seu nick foi desligacao do nick  %s .
NICK_X_UNLINKED
	O nick %s foi desligacao do nick %s.

# LISTLINKS responses
NICK_LISTLINKS_SYNTAX
	LISTLINKS nick [ALL]
NICK_LISTLINKS_SYNTAX2
	LISTLINKS
NICK_LISTLINKS_HEADER
	Lista de nicks ligados ao nick %s:
NICK_LISTLINKS_FOOTER
	%d nicks ligados.

# INFO responses
NICK_INFO_SYNTAX
	INFO nick
NICK_INFO_REALNAME
	%s e' %s
NICK_INFO_ADDRESS
	         Ultimo endereco: %s
NICK_INFO_TIME_REGGED
	         Data de registo: %s [%s]
NICK_INFO_LAST_IDENTIFY
	 Ultima vez identificado: %s [%s]
NICK_INFO_LAST_SEEN
	        Ultima vez visto: %s [%s]
NICK_INFO_ONLINE
	      Tempo total online: %s
NICK_INFO_LAST_QUIT
	 Ultima mensagem de quit: %s
NICK_INFO_URL
	                     URL: %s
NICK_INFO_EMAIL
	                  E-mail: %s
NICK_INFO_ICQ
	              Numero ICQ: #%s
NICK_INFO_LOCATION
	                   Local: %s
NICK_INFO_OPTIONS
	                  Opcoes: %s
NICK_INFO_NO_EXPIRE
	 Cancelamento do registo: nunca
NICK_INFO_OSUSPENDED
	 Suspensao de oline ate': %s
# These strings MUST NOT be empty
NICK_INFO_OPT_KILL
	Proteccao de Kill
NICK_INFO_OPT_PRIVATE
	Privado
NICK_INFO_OPT_NONE
	Nenhuma

# LIST responses
NICK_LIST_SYNTAX
	LIST padrao
NICK_LIST_SERVADMIN_SYNTAX
	LIST padrao [FORBIDDEN] [NOEXPIRE]
NICK_LIST_HEADER
	Lista das entradas que satisfazem  %s :
NICK_LIST_RESULTS
	Fim da listagem - %d/%d entradas mostradas.

NICK_RELEASED
	A proteccao dos Services ao seu nick foi desligada.

# GHOST responses
NICK_GHOST_SYNTAX
	GHOST nick [password]
NICK_NO_GHOST_SELF
	Nao pode utilizar um ghost em si mesmo!
NICK_GHOST_KILLED
	O ghost do seu nick foi desligado.

# GETPASS responses
NICK_GETPASS_SYNTAX
	GETPASS nick
NICK_GETPASS_UNAVAILABLE
	Comando invalido porque encriptacao esta em uso.
NICK_GETPASS_PASSWORD_IS
	password para %s e  %s .

# FORBID responses
NICK_FORBID_SYNTAX
	FORBID nick
NICK_FORBID_SUCCEEDED
	Nick  %s  esta proibido de ser usado.
NICK_FORBID_FAILED
	Nao se pode proibir o nick  %s !

###########################################################################
#
# Mensagens do ChanServ
#
###########################################################################

# Access level descriptions
CHAN_LEVEL_AUTOOP
	Modo +o automatico
CHAN_LEVEL_AUTOVOICE
	Modo +v automatico
CHAN_LEVEL_AUTODEOP
	Nao pode ser operador deste canal
CHAN_LEVEL_NOJOIN
	Nao pode entrar no canal se este estiver restrito (opcao RESTRICTED)
CHAN_LEVEL_INVITE
	Permitido usar o comando INVITE
CHAN_LEVEL_AKICK
	Permitido usar o comando AKICK
CHAN_LEVEL_SET
	Permitido usar o comando SET (nao sendo FUNDADOR)
CHAN_LEVEL_CLEAR
	Permitido usar o comando CLEAR
CHAN_LEVEL_UNBAN
	Permitido usar o comando UNBAN
CHAN_LEVEL_OPDEOP
	Permitido usar os comandos OP/DEOP
CHAN_LEVEL_ACCESS_LIST
	Permitido ver a lista de acesso
CHAN_LEVEL_ACCESS_CHANGE
	Permitido modificar a lista de acesso
CHAN_LEVEL_MEMO_READ
	Permitido listar ou ler as mensagens do canal
CHAN_LEVEL_MEMO_SEND
	Permitido enviar mensagens para o canal
CHAN_LEVEL_MEMO_DEL
	Permitido apagar mensagens do canal
CHAN_LEVEL_KICK
	Permitido usar o comando KICK
# Automatic responses
CHAN_IS_REGISTERED
	Este canal esta registado com %s.
CHAN_NOT_ALLOWED_OP
	Nao tem permissao para ser operador deste canal %s.
CHAN_MAY_NOT_BE_USED
	Este canal nao pode ser usado.
CHAN_NOT_ALLOWED_TO_JOIN
	Nao esta com permissao para permanecer neste canal.

# REGISTER responses
CHAN_REGISTER_SYNTAX
	REGISTER canal password descricao
CHAN_REGISTER_DISABLED
	Pedimos desculpa. Mas o registo de canal esta temporariamente desactivado.
CHAN_REGISTER_NOT_LOCAL
	Canais locais nao podem ser registados.
CHAN_MUST_REGISTER_NICK
	Primeiro tem de registar o seu nick.  Digite  /%s HELP  para obter 
	informacao sobre o registo de nicks.
CHAN_MUST_IDENTIFY_NICK
	Por favor, identique-se com %s primeiro utilizando o comando:
	 /%s IDENTIFY password 
CHAN_MAY_NOT_BE_REGISTERED
	O canal  %s  nao pode ser registado.
CHAN_ALREADY_REGISTERED
	O canal  %s  ja esta registado!
CHAN_MUST_BE_CHANOP
	Tem que ser operador do canal para poder registar o canal.
CHAN_REACHED_CHANNEL_LIMIT
	Pedimos desculpa. Mas ja alcancou o limite de  %d  canais.
CHAN_EXCEEDED_CHANNEL_LIMIT
	Pedimos desculpa. Mas ja ultrapassou o seu limite de  %d  canais.
CHAN_REGISTRATION_FAILED
	Pedimos desculpa. O registo falhou.
CHAN_REGISTERED
	O canal  %s  registado com o seu nick: %s
	Nao se esqueça de escolher o seu sucessor com 
	/CHANSERV SET #canal SUCCESSOR nick
CHAN_PASSWORD_IS
	A password do seu canal e  %s  - lembre-se dela para uso posterior.

# IDENTIFY responses
CHAN_IDENTIFY_SYNTAX
	IDENTIFY canal password
CHAN_IDENTIFY_FAILED
	Pedimos desculpa. A identificacao falhou.
CHAN_IDENTIFY_SUCCEEDED
	Password aceite - esta reconhecido como fundador do  %s .

# DROP responses
CHAN_DROP_SYNTAX
	DROP canal
CHAN_DROP_DISABLED
	Pedimos desculpa. O cancelamento do registo de canal esta temporariamente 
	desactivado.
CHAN_DROPPED
	O registo do canal  %s  foi apagado.

# SET responses
CHAN_SET_SYNTAX
	SET canal opcao parametros
CHAN_SET_DISABLED
	Pedimos desculpa. As opcoes do canal estao temporariamente desactivadas.
CHAN_SET_UNKNOWN_OPTION
	Opcao SET  %s  desconhecida.

# SET FOUNDER responses
CHAN_SET_FOUNDER_TOO_MANY_CHANS
	 %s  tem canais registados em excesso.
CHAN_FOUNDER_CHANGED
	Fundador do canal %s alterado para  %s .

# SET SUCCESSOR responses
CHAN_SUCCESSOR_CHANGED
	Sucessor de %s mudado para %s.
CHAN_SUCCESSOR_UNSET
	Sucessor para %s retirado.

# SET PASSWORD responses
CHAN_SET_PASSWORD_FAILED
	Pedimos desculpa. Mas nao foi possivel alterar a password.
CHAN_PASSWORD_CHANGED
	%s password alterada.
CHAN_PASSWORD_CHANGED_TO
	Password do canal %s alterada para  %s .

# SET DESC responses
CHAN_DESC_CHANGED
	Descricao do canal %s alterada para  %s .

# SET URL responses
CHAN_URL_CHANGED
	URL do canal %s alterado para  %s .
CHAN_URL_UNSET
	Associacao a URL para o canal %s foi apagada.

# SET EMAIL responses
CHAN_EMAIL_CHANGED
	Endereco de e-mail do canal %s foi mudado para  %s .
CHAN_EMAIL_UNSET
	Associacao ao e-mail do canal %s foi apagada.

# SET ENTRYMSG responses
CHAN_ENTRY_MSG_CHANGED
	Mensagem de entrada no canal %s alterada.
CHAN_ENTRY_MSG_UNSET
	A designacao actual da mensagem de entrada do canal %s foi apagada.

# SET TOPIC responses
CHAN_SET_TOPIC_FAILED
	Pedimos desculpa. Nao foi possivel por o topico escolhido.

# SET MLOCK responses
CHAN_SET_MLOCK_KEY_REQUIRED
	Parametro requerido para MLOCK +k.
CHAN_SET_MLOCK_LIMIT_REQUIRED
	Parametro requerido para MLOCK +l.
CHAN_SET_MLOCK_LIMIT_POSITIVE
	Parametro para MLOCK +l deve ser um numero positivo.
CHAN_SET_MLOCK_UNKNOWN_CHAR
	Modo  %c  e desconhecido e foi ignorado.
CHAN_MLOCK_CHANGED
	Modos do canal %s alterados para  %s .
CHAN_MLOCK_REMOVED
	Modos do canal %s removidos.

# SET KEEPTOPIC responses
CHAN_SET_KEEPTOPIC_SYNTAX
	SET canal KEEPTOPIC {ON | OFF}
CHAN_SET_KEEPTOPIC_ON
	Opcao de retencao de topico esta activada .
CHAN_SET_KEEPTOPIC_OFF
	Opcao de retencao de topico esta desactivada .

# SET TOPICLOCK responses
CHAN_SET_TOPICLOCK_SYNTAX
	SET canal TOPICLOCK {ON | OFF}
CHAN_SET_TOPICLOCK_ON
	Opcao de bloqueio do topico esta activada .
CHAN_SET_TOPICLOCK_OFF
	Opcao de bloqueio do topico esta desactivada .

# SET PRIVATE responses
CHAN_SET_PRIVATE_SYNTAX
	SET canal PRIVATE {ON | OFF}
CHAN_SET_PRIVATE_ON
	Opcao private esta activada .
CHAN_SET_PRIVATE_OFF
	Opcao private esta desactivada .

# SET SECUREOPS responses
CHAN_SET_SECUREOPS_SYNTAX
	SET canal SECUREOPS {ON | OFF}
CHAN_SET_SECUREOPS_ON
	Opcao Secure ops esta activada .
CHAN_SET_SECUREOPS_OFF
	Opcao Secure ops esta desactivada .

# SET LEAVEOPS responses
CHAN_SET_LEAVEOPS_SYNTAX
	SET canal LEAVEOPS {ON | OFF}
CHAN_SET_LEAVEOPS_ON
	Opcao LEAVE OPS esta activada.
CHAN_SET_LEAVEOPS_OFF
	Opcao LEAVE OPS esta desactivada.

# SET RESTRICTED responses
CHAN_SET_RESTRICTED_SYNTAX
	SET canal RESTRICTED {ON | OFF}
CHAN_SET_RESTRICTED_ON
	Opcao de acesso restrito esta activada .
CHAN_SET_RESTRICTED_OFF
	Opcao de acesso restrito esta desactivada .

# SET OPNOTICE responses
CHAN_SET_OPNOTICE_SYNTAX
	SET canal OPNOTICE {ON | OFF}
CHAN_SET_OPNOTICE_ON
	Opcao Op-Notice foi activada.
CHAN_SET_OPNOTICE_OFF
	Opcao Op-Notice foi desactivada.

# SET NOLINKS responses
CHAN_SET_NOLINKS_SYNTAX
	SET canal NOLINKS {ON | OFF}
CHAN_SET_NOLINKS_ON
	Opcao NOLINKS foi activada.
CHAN_SET_NOLINKS_OFF
	Opcao NOLINKS foi desactivada.

# SET NOEXPIRE responses
CHAN_SET_NOEXPIRE_SYNTAX
	SET canal NOEXPIRE {ON | OFF}
CHAN_SET_NOEXPIRE_ON
	Canal %s  nao ira expirar.
CHAN_SET_NOEXPIRE_OFF
	Canal %s  ira expirar.

# ACCESS messages
CHAN_ACCESS_SYNTAX
	ACCESS canal {ADD|DEL|LIST} [nick [nivel] | numero_de_entrada]
CHAN_ACCESS_DISABLED
	Pedimos desculpa. A modificacao da lista de acesso do canal esta 
	temporariamente desactivada.
CHAN_ACCESS_LEVEL_NONZERO
	Nivel de acesso deve ser diferente de zero.
CHAN_ACCESS_LEVEL_RANGE
	Nivel de acesso deve estar entre %d e %d.
CHAN_ACCESS_NICKS_ONLY
	Listas de acesso de canais devem conter apenas nicks registados.
CHAN_ACCESS_REACHED_LIMIT
	Pedimos desculpa. Mas so pode ter %d entradas de acesso num canal.
CHAN_ACCESS_LEVEL_UNCHANGED
	Nivel de acesso de %s no canal %s nao foi mudado de %d.
CHAN_ACCESS_LEVEL_CHANGED
	Nivel de acesso para %s no canal %s mudado de %d para %d.
CHAN_ACCESS_ADDED
	 %s  adicionado a lista de acesso do canal %s com nivel %d.
CHAN_ACCESS_NO_SUCH_ENTRY
	Entrada desconhecida (#%d) na lista de acesso do canal %s.
CHAN_ACCESS_NOT_FOUND
	 %s  nao foi encontrado na lista de acesso do canal %s.
CHAN_ACCESS_NO_MATCH
	Nenhuma entrada encontrada na lista de acesso do %s.
CHAN_ACCESS_DELETED
	 %s  apagado da lista de acesso do canal %s.
CHAN_ACCESS_DELETED_ONE
	Apagada uma entrada da lista de acesso do %s.
CHAN_ACCESS_DELETED_SEVERAL
	Apagadas %d entradas da lista de acesso do %s.
CHAN_ACCESS_LIST_EMPTY
	Lista de acesso do %s esta vazia.
CHAN_ACCESS_LIST_HEADER
	Lista de acesso do canal %s:
	  Num   Niv  Nick
CHAN_ACCESS_LIST_FORMAT
	  %3d  %4d  %s%s%s%s


# AOP/SOP error response
CHAN_NO_AOP_SOP
	Para designar privilegios de um canal para um utilizador, utilize o
	comando ACCESS; digite /%s HELP ACCESS para mais informacoes.

# AKICK responses
CHAN_AKICK_SYNTAX
	AKICK canal {ADD | DEL | LIST} [nick-ou-hostname]
CHAN_AKICK_DISABLED
	Pedimos desculpa. A alteraçao da lista de autokicks do canal esta 
	temporariamente desactivada.
CHAN_AKICK_ALREADY_EXISTS
	%s ja existe na lista de autokicks do canal %s.
CHAN_AKICK_REACHED_LIMIT
	Pedimos desculpa. Mas deve ter %d hostnames na lista de autokicks do canal.
CHAN_AKICK_ADDED
	 %s  adicionado a lista de autokicks do canal  %s.
CHAN_AKICK_NO_SUCH_ENTRY
	Entrada desconhecida (#%d) na lista de autokicks do canal %s.
CHAN_AKICK_NOT_FOUND
	 %s  nao foi encontrado na lista de autokicks do canal %s.
CHAN_AKICK_NO_MATCH
	Nenhuma entrada encontrada na lista de autokick do %s.
CHAN_AKICK_DELETED
	 %s  retirado da lista de autokicks do canal %s.
CHAN_AKICK_DELETED_ONE
	Apagada uma entrada da lista de autokick do %s.
CHAN_AKICK_DELETED_SEVERAL
	Apagada %d entradas da lista de autokick do %s.
CHAN_AKICK_LIST_EMPTY
	Lista de autokick do %s esta vazia.
CHAN_AKICK_LIST_HEADER
	Lista de autokicks do canal %s:
CHAN_AKICK_LIST_FORMAT
	  %3d %s%s
CHAN_AKICK_LIST_FORMAT2
	  %3d %s por %s : %s

# LEVELS responses
CHAN_LEVELS_SYNTAX
	LEVELS canal {SET | DIS[ABLE] | LIST | RESET} [item [nivel]]
CHAN_LEVELS_RANGE
	Nivel deve estar entre %d e %d.
CHAN_LEVELS_CHANGED
	Nivel de  %s  no canal %s alterado para  %d .
CHAN_LEVELS_UNKNOWN
	Opcao  %s  desconhecida. Digite   /%s HELP LEVELS DESC  para uma lista 
	valida de opcoes.
CHAN_LEVELS_DISABLED
	 %s  desabilitado no canal %s.
CHAN_LEVELS_LIST_HEADER
	Configuracao dos niveis de acesso do canal %s:
CHAN_LEVELS_LIST_DISABLED
	    %-*s  (desabilitado)
CHAN_LEVELS_LIST_FOUNDER
	    %-*s  (somente fundador)
CHAN_LEVELS_LIST_NORMAL
	    %-*s  %d
CHAN_LEVELS_RESET
	Niveis de acesso do canal  %s  foram refeitos usando os padroes.

# INFO responses
CHAN_INFO_SYNTAX
	INFO canal
CHAN_INFO_HEADER
	Informacao sobre o canal  %s :
CHAN_INFO_FOUNDER
	           Fundador: %s (%s)
CHAN_INFO_NO_FOUNDER
	           Fundador: %s
CHAN_INFO_DESCRIPTION
	          Descricao: %s
CHAN_INFO_TIME_REGGED
	          Registado: %s [%s]
CHAN_INFO_LAST_USED
	         Ultima utilizacao: %s [%s]
CHAN_INFO_LAST_TOPIC
	      Ultimo topico: %s
CHAN_INFO_TOPIC_SET_BY
	Topico inserido por: %s
CHAN_INFO_RECORD
	            Recorde: %d utilizador(es) em %s [%s]
CHAN_INFO_USERS
	    Ocupacao actual: %d utilizador(es)
CHAN_INFO_URL
	                URL: %s
CHAN_INFO_EMAIL
	             E-mail: %s
CHAN_INFO_OPTIONS
	             Opcoes: %s
CHAN_INFO_NO_EXPIRE
	   Canc. do registo: nunca
CHAN_INFO_OPT_PRIVATE
	Privado
CHAN_INFO_OPT_KEEPTOPIC
	Retencao de topico
CHAN_INFO_OPT_TOPICLOCK
	Bloqueamento do topico
CHAN_INFO_OPT_SECUREOPS
	Proteccao de ops
CHAN_INFO_OPT_LEAVEOPS
	LEAVE OPS
CHAN_INFO_OPT_RESTRICTED
	Acesso restrito
CHAN_INFO_OPT_NOLINKS
	Ignorar nick links
CHAN_INFO_OPT_NONE
	Nenhuma
CHAN_INFO_MODE_LOCK
	          Bloqueio dos modos: %s

# LIST responses
CHAN_LIST_SYNTAX
	LIST padrao
CHAN_LIST_HEADER
	Listas das entradas que satisfazem  %s :
CHAN_LIST_FORMAT
	    %-20s  %s
CHAN_LIST_END
	Fim da listagem - %d/%d entradas mostradas.

# INVITE responses
CHAN_INVITE_SYNTAX
	INVITE canal

# OP responses
CHAN_OP_SYNTAX
	OP canal nick

# DEOP responses
CHAN_DEOP_SYNTAX
	DEOP canal nick

# KICK responses
CHAN_KICK_SYNTAX
	KICK canal nick

# UNBAN responses
CHAN_UNBAN_SYNTAX
	UNBAN canal
CHAN_UNBANNED
	Foi desbanido do canal  %s .

# CLEAR responses
CHAN_CLEAR_SYNTAX
	CLEAR canal tipo
CHAN_CLEARED_BANS
	Todos os bans do canal %s foram removidos.
CHAN_CLEARED_MODES
	Todos os modos do canal %s foram removidos.
CHAN_CLEARED_OPS
	Modo +o dos Operadores do canal %s foi retirado.
CHAN_CLEARED_VOICES
	Modo +v dos utilizadores do canal %s foi retirado.
CHAN_CLEARED_USERS
	Todos os utilizadores foram kickados do canal %s.

# GETPASS responses
CHAN_GETPASS_SYNTAX
	GETPASS canal
CHAN_GETPASS_UNAVAILABLE
	Comando GETPASS nao esta disponivel porque a encriptacao esta em uso.
CHAN_GETPASS_PASSWORD_IS
	password do canal %s e  %s .

# FORBID responses
CHAN_FORBID_SYNTAX
	FORBID canal
CHAN_FORBID_SUCCEEDED
	Canal  %s  esta proibido de ser utilizado.
CHAN_FORBID_FAILED
	Nao foi possivel proibir o canal  %s !

###########################################################################
#
# Mensagens do MemoServ
#
###########################################################################

# Automatic messages
MEMO_HAVE_NEW_MEMO
	Tem uma mensagem nova.
MEMO_HAVE_NEW_MEMOS
	Tem %d mensagens novas.
MEMO_TYPE_READ_LAST
	Digite  /%s READ LAST  para ler.
MEMO_TYPE_READ_NUM
	Digite  /%s READ %d  para ler.
MEMO_TYPE_LIST_NEW
	Digite  /%s LIST NEW  para listar todas as mensagens.
MEMO_AT_LIMIT
	 Atencao:  Atingiu o limite maximo de mensagens (%d).
	Nao podera receber mais nenhuma mensagem antes de apagar alguma das suas 
	actuais.
MEMO_OVER_LIMIT
	 Atencao:  Esta acima do limite maximo de mensagens (%d).
	Nao podera receber mais nenhuma mensagem antes de apagar alguma das suas 
	actuais.
MEMO_NEW_MEMO_ARRIVED
	Tem uma nova mensagem de %s.
	Digite  /%s READ %d  para ler.

# Multi-use responses
MEMO_HAVE_NO_MEMOS
	Nao tem mensagens.
MEMO_X_HAS_NO_MEMOS
	%s nao tem mensagens.
MEMO_DOES_NOT_EXIST
	Mensagem %d nao existe!
MEMO_LIST_NOT_FOUND
	Nenhuma mensagem encontrada.

# SEND responses
MEMO_SEND_SYNTAX
	SEND {nick | canal} mensagem-texto
MEMO_SEND_DISABLED
	Pedimos desculpa. O envio de mensagens temporariamente desactivado.
MEMO_SEND_PLEASE_WAIT
	Por favor espere %d segundos antes de usar o comando SEND novamente.
MEMO_X_GETS_NO_MEMOS
	%s nao pode receber mensagens.
MEMO_X_HAS_TOO_MANY_MEMOS
	%s actualmente tem muitas mensagens e nao pode receber mais.
MEMO_SENT
	Mensagem enviada para %s.

# LIST responses
MEMO_LIST_SYNTAX
	LIST [canal] [list | NEW]
MEMO_HAVE_NO_NEW_MEMOS
	Nao tem novas mensagens.
MEMO_X_HAS_NO_NEW_MEMOS
	%s nao tem novas mensagens.
MEMO_LIST_MEMOS
	Mensagens para %s.  Para ler, digite:  /%s READ numero 
MEMO_LIST_NEW_MEMOS
	Novas mensagens para %s. Para ler, digite:  /%s READ numero 
MEMO_LIST_CHAN_MEMOS
	Mensagens para o canal %s.  Para ler, digite:   /%s READ %s numero
MEMO_LIST_CHAN_NEW_MEMOS
	Novas mensagens para o canal %s.  Para ler, digite:  /%s READ %s numero
MEMO_LIST_HEADER
	 Num  Remetente         Data/Hora
MEMO_LIST_FORMAT
	%c%3d  %-16s  %s "%s..."

# READ responses
MEMO_READ_SYNTAX
	READ [canal] {list | LAST | NEW}
MEMO_HEADER
	Mensagem %d de %s (%s).  Para apagar, digite:  /%s DEL %d 
MEMO_CHAN_HEADER
	Mensagem %d de %s (%s).  Para apagar, digite:  /%s DEL %s %d 
MEMO_TEXT
	%s

# DEL responses
MEMO_DEL_SYNTAX
	DEL [canal] {num | list | ALL}
MEMO_DELETED_NONE
	Sem mensagens a serem apagadas.
MEMO_DELETED_ONE
	Mensagem %d foi apagada.
MEMO_DELETED_SEVERAL
	%s mensagens foram apagadas.
MEMO_DELETED_ALL
	Todas as suas mensagens foram apagadas.

# SET responses
MEMO_SET_SYNTAX
	SET opcao parametros
MEMO_SET_DISABLED
	Pedimos desculpa. O sistema de mensagens esta temporariamente desactivado.
MEMO_SET_UNKNOWN_OPTION
	Opcao SET  %s  desconhecida.

# SET NOTIFY responses
MEMO_SET_NOTIFY_SYNTAX
	SET NOTIFY {ON | LOGON | NEW | OFF}
MEMO_SET_NOTIFY_ON
	%s notificara sobre mensagens quando se conectar e quando enviadas 
	voce.
MEMO_SET_NOTIFY_LOGON
	%s notificara sobre as suas mensagens quando se conectar ou sair de um 
	/AWAY.
MEMO_SET_NOTIFY_NEW
	%s notificara sobre as suas mensagens quando elas lhe forem enviadas.
MEMO_SET_NOTIFY_OFF
	%s nao notificara sobre qualquer aviso de mensagens.

# SET LIMIT responses
MEMO_SET_LIMIT_SYNTAX
	SET LIMIT [canal] limite
MEMO_SET_LIMIT_SERVADMIN_SYNTAX
	SET LIMIT [usuario | canal] {limit | NONE} [HARD]
MEMO_SET_YOUR_LIMIT_FORBIDDEN
	Nao esta apto a alterar o limite de mensagens.
MEMO_SET_LIMIT_FORBIDDEN
	O limite de mensagens para %s nao pode ser alterado.
MEMO_SET_YOUR_LIMIT_TOO_HIGH
	Nao pode alterar o seu limite de mensagens acima de %d.
MEMO_SET_LIMIT_TOO_HIGH
	Nao pode alterar o limite de mensagens de %s acima de %d.
MEMO_SET_LIMIT_OVERFLOW
	Limite de mensagens muito alto; limitado para %d.
MEMO_SET_YOUR_LIMIT
	O limite de mensagens foi alterado para  %d .
MEMO_SET_YOUR_LIMIT_ZERO
	Nao esta apto a receber mensagens.
MEMO_UNSET_YOUR_LIMIT
	O limite de mensagens foi desactivado.
MEMO_SET_LIMIT
	Limite de mensagens para %s alterado para  %d .
MEMO_SET_LIMIT_ZERO
	Limite de mensagens para %s alterado para  0 .
MEMO_UNSET_LIMIT
	Limite de mensagens para %s esta desactivado .

# INFO responses
MEMO_INFO_SYNTAX
	INFO [canal]
MEMO_INFO_SERVADMIN_SYNTAX
	INFO [nick | canal]
MEMO_INFO_NO_MEMOS
	Nao tem mensagens.
MEMO_INFO_MEMO
	Tem  uma  mensagem.
MEMO_INFO_MEMO_UNREAD
	Actualmente tem uma mensagem, que ainda nao foi lida.
MEMO_INFO_MEMOS
	Actualmente tem  %d  mensagens.
MEMO_INFO_MEMOS_ONE_UNREAD
	Actualmente tem  %d  mensagens, das quais uma nao foi lida.
MEMO_INFO_MEMOS_SOME_UNREAD
	Actualmente tem  %d  mensagens, das quais  %d  nao foram lidas.
MEMO_INFO_MEMOS_ALL_UNREAD
	Tem  %d  mensagens; nenhuma lida.
MEMO_INFO_LIMIT
	O seu limite de mensagens e  %d .
MEMO_INFO_HARD_LIMIT
	O seu limite de mensagens e  %d , e nao pode ser mudado.
MEMO_INFO_LIMIT_ZERO
	O seu limite de mensagens e  0 ; nao pode receber nenhuma mensagem.
MEMO_INFO_HARD_LIMIT_ZERO
	O seu limite de mensagens e  0 ; nao pode receber nenhuma mensagem, e nao 
	pode mudar este limite.
MEMO_INFO_NO_LIMIT
	Nao tem limite para as mensagens que podera possuir.
MEMO_INFO_X_NO_MEMOS
	 %s  nao tem mensagens.
MEMO_INFO_X_MEMO
	%s tem actualmente uma mensagem.
MEMO_INFO_X_MEMO_UNREAD
	%s tem actualmente uma mensagem, ainda nao lida.
MEMO_INFO_X_MEMOS
	%s tem actualmente  %d  mensagens.
MEMO_INFO_X_MEMOS_ONE_UNREAD
	%s tem actualmente  %d  mensagens,  uma  nao lida.
MEMO_INFO_X_MEMOS_SOME_UNREAD
	%s tem actualmente  %d  mensagens,  %d  nao lidas.
MEMO_INFO_X_MEMOS_ALL_UNREAD
	%s tem actualmente  %d  mensagens; nenhuma lida.
MEMO_INFO_X_LIMIT
	O limite de mensagens de %s e  %d .
MEMO_INFO_X_HARD_LIMIT
	O limite de mensagens de %s e  %d e não pode ser mudado.
MEMO_INFO_X_NO_LIMIT
	%s nao tem limite de mensagens.

###########################################################################
#
# Mensagens do OperServ
#
###########################################################################

# General messages
OPER_BOUNCY_MODES
	Services nao estao a conseguir mudar modos.
	Servidores estao configurados correctamente?
OPER_BOUNCY_MODES_U_LINE
	Services nao estao a conseguir mudar modos.
	As U:lines dos seus servidores estao configuradas corretamente?

# GLOBAL responses
OPER_GLOBAL_SYNTAX
	GLOBAL mensagem

# STATS responses
OPER_STATS_UNKNOWN_OPTION
	Opcao STATS %s desconhecida.
OPER_STATS_CURRENT_USERS
	Utilizadores actuais  :  %d  (%d  ops, %d helpers, %d bots)
OPER_STATS_MAX_USERS
	Maximo de utilizadores:  %d
# This is ugly, but at least it's language-portable...
OPER_STATS_UPTIME_DHMS
	Services activos a  %d  dias,  %02d:%02d
OPER_STATS_UPTIME_1DHMS
	Services activos a  %d  dia,  %02d:%02d
OPER_STATS_UPTIME_HMS
	Services activos a  %d  horas,  %d  minutos
OPER_STATS_UPTIME_HM1S
	Services activos a  %d  horas,  %d  minutos
OPER_STATS_UPTIME_H1MS
	Services activos a  %d  horas,  %d  minuto
OPER_STATS_UPTIME_H1M1S
	Services activos a  %d  horas,  %d  minuto
OPER_STATS_UPTIME_1HMS
	Services activos a  %d  hora,  %d  minutos
OPER_STATS_UPTIME_1HM1S
	Services activos a  %d  hora,  %d  minutos
OPER_STATS_UPTIME_1H1MS
	Services activos a  %d  hora,  %d  minuto
OPER_STATS_UPTIME_1H1M1S
	Services activos a  %d  hora,  %d  minuto
OPER_STATS_UPTIME_MS
	Services activos a  %d  minutos,  %d  segundos
OPER_STATS_UPTIME_M1S
	Services activos a  %d  minutos,  %d  segundo
OPER_STATS_UPTIME_1MS
	Services activos a  %d  minuto,  %d  segundos
OPER_STATS_UPTIME_1M1S
	Services activos a  %d  minuto,  %d  segundo
OPER_STATS_USER_MEM
	Utilizadores :  %6d  registos,  %5d  kB
OPER_STATS_CHANNEL_MEM
	Canal   :  %6d  registos,  %5d  kB
OPER_STATS_NICKSERV_MEM
	NickServ:  %6d  registos,  %5d  kB
OPER_STATS_CHANSERV_MEM
	ChanServ:  %6d  registos,  %5d  kB
OPER_STATS_OPERSERV_MEM
	OperServ:  %6d  registos,  %5d  kB
OPER_STATS_AKILL_COUNT
	Numero actual de AKILLs:  %d 
OPER_STATS_AKILL_EXPIRE_DAYS
	Tempo default para expirar AKILL:  %d dias 
OPER_STATS_AKILL_EXPIRE_DAY
	Tempo default para expirar AKILL:  1 dia 
OPER_STATS_AKILL_EXPIRE_HOURS
	Tempo default para expirar AKILL:  %d horas 
OPER_STATS_AKILL_EXPIRE_HOUR
	Tempo default para expirar AKILL:  1 hora 
OPER_STATS_AKILL_EXPIRE_MINS
	Tempo default para expirar AKILL:  %d minutos 
OPER_STATS_AKILL_EXPIRE_MIN
	Tempo default para expirar AKILL:  1 minuto 
OPER_STATS_AKILL_EXPIRE_NONE
	Tempo default para expirar AKILL:  nao expira 

# ADMIN responses
OPER_ADMIN_SYNTAX
	ADMIN {ADD | DEL | LIST} [nick]
OPER_ADMIN_ADD_SYNTAX
	ADMIN ADD nick
OPER_ADMIN_DEL_SYNTAX
	ADMIN DEL nick
OPER_ADMIN_SKELETON
	Services estam no modo skeleton; o comando ADMIN nao esta disponivel.
OPER_ADMIN_EXISTS
	 %s  ja esta na lista de Administradores dos Services.
OPER_ADMIN_ADDED
	 %s  adicionado a lista de Administradores dos Services.
OPER_ADMIN_TOO_MANY
	Muitas entradas (%d) na lista dos Administradores dos Services e impossivel 
	adicionar mais.
OPER_ADMIN_REMOVED
	 %s  foi removido da lista dos Administradores dos Services.
OPER_ADMIN_NOT_FOUND
	 %s  nao foi encontrado na lista dos Administradores dos Services.
OPER_ADMIN_LIST_HEADER
	Lista de Administradores dos Services:

# OPER responses
OPER_OPER_SYNTAX
	OPER {ADD | DEL | LIST} [nick]
OPER_OPER_ADD_SYNTAX
	OPER ADD nick
OPER_OPER_DEL_SYNTAX
	OPER DEL nick
OPER_OPER_SKELETON
	Services estao no modo skeleton, o comando OPER nao esta disponivel.
OPER_OPER_EXISTS
	 %s  ja existe na lista dos Operadores dos Services.
OPER_OPER_ADDED
	 %s  adicionado a lista de Operadores dos Services.
OPER_OPER_TOO_MANY
	Muitas entradas (%d) na lista dos Operadores dos Services e impossivel 
	adicionar mais.
OPER_OPER_REMOVED
	 %s  removido da lista de Operadores dos Services.
OPER_OPER_NOT_FOUND
	 %s  nao encontrado na lista de Operadores dos Services.
OPER_OPER_LIST_HEADER
	Lista de Operadores dos Services:

# MODE responses
OPER_MODE_SYNTAX
	MODE canal modos

# CLEARMODES responses
OPER_CLEARMODES_SYNTAX
	CLEARMODES canal [ALL]
OPER_CLEARMODES_DONE
	Bans e modos binarios do canal  %s  foram limpos.
OPER_CLEARMODES_ALL_DONE
	Todos os modos do canal  %s  foram limpos.

# KICK responses
OPER_KICK_SYNTAX
	KICK canal utilizador razao

# AKILL responses
OPER_AKILL_SYNTAX
	AKILL {ADD | DEL | LIST | VIEW} [[+tempo] hostname [razao]]
OPER_AKILL_ADD_SYNTAX
	AKILL ADD [+tempo] hostname razao
OPER_AKILL_DEL_SYNTAX
	AKILL DEL hostname
OPER_AKILL_NO_NICK
	 Lembre-se : hostnames de AKILL nao podem conter nicks;
	tenha a certeza que  nao  incluiu uma porcao do nick no hostname.
OPER_TOO_MANY_AKILLS
	Lista de AKILL esta cheia!
OPER_AKILL_ADDED
	 %s  adicionado na lista de AKILL.
OPER_AKILL_REMOVED
	 %s  removido da lista de AKILL.
OPER_AKILL_NOT_FOUND
	 %s  nao encontrado na lista de AKILL.
OPER_AKILL_LIST_HEADER
	Lista de AKILL actual:
# mask, reason
OPER_AKILL_LIST_FORMAT
	%-32s  %s
# mask, set-by, set-time, expires, reason
OPER_AKILL_VIEW_FORMAT
	%s (pelo %s em %s; %s)
	    %s
OPER_AKILL_NO_EXPIRE
	nao expira
OPER_AKILL_EXPIRES_SOON
	expira na proxima actualizacao do banco de dados
OPER_AKILL_EXPIRES_M
	expira em %d minutos
OPER_AKILL_EXPIRES_1M
	expira em %d minuto
OPER_AKILL_EXPIRES_HM
	expira em %d horas, %d minutos
OPER_AKILL_EXPIRES_H1M
	expira em %d horas, %d minuto
OPER_AKILL_EXPIRES_1HM
	expira em %d hora, %d minutos
OPER_AKILL_EXPIRES_1H1M
	expira em %d hora, %d minuto
OPER_AKILL_EXPIRES_D
	expira em %d dias
OPER_AKILL_EXPIRES_1D
	expira em %d dia

# SET responses
OPER_SET_SYNTAX
	SET opcao selecao
OPER_SET_IGNORE_ON
	Ignore code sera usado.
OPER_SET_IGNORE_OFF
	Ignore code nao sera usado.
OPER_SET_IGNORE_ERROR
	Parametro para IGNORE deve ser ON ou OFF .
OPER_SET_READONLY_ON
	Services estao agora no modo read-only .
OPER_SET_READONLY_OFF
	Services agora estao no modo leitura-escrita (read-write).
OPER_SET_READONLY_ERROR
	Parametro para READONLY deve ser ON ou OFF .
OPER_SET_DEBUG_ON
	Services estao agora no modo de debug .
OPER_SET_DEBUG_OFF
	Services estao no modo de non-debug .
OPER_SET_DEBUG_LEVEL
	Services estao no modo de debug (nivel %d).
OPER_SET_DEBUG_ERROR
	Parametro para  DEBUG deve ser  ON ,  OFF  ou um numero positivo.
OPER_SET_UNKNOWN_OPTION
	Opcao  %s  desconhecida.

# JUPE responses
OPER_JUPE_SYNTAX
	JUPE nome-do-servidor [razao]

# RAW responses
OPER_RAW_SYNTAX
	RAW texto

# UPDATE responses
OPER_UPDATING
	Actualizando banco de dados.

# RESTART responses
OPER_CANNOT_RESTART
	SERVICES_BIN nao definido, nao e possivel reiniciar.
	Execute novamente o script \2configure\2 e recompile os Services para 
	habilitar o comando RESTART.

# LISTIGNORE responses
OPER_IGNORE_LIST
	Lista de ignore dos Services:
OPER_IGNORE_LIST_EMPTY
	Lista de ignore esta vazia.

###########################################################################
#
# News system messages
#
###########################################################################

NEWS_LOGON_TEXT
	[Logon News - %s] %s
NEWS_OPER_TEXT
	[Oper News - %s] %s
NEWS_LOGON_SYNTAX
	LOGONNEWS {ADD|DEL|LIST} [texto|numero]
NEWS_LOGON_LIST_HEADER
	Mensagens de entrada:
NEWS_LOGON_LIST_ENTRY
	%5d (%s por %s)
	    %s
NEWS_LOGON_LIST_NONE
	Nao existe nenhuma mensagem de entrada.
NEWS_LOGON_ADD_SYNTAX
	LOGONNEWS ADD texto
NEWS_LOGON_ADD_FULL
	Lista de mensagens esta cheia!
NEWS_LOGON_ADDED
	Adicionada nova mensagem de entrada (#%d).
NEWS_LOGON_DEL_SYNTAX
	LOGONNEWS DEL {numero | ALL}
NEWS_LOGON_DEL_NOT_FOUND
	Mensagem de entrada numero %d nao encontrada!
NEWS_LOGON_DELETED
	Mensagem de entrada numero %d apagada.
NEWS_LOGON_DEL_NONE
	Nao ha mensagem de entrada para apagar!
NEWS_LOGON_DELETED_ALL
	Todas as mensagens de entrada apagadas.

NEWS_OPER_SYNTAX
	OPERNEWS {ADD|DEL|LIST} [texto|numero]
NEWS_OPER_LIST_HEADER
	Oper news itens:
NEWS_OPER_LIST_ENTRY
	%5d (%s por %s)
	    %s
NEWS_OPER_LIST_NONE
	Nao ha oper news.
NEWS_OPER_ADD_SYNTAX
	OPERNEWS ADD texto
NEWS_OPER_ADD_FULL
	Lista de oper news esta cheia!
NEWS_OPER_ADDED
	Adicionada nova oper news (#%d).
NEWS_OPER_DEL_SYNTAX
	OPERNEWS DEL {numero | ALL}
NEWS_OPER_DEL_NOT_FOUND
	Oper news numero %d nao encontrada!
NEWS_OPER_DELETED
	Oper news numero %d apagada.
NEWS_OPER_DEL_NONE
	Nao ha oper news para apagar!
NEWS_OPER_DELETED_ALL
	Todas as oper news foram apagadas.

NEWS_HELP_LOGON
	Sintaxe:  LOGONNEWS ADD texto 
	          LOGONNEWS DEL {numero | ALL} 
	          LOGONNEWS LIST 
	
	Edita ou mostra a lista de logon news. Quando um utilizador
	se liga a rede, estas mensagens sao enviadas para o mesmo.
	(No entanto, nao mais que tres mensagens serao enviadas
	simultaneamente para evitar flood. Se houver mais que tres
	mensagens novas, apenas essas mais novas serao mostradas.)
	
	LOGONNEWS LIST pode ser usado por qualquer IRC operator
	para listar as mensagens actuais. ADD e DEL so podem
	ser usados pelos Administradores dos Services.

NEWS_HELP_OPER
	Sintaxe:  OPERNEWS ADD texto 
	          OPERNEWS DEL {numero | ALL} 
	          OPERNEWS LIST 

	Edita ou mostra a lista de oper news. Quando um user
	se torna operador (pelo comando /OPER), estas mensagens
	serao enviadas. (No entanto, nao mais que tres
	mensagens serao enviadas simultaneamente para evitar
	flood. Se houver mais que tres mensagens novas, apenas
	as tres mais novas serao mostradas.)
	
	OPERNEWS LIST pode ser usado por qualquer IRC operator
	para listar as oper news. ADD e DEL so podem ser usados
	pelos Administradores dos Services.

###########################################################################
#
# Mensagens de help do NickServ
#
###########################################################################

NICK_HELP
	 %S  permite que "registe" um nick evitando que
	outras pessoas o utilizem.  Se o nick nao for usado por %d
	dias, o registo sera removido.  Os seguintes comandos
	permitem o registo e a manutencao dos nicks, para
	utiliza-los, digite  /%S comando. Para mais informacoes
	sobre um comando, digite  /%S HELP comando.
	
	    AJOIN      Modifica a lista de canais com entrada automatica
	    REGISTER   Regista um nick
	    IDENTIFY   Identifica o seu nick com a sua password
	    LINK       Faz uma ligacao do seu nick com outro
	    SET        Altera opcoes do seu nick
	    DROP       Cancela o registo de um nick
	    LISTLINKS  Lista os nicks ligados ao seu nick
	    NOTES      Permite guardar anotacoes
	    GHOST      Cancela uma ligacao do nick
	
	Outros comandos: UNLINK, INFO, LIST, STATUS
	
	NOTA: Este servico tem a intencao de proporcionar um modo para
	que os utilizadores desta rede nao tenham a identidade comprometida.
	Isto NAO tem como fim facilitar o "roubo" dos nicks ou
	outras atitudes mas intencionadas.  O abuso do %S
	resultara em, no minimo, perda do(s) nick(s) abusivo(s).
	
NICK_HELP_EXPIRE_ZERO
	%S permite "registar" um nick e impede que
	outros o utilizem. Os comandos seguintes permitem o
	registo e a manutencao dos nicks, para usa-los, digite
	/%S comando. Para mais informacoes sobre um
	comando especifico, digite /%S HELP comando.
	
	   REGISTER  Regista um nick
	   IDENTIFY  Identifica o seu nick com a sua password
	   LINK      Faz uma ligacao do seu nick com outro
	   SET       Altera opcoes do seu nick
	   DROP      Cancela o registo de um nick
	
	Outros comandos: UNLINK, GHOST, INFO, LIST, STATUS
	
	NOTA: Este servico tem a intencao de proporcionar um modo para que
	os utilizadores desta rede nao tenham a sua identidade comprometida.
	Isto NAO tem como fim facilitar o "roubo" dos nicks ou
	outras atitudes mas intencionadas. O abuso do %S resultara
	em, no minimo, perda do(s) nick(s) abusivos.

NICK_HELP_REGISTER
	Sintaxe:  REGISTER password email
	
	Regista o nick no banco de dados do %S.  
	Se nao possuir uma conta de email indique NOMAIL como email.
	Depois de ter o nick registado, pode usar o comando
	 SET para configurar as opcoes do seu nick como 
	preferir. Certifique-se que guarda a sua password durante
	o registo, precisara dela para fazer alteracoes no 
	nick futuramente.  (Lembre-se que  maiusculas diferem : FIDO,
	Fido, e fido sao passwords diferentes!)
	
	Sugestoes ao escolher sua password:
	
	As passwords nao devem ser de facil acesso aleatorio. Por exemplo,
	usar o nome como password e uma pessima ideia.  Utilizar o 
	nick como password e ainda uma ideia muito pior e, de facto, o %S
	nao permitira isso.  Da mesma maneira, passwords curtas sao
	vulneraveis a testes de brute-force, deve
	escolher uma password com pelo menos 5 caracteres.  Finalmente,
	o caracter "ESPACO" nao pode ser usado em passwords.

NICK_HELP_IDENTIFY
	Sintaxe:  IDENTIFY password 
	
	Diz ao %S que realmente e o dono do nick.
	Muitos comandos exigem que se identifique com este
	comando antes de os pode usar.  A password e a mesma que
	enviou com o comando REGISTER.
	
NICK_HELP_DROP
	Sintaxe:  DROP 
	
	Retira o seu nick do banco de dados do %S.  O nick que
	foi retirado esta livre para qualquer pessoa registar
	novamente.
	
	Para utilizar este comando, tem que se identificar 
	com a password primeiro ( /%S HELP IDENTIFY  para mais
	informacoes).

NICK_HELP_LINK
	Sintaxe: LINK nick password 
	
	Liga o seu nick a outro, efectivamente, fazendo uma ligacao
	do nick actual com um outro nick especificado. Quando
	emite este comando, a lista de acesso do seu nick
	actualmente em uso e apagada e substituida pelo nick a
	que esta a ligar-se, todos  os  memos  do nick actual sao
	adicionados na lista de memos do nick alvo (isso pode
	causar um excesso no limite de memos do nick, em alguns
	casos vai precisar de apagar alguns memos antes de poder
	receber mais de outra pessoa).
	
	Uma vez que a ligacao seja estabilizada, o seu nick sera
	transparentemente convertido para o nick alvo em todos
	os lugares dos Services, excepto para os comandos %S
	 UNLINK  e  DROP .
	Por exemplo, pode usar um nick ou outro para ler
	o mesmo conjunto de memos (e mensagens enviadas para um nick
	ou outro irao para a mesma lista).  Se se identificar
	para um nick, estara automaticamente identificado para o
	outro.  Se um nick ou outro esta na lista de acesso de um
	canal, ambos os nicks terao os mesmos privilegios de acesso.
	
	Para usar este comando, deve identificar o nick actual
	(usando o comando  IDENTIFY ), e deve fornecer a
	password para o nick que deseja linkar.

NICK_HELP_UNLINK
	Sintaxe:  UNLINK [nick password] 
	
	Remove a ligacao com outro nick.  Quando uma ligacao e
	removida, os modos de um nick e a lista de acesso do nick
	previamente ligado sao copiados para o nick actual e podem
	ser independetemente alterados. As suas mensagens nao sao
	copiadas, todas as mensagens permanecerao armazenadas no
	nick anteriormente ligado.
	
	Informando nick e password como parametros, pode desligar o seu
	nick do nick especificado.

NICK_HELP_SET
	Sintaxe:  SET opcao parametros 
	
	Altera varias opcoes do nick.  A  opcao  pode ser:
	
	    PASSWORD   Altera a password do seu nick
	    LANGUAGE   Altera a linguagem dos Services quando
	                  lhe sao enviadas mensagens
	    URL        Associa um endereco URL ao seu nick
	    EMAIL      Associa um endereco de e-mail ao seu nick
	    LOCATION   Associa um local ao seu nick.
	    ICQNUMBER  Associa um numero ICQ ao seu nick.
	    KILL       Esta proteccao e agora obrigatoria, nao sendo
	               por isso configuravel.
	    PRIVATE    Previne o seu nick de aparecer num  /%S LIST 
	    HIDE       Esconde certas informacoes sobre o seu nick
	    NEWSLETTER Activa/desactiva recepção de newsletter
	
	Para usar este comando, deve primeiro estar identificado
	com a sua password ( /%S HELP IDENTIFY  para mais
	informacoes).
	
	Digite  /%S HELP SET opcao para mais informacoes
	sobre um comando especifico.

NICK_HELP_SET_PASSWORD
	Sintaxe:  SET PASSWORD nova-password 
	
	Muda a password que e utilizada para identificar o dono do
	nick.

NICK_HELP_SET_LANGUAGE
	Sintaxe:  SET LANGUAGE numero 
	
	Muda a linguagem que os Services usam ao enviar mensagens
	(por exemplo, quando responde a um comando que 
	emite). O numero deve ser escolhido da seguinte lista
	de linguas de apoio.
	

NICK_HELP_SET_URL
	Sintaxe:  SET URL url 
	
	Associa um dado URL ao seu nick. Este URL sera mostrado
	sempre que alguem solicitar informacoes sobre o seu nick
	atraves do comando INFO.

NICK_HELP_SET_EMAIL
	Sintaxe:  SET EMAIL endereco 
	
	Associa um endereco de e-mail ao seu nick.  Este
	endereco sera sempre mostrado quando alguem solicitar
	informacao sobre o seu nick atraves do comando INFO.

NICK_HELP_SET_KILL
	Sintaxe:  SET KILL {} 
	
	Possibilita a proteccao de KILL no seu nick.  Com a proteccao
	de KILL accionada, se outro utilizador tentar usar o seu nick,
	sera dado 1 minuto para que este o mude, apos isso, sera
	forcadamente removido do IRC pelo %S.
	
	NOTA:
	Esta proteccao e agora obrigatoria, nao sendo por isso configuravel.

NICK_HELP_SET_SECURE
	Sintaxe:  SET SECURE {ON | OFF} 
	
	Torna os recursos de seguranca do %S activos (ON) ou
	desactivos (OFF) sobre um nick. Com o  SECURE  accionado,
	deve entrar com a sua password antes de ser reconhecido
	como utilizador do nick, independentemente do facto do 
	endereco constar na lista de acesso.  Entretanto, se
	esta na lista de acesso, o %S nao ira dar auto-kill
	de acordo com os ajustes da opcao  KILL .

NICK_HELP_SET_PRIVATE
	Sintaxe:  SET PRIVATE {ON | OFF} 
	
	Torna a opcao de privacidade do %S sobre o seu nick
	activa (ON) ou desactiva (OFF).  Com PRIVATE acionado,
	o seu nick nao aparecera nas listagens de nicks geradas com
	o comando  %S LIST . (Entretando, alguem que saiba o seu
	nick ainda pode obter informacoes utilizando o comando INFO ).

NICK_HELP_SET_HIDE
	Sintaxe:  SET HIDE {EMAIL | QUIT} {ON | OFF} 
	
	Permite que previnir que certas informacoes sejam mostradas
	quando alguem faz um INFO ao seu nick.  Pode esconder
	o endereco de e-mail (EMAIL), e a ultima mensagem de saida
	(QUIT). O segundo parametro especifica quando a informacao
	deve ser ou nao mostrada (OFF) (ON).

NICK_HELP_GHOST
	Sintaxe:  GHOST nick [password] 
	
	Elimina uma sessao "fantasma" de IRC que esteja utilizando o seu
	nick. A sessao "fantasma" e aquela que nao esta realmente
	conectada, mas que o servidor de IRC acredita estar ainda
	activa por qualquer razao. Isso acontece normalmente quando o
	computador crasha ou se a sua ligaçao Internet ou modem cair
	por um periodo curto de tempo enquanto estiver no IRC.
	
	Para usar o comando GHOST  num nick, o seu endereco actual
	como mostrado no /WHOIS deve pertencer a lista de acesso do
	nick, ou deve fornecer a password correcta para o nick.

NICK_HELP_INFO
	Sintaxe:  INFO nick 
	
	Mostra a informacao sobre o nick dado, como, o dono do nick,
	ultimo endereco utilizado, tempo e opcoes.

NICK_HELP_LIST
	Sintaxe:  LIST padrao 
	
	Lista todos os nicks registados que combinam com o padrao
	fornecido no formato nick!ident@host.  Nicks com a opcao
	 PRIVATE  ligada nao serao mostrados.
		
	Exemplos:
	
	     LIST *!bond@*.meuip.pt 
	        Lista todos os nicks de bond@*.meuip.pt.
	
	     LIST *Bot*!*@* 
	        Lista todos os nicks registados com  Bot  nos seus nomes.
	        	
	     LIST *!*@*.meuip.pt 
	        Lista todos os nicks do dominio meuip.pt.
	
NICK_HELP_STATUS
	Sintaxe:  STATUS nick 
	
	Retorna se o utilizador que esta a utilizar um determinado nick
	e reconhecido como dono do nick.  A resposta tem este formato:
	
	    nickname codigo-de-status
	
	onde nickname e o nick enviado com o comando, e
	codigo-de-status e um dos seguintes:
	
	    0 - utilizador com esse nick nao esta ligado 
	    1 - utilizador nao reconhecido como dono do nick
	    2 - utilizador reconhecido como dono so pela lista de acesso
	    3 - utilizador reconhecido como dono via identificacao por password
	
	Ate dezasseis nicks podem ser enviados com cada comando, o
	resto sera ignorado. Nao e gerada mensagem de erro se nenhum
	nick for fornecido.

NICK_SERVADMIN_HELP
	
	Os comandos abaixo estao disponiveis para  Administradores dos
	Services :
	
	     GETPASS     Recupera a password de um nick
	                   (se a encriptacao esta desactivada)
	     FORBID      Previne um nick de ser usado
	     LISTLINKS   Lista os nicks ligados a um determinado nick.
	
	Administradores dos Services podem tambem cancelar registo
	de qualquer nick sem a necessidade de identificacao e podem
	ver a lista de ajoin de qualquer nick
	( /%S AJOIN LIST nick ).

NICK_SERVADMIN_HELP_DROP
	Sintaxe:  DROP [nick] 
	
	Sem parametros, cancela o registo do seu nick no banco de
	dados do %S.
	
	Com parametros, cancela o registo de um nick especificado
	do banco de dados.
	Este comando e restrito aos Administradores dos Services .

NICK_SERVADMIN_HELP_UNLINK
	
	Os Administradores dos Services podem desfazer uma ligacao sem
	precisar da password.

NICK_HELP_LISTLINKS
	Sintaxe:  LISTLINKS 
	
	Lista os nicks ligados a um determinado nick. 

NICK_SERVADMIN_HELP_LISTLINKS
	Sintaxe:  LISTLINKS nick [ALL]
	
	Lista os nicks ligados a um determinado nick. Se ALL e
	fornecido, lista todos os nicks com os mesmos privilegios de
	um determinado nick, caso contrario, lista apenas os nicks
	que estao ligados ao nick especificado.

NICK_SERVADMIN_HELP_SET
	
	Administradores dos Services podem ajustar a opcao NOEXPIRE ,
	com a qual os nicks podem ser protegidos de expirar.
	E ainda, Administradores dos Services, podem ajustar opcoes
	para qualquer nick sem se identificar com a password, usando o
	 SET nick opcao parametros .

NICK_SERVADMIN_HELP_SET_NOEXPIRE
	Sintaxe:  SET nick NOEXPIRE {ON | OFF} 
	
	Determina se um nick fornecido podera ser expirado.
	Ajustando este para ON, evita que o nick seja expirado.
	
	Limitado aos Administradores dos Services.

NICK_SERVADMIN_HELP_LIST
	Sintaxe:  LIST padrao [FORBIDDEN] [NOEXPIRE] 
	
	Lista todos os nicks registados que combinem com o padrao
	fornecido (formato nick!user@host). Nicks com opcao PRIVATE
	serao somente exibidos para os Administradores dos Services.
	Nicks com opcao NOEXPIRE ajustada terao um ! preposto ao nick
	na lista quando for a pedido de Administrador dos Services.
	Se as opcoes FORBIDDEN ou NOEXPIRE forem fornecidas, somente os
	nicks proibidos (forbidden) ou os que tem a flag NOEXPIRE serao
	exibidos, respectivamente. Se ambas as opcoes sao fornecidas,
	ambos os tipos de nicks serao exibidos.
	
	Essas opcoes sao limitadas aos Administradores dos Services.
	
	Exemplos:
	
	     LIST *!bond@ab1-23.meuip.pt
	        Lista todos os nicks de bond@ab1-23.meuip.pt.
	
	     LIST *Bot*!*@*
	        Lista todos os nicks registados com  Bot  em seus nomes.
	
	     LIST * NOEXPIRE
	        Lista todos os nicks registados cujos registos foram
	        ajustados para nao expirar.
	
NICK_SERVADMIN_HELP_GETPASS
	Sintaxe:  GETPASS nick 
	
	Mostra a password de um nick especificado.
	Note que sempre que este comando for usado, uma mensagem
	incluindo o nick da pessoa que emitiu o comando o nick
	requisitado sera gravado e enviado para WALLOPS/GLOBOPS.
	
	Limitado aos Administradores dos Services.
	
	Este comando nao e disponivel quando a encriptacao esta habilitada.

NICK_SERVADMIN_HELP_FORBID
	Sintaxe:  FORBID nick 
	
	Nao permite que um nick seja registado ou usado por
	ninguem. Pode ser cancelado desregistando o nick.
	
	Limitado aos Administradores dos Services.

###########################################################################
#
# Mensagens de help do ChanServ
#
###########################################################################

CHAN_HELP
	 %S  permite que registe e controle varios
	aspectos do canal.  %S pode prevenir o "take over"
	do canal de users maliciosos limitando quem possui
	o privilegio de OP do canal. Os comandos disponiveis
	estao listados abaixo.
	Para usa-los, digite   /%S comando .
	Para mais informacoes de um comando, digite
	  /%S HELP comando .
	
	    REGISTER   Regista um canal
	    IDENTIFY   Identifica com uma password
	    SET        Altera as opcoes e informacoes do canal
	    ACCESS     Modifica a lista de users privilegiados
	    AOP/SOP    Aliases para gestao da lista de acesso
	    LEVELS     Redefine os niveis de acesso
	    AKICK      Faz a manutencao da Lista de Autokick
	    DROP       Cancela o registo de um canal
	
	Outros comandos: INFO, LIST, INVITE, OP, DEOP, UNBAN,
	                 KICK, CLEAR

CHAN_HELP_EXPIRES
	
	Note que qualquer canal nao utilizado por %d dias
	(entenda como se nenhum usuario da lista de acesso
	desse canal entrar neste periodo de tempo) tera
	automaticamente cancelado o seu registo.

CHAN_HELP_REGISTER
	Sintaxe:  REGISTER canal password descricao 
	
	Regista um canal no banco de dados do %S.  Para
	utilizar este comando, deve primeiro ser OP do
	canal que esta a tentar registar. A password e usada
	com o comando IDENTIFY e permitira que faca
	mudancas nas opcoes do canal futuramente. O ultimo
	parametro que deve ser incluido, e uma breve
	descricao do proposito do canal.
	
	Quando regista um canal, sera registado
	como o "fundador" do canal. O fundador do canal tem
	permissao para mudar todas as opcoes do canal, o %S
	tambem ira dar ao fundador automaticamente o privilegio
	de OP do canal quando ele/ela entra no canal.  Veja o
	comando ACCESS  (  /%S HELP ACCESS ) para
	informacoes dos subconjuntos destes privilegios para
	outros users do canal.
	
	IMPORTANTE:  Para registar um canal, deve antes ter
	registado seu nick. Se ainda nao, digite  /%s HELP 
	para mais informacoes de como faze-lo.

CHAN_HELP_IDENTIFY
	Sintaxe:  IDENTIFY canal password 
	
	Identifica no %S como fundador do canal fornecido.
	Muitos comandos exigem que use este comando antes
	de usa-los. A password devera ser a mesma que usou
	no comando REGISTER.

CHAN_HELP_DROP
	Sintaxe:  DROP #canal 
	
	Cancela o registo do canal.  So poder ser usado pelo
	fundador do canal, que primeiramente devera usar o
	comando IDENTIFY.

CHAN_HELP_SET
	Sintaxe:  SET canal opcao parametros 
	
	Permite ao fundador do canal alterar as varias opcoes do
	canal e outras informacoes. O fundador deve utilizar o
	comando IDENTIFY antes de usar o SET.
	
	Comandos disponiveis:
	
	    FOUNDER     Altera o fundador do canal
	    SUCCESSOR   Altera o sucessor do canal
	    PASSWORD    Altera a password do fundador
	    DESC        Altera a descricao do canal
	    URL         Associa uma URL a um canal
	    EMAIL       Associa um e-mail a um canal
	    ENTRYMSG    Altera a mensagem que deve ser mandada
	                   aos users quando eles entram no canal
	    TOPIC       Altera o topico do canal
	    KEEPTOPIC   Mantem o topico quando o canal
	                   nao esta em uso
	    TOPICLOCK   O topico pode ser mudado apenas
	                   com o SET TOPIC
	    MLOCK       Liga ou desliga o bloqueio dos modos do canal
	    PRIVATE     Esconde o canal do comando LIST
	    RESTRICTED  Acesso restrito ao canal
	    SECUREOPS   Rigoroso controle de status de OP
	    LEAVEOPS    Nunca tira (de-op) op dos users excepto com
	                   o comando DEOP
	    OPNOTICE    Envia uma notice quando os comandos OP/DEOP
	                   sao usados
	    NOLINKS     Ignora reconhecimento de nivel de acesso no canal
	                   por nick links
	
	Digite   /%S HELP SET opcoes para maiores informacoes
	sobre uma opcao em particular.

CHAN_HELP_SET_FOUNDER
	Sintaxe:  SET canal FOUNDER nick 
	
	Muda o fundador do canal. O novo nick deve estar
	registado.
	
CHAN_HELP_SET_SUCCESSOR
	Sintaxe:  SET canal SUCCESSOR nick 
	
	Muda o sucessor de um canal. Se o nick do founder expirar
	ou estiver dropado enquanto o canal ainda estiver registado,
	o sucessor se tornara o novo founder do canal.
	No entanto, se o sucessor possuir muitos canais registados
	(%d), o canal sera dropado, como se nenhum sucessor tivesse
	sido ajustado. O novo nick devera estar registado.

CHAN_HELP_SET_PASSWORD
	Sintaxe:  SET canal PASSWORD password 
	
	Altera a password utilizada para identificacao do
	fundador do canal.
	
CHAN_HELP_SET_DESC
	Sintaxe:  SET canal DESC descricao 
	
	Altera a descricao para o canal, que e mostrada com
	os comandos LIST e INFO.

CHAN_HELP_SET_URL
	Sintaxe:  SET canal URL [url] 
	
	Associa um URL ao canal. Este URL sera mostrado
	sempre que alguem solicitar informacao sobre o canal
	com o comando INFO. Se nenhum parametro for fornecido,
	apaga qualquer URL actualmente designado para o canal.

CHAN_HELP_SET_EMAIL
	Sintaxe:  SET canal EMAIL [endereco] 
	
	Associa um endereco de e-mail fornecido ao canal.
	Este endereco sera mostrado sempre que alguem solicitar
	informacao sobre o canal com o comando INFO.  Se nenhum
	parametro for fornecido, apaga qualquer endereco de e-mail
	do canal.

CHAN_HELP_SET_ENTRYMSG
	Sintaxe:  SET canal ENTRYMSG [mensagem] 
	
	Altera a mensagem que sera enviada via /notice para
	os users quando eles entrarem no canal.  Se nenhum
	parametro e fornecido, nenhuma mensagem sera enviada
	ao entrar no canal.

CHAN_HELP_SET_TOPIC
	Sintaxe:  SET canal TOPIC topico 
	
	Faz o %S mudar o topico do canal pelo topico dado.
	Este comando e muito mais util em conjunto com o
	 SET TOPICLOCK .

CHAN_HELP_SET_KEEPTOPIC
	Sintaxe:  SET canal KEEPTOPIC {ON|OFF} 
	
	Activa ou desactiva a opcao de retencao de topico para 	
	um canal. Quando a retencao de topico esta accionada,
	o topico para o canal sera relembrado pelo %S mesmo
	depois de os users deixarem o canal, e sera
	restaurado na proxima vez que o canal for re-aberto.

CHAN_HELP_SET_TOPICLOCK
	Sintaxe:  SET canal TOPICLOCK {ON|OFF} 
	
	Activa ou desactiva a opcao que bloqueia o topico de um canal.
	Quando o Bloqueio do topico esta activado, o %S nao permitira
	a mudanca do topico do canal excepto pelo comando  SET TOPIC .
	

CHAN_HELP_SET_MLOCK
	Sintaxe:  SET canal MLOCK modos 
	
	Ajusta o parametro de bloqueio do modo para um canal.  O %S
	permite que defina certos modos no canal a serem sempre activos
	(ou desactivos).  Os modos podem ser i ,  k ,  l ,  m ,  n ,
	 p ,  s  e  t, cada um desses bloqueado como activo, desactivo
	ou nao bloqueado. O parametro modos e usado exactamente do
	mesmo modo como o comando /MODE ;  isto e, modos seguidos
	de + sao bloqueados como activos, e modos seguidos de - sao
	bloqueados como desactivos.
	
	 Cuidado:  Se bloqueia uma password, como no segundo exemplo
	abaixo, deveria tambem ajustar a opcao  RESTRICTED  para
	o canal (veja  HELP SET RESTRICTED ), ou qualquer usuario
	que entra no canal que esta vazio sera capaz de ver a password!
	
	Exemplos:
	
	     SET #canal MLOCK +nt-iklps 
	        Bloqueia os modos n e t activados, e os modos
	        i, k, l, p, s desligados.  Modo m e livremente
	        deixado para ser ligado(on)ou desligado(off).
	
	     SET #canal MLOCK +knst-ilmp minha-password 
	        Bloqueia os modos k, n, s, t como ligados e os
	        modos i, l, m, p como desligados.  Tambem bloqueia
	        a password do canal como "minha-password".
	
	     SET #canal MLOCK + 
	        Elimina o bloqueio dos modos, todos os modos do
	        canal ficam livres para ser activados ou desactivados.

CHAN_HELP_SET_PRIVATE
	Sintaxe:  SET canal PRIVATE {ON|OFF} 
	
	Activa ou desactiva a opcao  private  para um canal.  Quando
	private esta activada, um  /%S LIST  nao ira incluir
	o canal em qualquer listagem.
	
CHAN_HELP_SET_RESTRICTED
	Sintaxe:  SET canal RESTRICTED {ON|OFF} 
	
	Activa ou desactiva a opcao de acesso restrito para um canal.
	Quando o acesso restrito estiver activado, users que
	normalmente nao possuem privilegios de OP no canal
	(users com nivel negativo de acesso e, se  secure ops 
	estiver activado, users que nao pertence a lista de
	acesso) serao imediatamente kickados e banidos do canal.
		
CHAN_HELP_SET_SECUREOPS
	Sintaxe:  SET canal SECUREOPS {ON|OFF} 
	
	Activa ou desactiva a opcao de seguranca de ops para um canal.
	Quando secure-ops estiver activada, os users que nao
	estiverem na lista de acesso nao poderao ter o status de OP.

CHAN_HELP_SET_LEAVEOPS
	Sintaxe:  SET canal LEAVEOPS {ON | OFF} 
	
	Activa e desactiva a opcao LEAVE OPS para um canal. Quando
	LEAVE OPS estiver activado, o ChanServ nunca ira retirar op
	(de-op) do user no canal, excepto se o comando DEOP for
	usado.

CHAN_HELP_SET_OPNOTICE
	Sintaxe:  SET canal OPNOTICE {ON | OFF} 
	
	Activa e desactiva a opcao Op-Notice para um canal. Quando
	Op-Notice estiver activado, o ChanServ enviara uma notice para
	o canal sempre que os comandos OP ou DEOP forem usados em
	um user no canal.

CHAN_HELP_SET_NOLINKS
	Sintaxe:  SET canal NOLINKS {ON | OFF} 
	
	Activa e desactiva a opcao NOLINKS para um canal. Quando
	NOLINKS estiver activado, o ChanServ apenas reconhecera o
	nick real com acesso no canal. Se o nick estiver linkado
	a outro presente na access list nao sera reconhecido como
	tal.

CHAN_HELP_ACCESS
	Sintaxe:  ACCESS canal ADD nick nivel 
	          ACCESS canal DEL {nick | entry-num | list | ALL} 
	          ACCESS canal LIST [hostname | list] 
	
	Faz manutencao da lista de acesso de um canal. A lista
	de acesso especifica que users tem permissao para
	o status de OP ou tem acesso aos comandos do %S em um
	canal. Niveis diferentes de users permitem acesso a
	diferentes subniveis de privilegios;  /%S HELP ACCESS
	LEVELS para mais informacoes especificas. Por padrao,
	qualquer nick nao presente na lista de acesso possui
	nivel 0.
	
	O comando ACCESS ADD adiciona um nick ou hostname de um
	user na lista de acesso com o nivel especificado, se o
	nick ou hostname ja estiver presente na lista, o seu nivel
	de acesso sera alterado para o nivel especificado.
	O nivel especificado deve ser menor do que o user
	que emitiu o comando.
	
	O comando ACCESS DEL remove um nick especificado da lista
	de acesso. Se uma lista de numeros e fornecida, essas
	entradas sao apagadas. (Veja o exemplo para LIST abaixo.)
	A utilizacao de ALL apagara todos os registos, esta opcao
	apenas pode ser usada por utilizador com nivel de founder.	

	O comando ACCESS LIST mostra a lista de acesso do canal. Se
	uma hostname for fornecida, somente as entradas que combinarem
	com o padrao especificado na hostname serao mostradas. Se uma
	lista de numeros e' fornecida, somente essas entradas serao
	mostradas, por exemplo:
	
	ACCESS #canal LIST 2-5,7-9
	   Lista as entradas de acesso numeradas de 2 a 5 e 7 a 9.

CHAN_HELP_ACCESS_LEVELS
	 Niveis de Acesso do Usuario 
	
	Por padrao, os seguintes niveis de acesso sao definidos:
	
	    Founder 	Acesso total as funcoes do %S, OP automatico
	                     quando entrar no canal. Note que
	                     somente uma pessoa pode ter o status
	                     fundador (nao pode ser dado usando
	                     o comando ACCESS).
	         10       Acesso ao comando AKICK, OP automatico.
	          5       OP automatico.
	          3       Voice automatico.
	          0       Sem privilegios especiais, pode-se tornar OP
	                     atraves de outros ops (a menos que
	                     secure-ops esteja activada).
	         <0       Nao pode ser OP.
	
	Esses niveis podem ser mudados, ou adicionar novos, usando o
	comando LEVELS; digite   /%S HELP LEVELS  para informacoes.
	
CHAN_HELP_AKICK
	Sintaxe:  AKICK canal ADD hostname [razao] 
	          AKICK canal DEL [ hostname | ALL ]
	          AKICK canal LIST [hostname] 
	
	Faz a manutencao da lista de AutoKick de um canal.
	Se um user que estiver na lista de AutoKick tentar
	entrar no canal, o %S banira este user do canal,
	e depois o kickara.
	
	O comando AKICK ADD adiciona o usuario especificado ou
	hostname na lista de AutoKick. Se uma razao e dada com
	o comando, esta razao sera usada quando o user for
	kickado, senao, a razao padrao sera "Voce foi banido deste
	canal".
	
	O comando AKICK DEL remove um nick ou hostname da lista
	de AutoKick. Isso, entretanto, nao remove qualquer ban
	colocado pelo AutoKick estes devem ser removidos
	manualmente. A opcao ALL eliminara todas as entradas da
	lista de AutoKick, esta opcao pode apenas ser utilizada
	por utilizadores com nivel de founder.
	
	O comando AKICK LIST mostra a lista de AutoKick, ou
	opcionalmente, so os registos de AutoKick quem se
	encaixam com o padrao de uma hostname dada.

CHAN_HELP_LEVELS
	Sintaxe:  LEVELS canal SET tipo nivel 
	          LEVELS canal {DIS | DISABLE} tipo 
	          LEVELS canal LIST 
	          LEVELS canal RESET 
	
	O comando LEVELS permite ajuste detalhado sobre o
	significado numerico dos niveis de acesso usados pelos
	canais. Com esse comando, pode definir o nivel de
	acesso requerido pela maioria das funcoes do %S.
	(Os comandos SET FOUNDER e SET PASSWORD, assim como este
	comando, sao sempre restritos ao fundador do canal).
	
	LEVELS SET permite que o nivel de acesso para uma funcao ou
	grupo de funcoes sejam alterados. LEVELS DISABLE (ou DIS 
	para encurtar) desabilita automaticamente os dispositivos ou
	nao permite o acesso a funcoes para qualquer outra pessoa
	que nao seja o fundador do canal. LEVELS LIST mostra os
	niveis atuais para cada funcao ou para um grupo de funcoes.
	LEVELS RESET  recoloca os niveis de acordo com o padrao de um
	canal recem-criado (veja HELP ACCESS LEVELS).
	
	Para lista de recursos e funcoes cujo niveis podem ser
	ajustados, veja HELP LEVELS DESC.

CHAN_HELP_LEVELS_DESC
	As seguintes caracteristicas/funcoes sao entendidas. Note 
	que estes niveis para AUTODEOP e NOJOIN sao os niveis maximos,
	enquanto que todos os outros sao niveis minimos.

CHAN_HELP_LEVELS_DESC_FORMAT
	    %-*s  %s

CHAN_HELP_INFO
	Sintaxe:  INFO canal 
	
	Lista os dados referentes ao canal registado dado, incluindo
	seu fundador, data do registo, ultima vez que foi usado,
	descricao e bloqueio dos modos (se existirem).

CHAN_HELP_LIST
	Sintaxe:  LIST padrao 
	
	Lista todos os canais registados que combinam com o padrao
	dado. (Canais com opcao PRIVATE activada nao serao listados).

CHAN_HELP_OP
	Sintaxe:  OP #canal nick 
	
	Atribui status de Operador (modo +o) para o nick dado
	num determinado canal. Limitado aos users de nivel 5,
	no minino, do canal especificado.

CHAN_HELP_DEOP
	Sintaxe:  DEOP #canal nick 
	
	Remove o status de Operador (modo +o) do nick dado para
	um determinado canal. Limitado aos users de nivel 5,
	no minino, do canal especificado.

CHAN_HELP_KICK
	Sintaxe:  KICK #canal nick motivo
	
	Retira um utilizador de um canal, aplicando um KICK 
	com o ChanServ especifificando o motivo.
	Por defeito esta limitado aos users com nivel 5
	no minimo.

CHAN_HELP_INVITE
	Sintaxe:  INVITE #canal 
	
	Manda o %S dar um invite para o canal dado.
	Somente funcionara se seu nivel de acesso for maior
	que zero.
CHAN_HELP_UNBAN
	Sintaxe:  UNBAN #canal 
	
	Diz ao %S para remover todos os bans permitindo que
	voce entre num canal. Por padrao, somente funciona
	se seu nivel de acesso no canal for maior que zero.

CHAN_HELP_CLEAR
	Sintaxe:  CLEAR canal opcao 
	
	Diz ao %S para remover certas colocacoes de um canal.
	A opcao pode ser uma das seguintes:
	
	     MODES    Anula todos os modos do canal (isto e', remove
	                  os modos i,k,l,m,n,p,s,t).
	     BANS     Remove todos os bans do canal.
	     OPS      Remove o status de Operador do canal (mode +o)
	                  de todos os Operadores do canal.
	     VOICES   Remove o status "voice" (mode +v) de qualquer
	                  pessoa que tenha esse modo.
	     USERS    Remove (kicka) todos os users do canal.
	
	Por padrao, seu nivel de acesso no canal dever ser no
	minimo 10 para usar este comando.

CHAN_SERVADMIN_HELP
	
	Os seguintes comandos estao disponiveis para
	os  Administradores dos Services :
	
	    GETPASS    Recupera a password de fundador de um canal
	                   (somente se a encriptacao esta desactivada)
	    FORBID     Proibe um canal de ser usado
	    STATUS     Fornece o actual nivel de acesso de um
	                   user num canal
	
	Administradores do Services podem tambem cancelar o registo sem
	a necessidade de identificacao atraves da password, podem ver os
	acessos, AKICK, e ajuste da lista de niveis de qualquer canal.

CHAN_SERVADMIN_HELP_DROP
	Sintaxe:  DROP canal 
	
	Cancela o registo de um canal. Somente Administradores dos 
	Services podem cancelar canais para os quais eles nao tenham
	sido identificados.

CHAN_SERVADMIN_HELP_SET
	
	Administradores dos Services tambem podem ajustar a opcao
	NOEXPIRE, fazendo com que canais sejam impedidos de ter seu
	registo expirado. Administradores dos Services ainda podem
	ajustar opcoes para qualquer canal sem precisar da identificacao
	do canal atraves da password.

CHAN_SERVADMIN_HELP_SET_NOEXPIRE
	Sintaxe:  SET canal NOEXPIRE {ON | OFF} 
	
	Determina se o canal podera ter seu registo expirado.
	Ajustando para ON, evita que o canal seja desregistado
	por passar do tempo de expiracao.
	
	Limitado aos Administradores dos Services.

CHAN_SERVADMIN_HELP_LIST
	Sintaxe:  LIST padrao 
	
	Lista todos os canais registados que combinam com o
	padrao fornecido. Canais com opca  PRIVATE activada
	so serao mostrados aos Administradores dos Services.

CHAN_SERVADMIN_HELP_GETPASS
	Sintaxe:  GETPASS canal 
	
	Mostra a password de um canal. Note que toda a vez que esse
	este comando for usado, uma mensagem incluindo o nick da
	pessoa que emitiu o comando e o canal que foi dado serao
	gravados e enviados para WALLOPS/GLOBOPS.
	
	Limitado aos Administradores dos Services.

CHAN_SERVADMIN_HELP_FORBID
	Sintaxe:  FORBID canal 
	
	Proibe que qualquer pessoa registe e utilize o canal
	dado. Pode ser cancelado pelo desregisto do canal.
	
	Limitado aos Administradores dos Services.

CHAN_SERVADMIN_HELP_STATUS
	Mostra o nivel de acesso actual de um determinado nick
	em um determinado canal. A resposta sera no formato:
	
	    STATUS canal nick nivel-de-acesso
	
	Se um erro ocorrer, a resposta sera no formato:
	
	    STATUS ERROR mensagem-de-erro

###########################################################################
#
# Mensagens de help do MemoServ
#
###########################################################################

MEMO_HELP
	%S e um utilitario que permite aos users de IRC
	enviar curtas mensagens a outros users, mesmo
	que eles nao estejam conectados no momento; ou
	aos canais(*). Ambos, destinatarios e remetentes,
	devem possuir seu nick (ou canal) registados para
	que possam enviar uma mensagem (memo).
	Os comandos do %S sao:
	
	    SEND   Envia uma mensagem para um nick ou para um canal
	    LIST   Lista suas mensagens
	    READ   Le a(s) mensagem(ns)
	    DEL    Apaga a(s) mensagem(ns)
	    SET    Altera opcoes relacionadas com as mensagens
	
	Digite   /%S HELP <comando> para ajuda em qualquer um dos
	comandos acima.
	
	(*) Por padrao, qualquer user com no minimo
	    nivel 10 pode ler as mensagens do canal.  Isto
	    pode ser alterado com o comando /%s  LEVELS .

MEMO_HELP_SEND
	Sintaxe:  SEND {nick | canal} [?]mensagem 
	
	Envia um memo ao nick ou ao canal determinado contendo
	a mensagem. Quando enviada para o destinatario, este
	recebera um aviso que possui uma nova mensagem. O nick/
	/canal de destino devera estar registado.
	A utilizacao do sinal ? no inicio da mensagem indica que
	pretende receber uma notificao quando o destinatario ler
	a sua mensagem. A notificao consiste num memo automatico
	vindo do destinatario com a mensagem que enviou, entre
	os delimitadores -( )- 

MEMO_HELP_LIST
	Sintaxe:  LIST [canal] [list | NEW] 
	
	Lista quaisquer mensagens que tiver. Com NEW, lista apenas
	as novas mensagens (nao lidas). Mensangens nao lidas sao marcadas
	com "*" a esquerda do numero. Voce tambem pode especificar uma
	lista de numeros, como no exemplo abaixo:
	LIST 2-5,7-9
	   Lista mensagens numeradas de 2 a 5 e de 7 a 9.

MEMO_HELP_READ
	Sintaxe: READ [canal] {num | list | LAST | NEW}
	
	Mostra as mensagens especificadas. Se LAST e fornecido, envia
	a mensagem recebida mais recentemente. Se NEW e fornecido,
	envia a todas as suas novas mensagens. Caso contrario, envia
	a uma mensagem numerada. Voce tambem pode fornecer uma lista
	de numeros, como por exemplo:
	
	READ 2-5,7-9
	   Mostra as mensagens numeradas de 2 a 5 e 7 a 9.

MEMO_HELP_DEL
	Sintaxe: DEL [canal] {num | list | ALL}
	
	Apaga a(s) mensagem(ns) especificada(s). Voce pode fornecer
	varios numeros de mensagens ou sequencias de numeros ao inves
	de um unico numero, como no segundo exemplo abaixo.

	Se ALL e fornecido, apaga todas suas mensagens.
	
	Exemplos:
	
	    DEL 1 
	      Apaga a primeira mensagem.
	
	    DEL 2-5,7-9 
	      Apaga as mensagens numeradas de 2 a 5 e de 7 a 9.

MEMO_HELP_SET
	Sintaxe:  SET opcao parametros 
	
	Altera varias opcoes de mensagens.  opcao pode ser uma dessas:
	
	    NOTIFY      Muda quando for notificado sobre novas
	                    mensagens (so para nicks)
	    LIMIT       Altera o numero maximo de mensagens que voce
	                    pode receber.
	
	Digite  /%S HELP SET <comando>, para mais informacoes sobre
	um comando especifico.

MEMO_HELP_SET_NOTIFY
	Sintaxe:  SET NOTIFY {ON | LOGON | NEW | OFF} 
	
	Mudancas que ocorrem quando for notificado sobre novas
	mensagens:
	
	    ON      So sera notificado sobre mensagens quando voce
	                se conectar, quando voltar de um /AWAY e quando
	                sao enviadas a voce.
	    LOGON   So sera notificado sobre mensagens quando voce
	                se conectar ou quando voltar de um /AWAY.
	    NEW     So sera notificado sobre mensagens quando
	                estiverem a enviar mensagens a voce.
	    OFF     Nao recebera nenhuma notificacao sobre mensagens.
	
	    ON  e essencialmente a combinacao  LOGON  e  NEW .

MEMO_HELP_SET_LIMIT
	Sintaxe:  SET LIMIT [canal] limite 
	
	Altera o numero maximo de mensagens que pode ter
	(ou do canal fornecido). Se alterar para 0, ninguem
	lhe podera enviar mensagens. Entretanto, nao pode
	alterar este limite para mais que %d.

MEMO_HELP_INFO
	Sintaxe:  INFO [canal] 
	
	Informa o numero de mensagens que tem, quantas
	mensagens nao foram lidas e o total de quantas
	mensagens pode receber.
	Com o parametro, mostra a mesma informacao para o canal
	fornecido.

MEMO_SERVADMIN_HELP_SET_LIMIT
	Sintaxe:  SET LIMIT [user | canal] {limite | NONE} [HARD] 
	
	Altera o numero maximo de mensagens que um nick ou canal podem
	ter. Alterando o limite para 0, previne o user de receber
	qualquer mensagem, colocando o limite em NONE permite que o
	usuario receba e mantenha quantas mensagens quiser. Se voce
	nao fornecer o nick ou canal, o limite do seu nick sera alterado.
	
	Adicionando  HARD  previne que o user mude o limite.
	Nao colocar  HARD  tem o efeito contrario, permitindo
	que o user mude o limite (mesmo se um limite anterior
	foi ajustado com  HARD ).
	
	O uso do comando SET LIMIT e limitado aos  Administradores 
	dos Services. Outros users somente altearao seus
	proprios limites ou de um canal onde tenham privilegios
	para isso, nao podem remover seu proprio limite, nao
	podem alterar o limite acima de %d e nao podem alterar
	um limite maximo (HARD).

MEMO_SERVADMIN_HELP_INFO
	Sintaxe:  INFO [nick | canal] 
	
	Sem um parametro, informa o numero de mensagens que tem,
	quantas mensagens ainda nao foram lidas e o total
	de quantas mensagens pode receber.
	
	Com o parametro do canal, mostra a mesma informacao sobre
	um canal.
	
	Com o parametro de nick, mostra a mesma informacao sobre
	um nick. Esta derivacao do comando e limitada aos
	Administradores dos Services.
	

###########################################################################
#
# Mensagens de help do OperServ
#
###########################################################################

OPER_HELP
	%S comandos:
	    GLOBAL      Manda mensagens a todos os users
	    STATS       Mostra o status dos Services e da Rede
	    OPER LIST   Lista todos os Operadores dos Services
	    ADMIN LIST  Lista todos os Administradores dos Services
	
	Comandos disponiveis somente para Operadores e Administradores dos 
	Services:
	    MODE        Muda os modos de um canal
	    KICK        Kicka um user de um canal
	    AKILL       Manipula a lista de AKILL
	    VLINE       Manipula a lista de VLINEs
	    BOT         Manipula a lista de BOTs.
	    SESSION     Infomacao relativa ao controlo de sessoes.
	
	Comandos disponiveis somente para Administradores dos Services:
	    SQLINE      Manipula a lista de SQLINEs
	    OPER        Modifica a lista de Operadores dos Services
	    LOGONNEWS   Define mensagens a serem mostradas aos users
	                    quando estiverem conectando
	    OPERNEWS    Define mensagens a serem mostradas aos ircops
	    JUPE        Desconecta um servidor da rede

	    SET         Altera opcoes globais dos Services
	    UPDATE      Forca a atualizacao imediata do banco de dados
	                    dos Services no disco
	    QUIT        Termina o programa dos Services
	    RESTART     Salva o banco de dados e reinicia os Services
	    REHASH      Rele o arquivo de configuracao dos Services
	    GETFOUNDER  Atribui privilegios de founder para um canal
	
	Comandos disponiveis para SuperAdministradores dos Services:
	    ADMIN       Modifica a lista de Administradores dos Services
	    RAW         Manda uma serie de texto ao servidor IRC	
	
	Aviso:  Todos os comandos enviados ao %S sao gravados!

OPER_HELP_GLOBAL
	Sintaxe:  GLOBAL mensagem 
	
	Permite os IRCops mandarem mensagens a todos os users da rede.
	Esta mensagem sera enviada pelo  %s .

OPER_HELP_STATS
	Sintaxe:  STATS [RECORD AKILL | ALL] 
	
	Sem nenhuma opcao, mostra o numero actual de users e
	IRCops online (excluindo Services), o numero maximo de
	users online conectados simultaneamente e o tempo
	de duracao desde que a seccao dos Services comecou a
	funcionar.
	
	Com a opcao AKILL, mostra o tamanho actual da lista de
	AKILL e o tempo default para um AKILL expirar.
	
	A opcao ALL e disponivel somente para os Administradores
	dos Services, e mostra informacoes sobre o consumo de memoria
	dos Services. Usando este comando, pode-se congelar os
	Services por um curto periodo de tempo em redes grandes,
	portanto nao abuse deste comando!
	
	A opcao RECORD mostra a data e o valor dos recordes para
	o numero toal de utilizadores, ops, helps e bots na rede.
	
	 UPTIME pode ser usado como um sinonimo para STATS.

OPER_HELP_OPER
	Sintaxe:  OPER ADD nick 
	          OPER DEL nick 
	          OPER LIST 
	
	Permite aos Administradores dos Services adicionar ou remover
	nicks da lista de Operadores dos Services. O user que
	tem o nick na lista de Operadores dos Services e que esta
	identificado no %s e capaz de usar os comandos de
	Operador dos Services.
	
	Qualquer IRCop pode usar o OPER LIST .
	Todos as outras derivacoes do comando OPER sao limitados
	aos Administradores dos Services.

OPER_HELP_ADMIN
	Sintaxe:  ADMIN ADD nick 
	          ADMIN DEL nick 
	          ADMIN LIST 
	
	Permite que os Administradores dos Services adicionem ou
	removam nicks da lista de Administradores dos Services.
	Os users que tem o nick na lista de Administradores dos
	Services e que ja se tenham identificado no %s sera
	capaz de ter acesso aos comandos de Administradores dos
	Services.
	
	Qualquer IRCop pode usar o comando ADMIN LIST.
	Todas as outras derivacoes do ADMIN sao limitadas ao
	Services root.

OPER_HELP_MODE
	Sintaxe:  MODE   canal   modos 
	
	Permite que os Operadores dos Services ajustem os modos de
	qualquer canal. Os parametros sao os mesmos que o do
	comando /MODE padrao.
	
	Limitado aos Operadores dos Services.

OPER_HELP_CLEARMODES
	Sintaxe:  CLEARMODES canal [ALL] 
	
	Limpa todos os modos binarios (i,k,l,m,n,p,s,t) e bans de um
	canal. Se ALL e fornecido, limpa tambem todos os ops e
	voices (modos +o e +v) de um canal.
	
	Limitado aos Operadores dos Services.

OPER_HELP_KICK
	Sintaxe:  KICK canal user razao 
	
	Permite IRCops kickar qualquer user de um canal.
	OS parametros sao os mesmos que comando /KICK padrao.
	A mensagem do kick tem o nick do IRCop que envia o
	comando KICK, por exemplo:
	
	*** SpamMan has been kicked off from channel #my_channel by %S (Mauritz 	(Flood))
	
	Limitado aos Operadores dos Services.

OPER_HELP_AKILL
	Sintaxe:  AKILL ADD [+tempo] hostname razao 
	          AKILL DEL hostname 
	          AKILL LIST [hostname] 
	          AKILL VIEW [hostname] 
	
	Permite que Operadores dos Services manipulem a lista de
	AKILL. Se um user que tenta conectar possui uma hostname
	prevista na lista de AKILL, os Services emitem um KILL para
	aquele usuario, para servidores que suporta, e instrui todos
	os servidores da rede a adicionar um ban (K-line) para a
	hostname do user encontrado.
	
	AKILL ADD adiciona uma hostname ident@host na lista de AKILL
	para uma dada razao (deve ser posta obrigatoriamente).
	AKILL DEL remove uma dada hostname da lista de AKILL, se esta
	estiver presente. AKILL LIST mostra todos os AKILLs actuais;
	se uma hostname opcional for fornecida, a listagem sera
	limitada aquela hostname. AKILL VIEW e uma versao mais
	detalhada do AKILL LIST e mostrara quem adicionou o AKILL, a
	data que foi adicionado e quando sera expirado, como tambem
	a hostname (ident@host) e a razao.
	
	Opcionalmente, um tempo para o akill expirar pode ser
	fornecido com o comando AKILL ADD. O tempo precede a
	hostname ident@host e e especificado como um numero inteiro
	seguido por um dos d (dias), h (horas) ou m (minutos).
	Combinacoes (como de 1h30m) nao sao permitidas. Se uma
	unidade especifica nao e incluida, o default e em dias
	(entao  +30  significa 30 dias). Para adicionar um AKILL que
	nao expira, use  +0 . Se a hostname a ser adicionada comecar
	com um  + , o tempo do AKILL deve ser fornecido, ate mesmo se
	este tempo for igual ao default. O actual tempo de expiracao
	de AKILLs pode ser encontrado com o comando STATS AKILL.
	
	A razao existe apenas para uso dos IRCops, e nao sera
	mostrada aos users nas mensagens de KILL.
	
	Este comando e limitado aos Operadores dos Services.

OPER_HELP_JUPE
	Sintaxe:  JUPE servidor 
	
	Diz aos Services para desconectar um servidor -- isto e, criar
	um falso servidor conectado aos Services que previne que o
	servidor real com aquele nome se conecte na rede. O jupe
	pode ser removido usando um simples SQUIT.
	
	Limitado aos Administradores dos Services.

OPER_HELP_RAW
	Sintaxe:  RAW texto 
	
	Envia uma serie de texto directamente ao servidor onde os
	Services estao conectados. Este comando tem varias
	limitacoes de uso, e pode criar confusoes e problemas na
	rede se usado impropriamente. NAO USE ESTE COMANDO a menos
	que tenha a certeza do que esta a fazer!
	
	Limitado aos Administradores dos Services.

OPER_HELP_SET
	Sintaxe:  SET opcao selecao 
	
	Altera varias opcoes globais dos Services.  Nomes de opcao
	atualmente definidas sao:
	     READONLY    Determina o modo read-only ou read-write
	     DEBUG       Activa ou desactiva o modo de depuracao (debug)
	
	Limitado aos Administradores dos Services.

OPER_HELP_SET_READONLY
	Sintaxe:  SET READONLY {ON | OFF} 
	
	Activa ou desactiva o modo read-only. No modo read-only,
	users normais nao serao capazes de modificar nenhum dado
	nos Services, incluindo lista de acesso de canais e nick,
	etc. IRCops com privilegios suficientes nos Services serao
	capazes de mudar a lista de AKILL e de proibir e cancelar o
	registo de canais ou nicks, embora quaisquer mudancas nao
	serao salvas no banco de dados a menos que o modo read-only
	seja desactivado antes dos Services serem terminados ou
	reiniciados.
	
	Esta opcao e equivalente a opcao da linha de comando
	 "-readonly" .

OPER_HELP_SET_DEBUG
	Sintaxe:  SET DEBUG {ON | OFF | numero} 
	
	Activa ou desactiva o modo de depuracao (debug). No modo de
	depuracao, todos os dados enviados para os Services, assim
	como todas as outras mensagens de depuracao sao enviadas a
	um arquivo de log. Se numero e fornecido, o modo de depuracao
	e activado, com o nivel de debug fornecido.
	
	Esta opcao e equivalente a opcao da linha de comando
	 "-debug" .

OPER_HELP_UPDATE
	Sintaxe:  UPDATE 
	
	Faz com que os Services actualizem o banco de dados logo que
	voce envia este comando.
	
	Limitado aos Administradores dos Services.

OPER_HELP_QUIT
	Sintaxe:  QUIT 
	
	Faz com que desligue os Services imediatamente, o banco de
	dados nao e salvo. Este comando nao deve ser usado a menos
	que haja um dano da copia do banco de dados na memoria e por
	isso eles nao devem ser salvos. Para desligar normalmente,
	use o comando SHUTDOWN.
	
	Limitado aos Administradores dos Services.

OPER_HELP_SHUTDOWN
	Sintaxe:  SHUTDOWN 
	
	Salva o banco de dados dos Services e desliga-os.
	
	Limitado aos Administradores dos Services.

OPER_HELP_RESTART
	Sintaxe:  RESTART 
	
	Salva o banco de dados dos Services e reinicia-os.
	(sai e executa imediatamente o executavel).
	
	Limitado aos Administradores dos Services.
OPER_HELP_REHASH
	Sintaxe:  REHASH
	
	Rele o ficheiro de configuacao dos services.
	Nota: Os parametros do tipo string nao serao alterados
	para manter a integridade dos services.
	
	Limitado aos Administradores dos Services.
OPER_REHASH_DONE
	Leitura da nova configuracao foi efectuada.
OPER_REHASH_ERROR
	Ocorreu um erro lendo o arquivo de configuracao.
CHAN_LEVEL_PROTECT
	Protege um utilizador contra deops/kicks.
NICK_AUTORECON
	Nick reconhecido automaticamente.
NICK_HELP_SET_AUTOJOIN
	Sintaxe:  SET AUTOJOIN {ON | OFF} 
	
	Activa ou desactiva a entrada automatica em canais do %S.
	Quando activada o utilizador entrara nos canais
	inseridos na sua AJOIN LIST quando se identificar.	
NICK_SET_AUTOJOIN_ON
	Entrada automatica nos canais activada.
NICK_SET_AUTOJOIN_OFF
	Entrada automatica nos canais deactivada.	
NICK_SET_AUTOJOIN_SYNTAX
	Sintaxe:  SET AUTOJOIN {ON | OFF} 
NICK_HELP_AJOIN
	Sintaxe: AJOIN { ADD | DEL | LIST } [#canal]
	
	Permite adicionar/retirar/listar a lista de entrada
	automatica de canais.
	Quando voce se identificar, entrara automaticamente
	nos canais existentes nesta lista.
	
	A qualquer momento podes utilizar o comando
	/%S AJOIN NOW para entrares em todos os canais
	da tua lista de entrada automatica.
NICK_AJOIN_LIST_X
	Lista de canais com entrada automatica para  %s :
NICK_AJOIN_SYNTAX
	Sintaxe: AJOIN { ADD | DEL | LIST } [#canal]
NICK_AJOIN_REACHED_LIMIT
	Pedimos desculpa, so pode ter %d canais na lista
	de entrada automatica
NICK_AJOIN_ALREADY_PRESENT
	Canal  %s  ja existe na sua lista de canais.
NICK_AJOIN_ADDED
	%s adicionado a sua lista de canais. 
NICK_AJOIN_NOT_FOUND
	%s nao encontrado na sua lista de canais.
NICK_AJOIN_DELETED
	%s apagado da sua lista de canais.
NICK_AJOIN_LIST
	Lista de canais com entrada automatica:
NICK_INFO_OPT_AUTOJOIN
	Entrada automatica
BAD_CHAN_NAME
	O canal deve estar no formato #canal.
OPER_IDENTIFY_REQUIRED
	O novo sistema de seguranca so permite o funcionamento
	de opers registados nos servicos!!!
	Contacta o teu IRC Admin.
NICK_ALREADY_IDENTIFIED
	Este nick ja esta identificado.
TODAYSTATS
	Estatisticas para o dia de hoje(%s):
	
STATS_TOTAL
	Total: %d
STATS_REGISTERED
	Registados: %d
STATS_DROPPED
	Libertos: %d
STATS_EXPIRED
	Eliminados: %d
STATS_BALANCE
	Saldo: %s
OPER_HELP_BOTLIST
	Syntax: 
	   BOT ADD hostname maxcon motivo	
	   BOT DEL hostname
	   BOT LIST [mascara]
	   BOT VIEW [mascara]
	
	Permite aos IRC Operators manipular a lista de BOTs.
	Esta lista define o limite de ligacoes para um determinado
	host.
OPER_TOO_MANY_BOTLIST
	A lista esta' cheia.
OPER_BOTLIST_NO_NICK
	Lista de BOTs pode apenas conter hostnames absolutos!
OPER_BOTLIST_ADDED
	Nova entrada na lista de bots para %s
OPER_BOTLIST_ADD_SYNTAX
	BOT ADD host maxcon motivo
OPER_BOTLIST_DEL_SYNTAX
	BOT DEL hostname motivo
BOTLIST_REMOVED
	O hostname  %s foi eliminado da lista de BOTs.
OPER_BOTLIST_NOT_FOUND
	O hostname %s nao foi encontrado na lista de BOTs.
OPER_BOTLIST_HEADER
	BotList actual:
# mask, reason	
OPER_BOTLIST_FORMAT
	%-32s %d : %s
#mask, set-by, set-time, reason
OPER_BOTLIST_VIEW_FORMAT
	%s (pelo %s em %s)
	   %s
OPER_BOTLIST_SYNTAX
	BOTLIST {ADD | DEL | LIST | VIEW} hostname [motivo]
CHAN_INFO_SUCCESSOR
	           Sucessor: %s (%s)
CHAN_INFO_NO_SUCCESSOR
	           Sucessor: %s
NICK_SHOULD_REGISTER
	Neste momento esta a utilizar um nick que nao esta registado
	se pretende que este nick seja utilizado exclusivamente por si,
	registe este nick com o comando /%s REGISTER password email.
	Se nao possuir email utilize NOMAIL no campo email. 
CHANGE_IN_1_MINUTE
	Se nao mudar de nick, dentro de um minuto este sera alterado.
NICK_AJOIN_EMPTY
	Lista de canais esta vazia.
FEATURE_DISABLED
	Funcionalidade inexistente neste servidor.
CHAN_ACCESS_LIST_FORMAT2
	  %3d  %4d  %s%s%s%s por %s
NICK_AUTORECON_R
	Reconhecimento automatico de nick por modo +r.
NICK_STATUS_0
	STATUS de %s : 0 - utilizador nao esta conectado  ou  o nick nao esta registado
NICK_STATUS_1
	STATUS de %s : 1 - utilizador nao reconhecido como dono do nick
NICK_STATUS_2
	STATUS de %s : 2 - utilizador reconhecido como dono so pela lista de acesso
NICK_STATUS_3
	STATUS de %s : 3 - utilizador reconhecido como dono via identificacao por password
OPER_HELP_SQLINE
	Syntax: SQLINE ADD nick reason
	        SQLINE DEL  nick
	        SQLINE LIST [mask]
	        SQLINE VIEW [mask]
	
	Allows Services operators to manipulate the SQLINE list.
	A SQLINEd nick cannot be used on the network.
OPER_TOO_MANY_SQLINE
	Sorry, SQLINE list is full.
OPER_SQLINE_JUST_NICK
	You can only use nick/wildcards on SQLINE list.
OPER_SQLINE_ADDED
	New SQLINE added for %s
OPER_SQLINE_ADD_SYNTAX
	SQLINE ADD nick reason
OPER_SQLINE_DEL_SYNTAX
	SQLINE DEL nick reason
OPER_SQLINE_REMOVED
	Removed SQLINE %s from sqline list.
OPER_SQLINE_NOT_FOUND
	SQLINE for  %s was not found on the list.
OPER_SQLINE_HEADER
	Current SQLINE List:
# mask, reason	
OPER_SQLINE_FORMAT
	%-32s %s
#mask, set-by, set-time, reason
OPER_SQLINE_VIEW_FORMAT
	%s (by %s at %s)
	   %s
OPER_SQLINE_SYNTAX
	SQLINE {ADD | DEL | LIST | VIEW} nick [reason]
BAD_EMAIL_ADDRESS
	Email invalido!
	Utilize user@mailserver ou NOMAIL se nao pretender indicar 
	o seu email.
CHAN_DROP_CANCEL
	O pedido de DROP do canal efectuado em %s foi cancelado.
CHAN_DROP_AT
	O registo do canal sera cancelado dentro de %d dia(s).
NICK_DROP_CANCEL
	O pedido de DROP do nick efectuado em %s foi cancelado.
NICK_DROP_AT
	O registo do nick sera cancelado dentro de %d dia(s).
OPER_STATS_USERS_RECORD
	Recorde de utilizadores foi %d em %s 
	Neste momento existe(m) %d utilizadores (%d%)
	-
OPER_STATS_OPERS_RECORD
	Recorde de IRCops foi %d em %s 
	Neste momento existe(m) %d IRCop(s) (%d%)
	-
OPER_STATS_HELPERS_RECORD
	Recorde de helpers foi %d em %s 
	Neste momento existe(m) %d helper(s) (%d%)
	-
OPER_STATS_BOTS_RECORD
	Recorde de bots foi %d em %s 
	Neste momento existe(m) %d bot(s) (%d%)
	-
NEWSS_HELP
	O servico %S permite receber noticias em tempo real
	de acordo com os temas subscritos.
	Existem varios comandos que pode utilizar
	digite /%S comando.
	Para mais informacoes sobre um determinado comando
	digite /%S HELP comando.
	
	    LIST         Lista os varios temas e o seu estado de subscricao
	    SUBSCRIBE    Subscreve um tema
	    UNSUBESCRIBE Cancela a subscricao de um tema
	    SET          Define opcoes
	    RECENT       Lista as noticias enviadas recentemente
NEWSS_HELP_OPER
	
	Comandos de Operadores de Noticias:
	    SEND         Envia uma noticia
	    VIEW         Ver as noticias recentes com infor. detalhada
	    DEL          Apaga uma entrada das noticias recentes
	    OPER LIST    Lista os operadores de noticias
	    ADMIN LIST   Lista os administradores de noticias
NEWSS_HELP_ADMIN
	
	Comandos de Administradores de Noticias:
	    SUBJECT      Altera a lista de temas
	    OPER         Adiciona/Remove operadore de noticias
NEWSS_HELP_SADMIN
	
	Comando de Operadore de Servicos:
	    ADMIN        Adiciona/Remove administrador de noticias
NEWSS_OPER_SYNTAX
	OPER {ADD | DEL | LIST} [nick]
NEWSS_OPER_ADD_SYNTAX
	OPER ADD nick
NEWSS_OPER_DEL_SYNTAX
	OPER DEL nick
NEWSS_OPER_SKELETON
	Services is in skeleton mode; the OPER command is unavailable.
NEWSS_OPER_EXISTS
	%s ja existe na lista de Operadores de noticias.
NEWSS_OPER_ADDED
	%s adicionado a lista de Operadores de noticias.
NEWSS_OPER_TOO_MANY
	Demasiadas entradas (%d) na lista de Operadores de noticias,
	nao pode adicionar mais.
NEWSS_OPER_REMOVED
	%s removido da lista de Operadores de noticias.
NEWSS_OPER_NOT_FOUND
	%s nao foi encontrado na lista de Operadores de noticias.
NEWSS_OPER_LIST_HEADER
	Lista de Operadores de noticias:
	
NEWSS_OPER_HELP
	Syntax: OPER ADD nick
	        OPER DEL nick
	        OPER LIST
	
	Permite aos administradores de noticias, adicionar ou
	remover nicks de ou a lista de Operadores de noticias
	Um utilizador cujo nick esteja na lista de Operadores
	de noticias e se tenha identificado pelo %s tera acesso
	aos comandos de Operador de noticias.
		
	Qualquer operador pode usar o comando OPER LIST
	Todos os outros comando estao limitados aos 
	administradores de noticias.

# News Server ADMIN responses
NEWSS_ADMIN_SYNTAX
	ADMIN {ADD | DEL | LIST} [nick]
NEWSS_ADMIN_ADD_SYNTAX
	ADMIN ADD nick
NEWSS_ADMIN_DEL_SYNTAX
	ADMIN DEL nick
NEWSS_ADMIN_SKELETON
	Services is in skeleton mode; the ADMIN command is unavailable.
NEWSS_ADMIN_EXISTS
	%s ja existe na lista de Administradores de noticias.
NEWSS_ADMIN_ADDED
	%s adicionado a lista de Administradores de noticias.
NEWSS_ADMIN_TOO_MANY
	Demasiadas entradas (%d) na lista de Administradores de noticias,
	nao pode adicionar mais!
NEWSS_ADMIN_REMOVED
	%s removido da lista de Administradores de noticias.
NEWSS_ADMIN_NOT_FOUND
	%s nao encontrado na lista de Administradores de noticias.
NEWSS_ADMIN_LIST_HEADER
	Lista de Administradores de noticias:
	
NEWSS_SUBJECT_HELP
	Permite alterar/criar uma entrada na lista de temas
	do %S.
	
	Sintaxe: SUBJECT numero tema
NEWSS_SUBJECT_SYNTAX
	SUBJECT numero tema
NEWSS_SUBJECT_ERROR
	O numero tem de estar entre 1 e %d.
NEWSS_LIST_HELP
	O comando LIST exibe a lista de assuntos disponiveis 
	e o seu estado de subsricao.
		
	Os marcados com um X estao subscritos.
	Para subscrever/cancelar subscricao utilize os comandos: 
	    SUBCRIBE/UNSUBSCRIBE

NEWSS_LIST_HEADER
	No Subs Tema
	
NEWSS_LIST
	%2d  %c   %s
NEWSS_LIST_END
	Fim da lista de temas
NEWSS_SUBJECT_NOTFOUND
	O tema numero %d nao existe!
NEWSS_SUBJECT_CHANGED
	Tema alterado de %s para %s.
NEWSS_SUBJECT_CREATED
	Tema %s criado.
NEWSS_SUBSCRIBE_SYNTAX
	SUBSCRIBE  numero [,numero] | ALL
NEWSS_SUBSCRIBE_HELP
	Este comando permite subscrever um tema.
	
	Sintaxe: SUBSCRIBE  numero [,numero] | ALL 
	
	Pode subscrever varios temas num so comando
	usando numeros separados com virgulas.
	Indicando ALL subscreve todos os temas.
NEWSS_SUBSCRIBE_SUBSCRIBED
	Subscreveu %d tema(s).
NEWSS_UNSUBSCRIBE_SYNTAX
	UNSUBSCRIBE  numero [,numero] | ALL
NEWSS_UNSUBSCRIBE_HELP
	Este comando permite cancelar a subscricao de um tema.
	
	Sintaxe: UNSUBSCRIBE numero [,numero] |  ALL 
	
	Pode cancelar a subsricao de varios temas num so comando,
	usando numeros separados por virgulas.
	Indicando ALL cancelara subscricao de todos os temas.
NEWSS_UNSUBSCRIBE_UNSUBSCRIBED
	Cancelou a subscricao de %d tema(s).
NEWSS_SEND_SYNTAX
	SEND numero noticia
NEWSS_SEND_HELP
	Permite enviar uma noticia.
	
	Sintaxe: SEND numero noticia
NEWSS_SEND_SENT
	Noticia foi enviada.
NEWSS_SET_SYNTAX
	SET opcao valor
NEWSS_SET_HELP
	Sintaxe: SET opcao valor
	
	Define as opcoes do %S.  Opcao pode ser:
	    NOTICE    Recebe as noticias por notice ou por msg.
NEWSS_SET_NOTICE_SYNTAX
	SET NOTICE [ON | OFF]
NEWSS_SET_NOTICE_HELP
	Sintaxe: SET NOTICE [ON | OFF]

	Se a opcao NOTICE estiver ligada (ON) as noticias
	serao recebidas via NOTICE caso contrario serao
	enviadas por mensagem em privado.
NEWSS_SET_NOTICE_ON
	Opcao de NOTICE esta agora ligada (ON)
NEWSS_SET_NOTICE_OFF
	Opcao de NOTICE esta agora desligada (OFF)
NEWSS_RECENT_HELP
	Sintaxe: RECENT
	
	Lista as noticias mais recentes.
NEWSS_RECENT_HEADER
	Lista das noticias mais recentes
NEWSS_RECENT_LIST
	%s : %s
NEWSS_RECENT_END
	Fim da lista das noticias mais recentes
NEWSS_VIEW_HELP
	Sintaxe: VIEW
	
	Lista as noticias mais recentes com infor. detalhada,
	o tema numero 0 indica noticias eliminadas.
NEWSS_VIEW_HEADER
	Nr. : Sub. : Data : noticia (emissor)
NEWSS_VIEW_LIST
	%s%2d : %2d : %s : %s (%s)%s
NEWSS_DEL_SYNTAX
	DEL numero
NEWSS_DEL_HELP
	Syntax: DEL numero
	
	Este comando elimina um item da lista das noticias
	mais recentes. O item apenas desparece da lista
	apresentada com o comando  /%S RECENT.
	O numero do item devera ser escolhido da primeira
	coluna da lista obtida com /%S VIEW.
NEWSS_DEL_NOTEXIST
	A noticia numero %d nao existe.
NEWSS_DEL_DELETED
	A noticia numero %d foi eliminada..
NICK_INFO_PRIVATE
	A informacao sobre %s e' privada.
CHAN_INFO_PRIVATE
	A informacao sobre %s e' privada.
CHAN_NEED_REGNICK
	Neste canal so' sao permitidos nicks registados!
CHAN_MODE_PROTECTED
	Este canal utiliza modos de entrada protegida.
NEWS_REC_PLEASE_WAIT
	Aguarde %d segundos antes de usar o comando RECENT novamente.
NICK_HELP_NOTES
	Permite-lhe guardar algumas anotacoes.
	
	Para guardar uma anotacao utilize /%S NOTES ADD texto
	Para eliminar uma anotacao utilize /%S NOTES DEL number
	Para listar todas as anotacoes /%S NOTES LIST
NICK_NOTES_SYNTAX
	LIST | ADD texto | DEL number
NICK_NOTES_ADDED
	Anotacao foi guardada com o numero %d.
NICK_NOTES_NOADD
	Atingiu o numero maximo de anotacoes (%d) disponiveis para
	o seu nick, apague alguma anotacao mais antiga para poder
	adicionar esta.
NICK_NOTES_DELETED
	Anotacao numero %d foi eliminada.
NICK_NOTES_NOTFOUND
	A anotacao numero %d nao existe.
NICK_NOTES_LIST_HEADER
	No  Anotacao
NICK_NOTES_LIST
	%2d %s
NICK_NOTES_NONOTES
	Lista de anotacoes vazia.
CHAN_ACCESS_CLEARALL
	Todos os elementos da lista de acesso foram eliminados.
CHAN_AKICK_CLEARALL
	Todos os elementos da lista de AKICKS foram eliminados.
NICK_STATUS_SYNTAX
	STATUS nick
NICK_X_ISFOUNDER
	O nick %s e' fundador do canal, nao pode ser defenido 
	como sucessor.
NICK_X_ISSUCCESSOR
	O nick %s e' sucessor do canal, nao pode ser defenido 
	como fundador.
AGO_TIME_D
	Ha' %d dia(s), %d hora(s), %d minuto(s) e %d segundo(s)
AGO_TIME
	Ha' %d hora(s), %d minuto(s) e %d segundo(s)
TOTAL_TIME
	%d dia(s), %d hora(s), %d minuto(s) e %d segundo(s).
OPER_OPER_SUSPENDED
	O operador %s está agora suspenso durante %d dias.
OPER_OPER_UNSUSPEND
	Suspensao do operador %s foi cancelada.
OPER_OPER_SUSPEND_SYNTAX
	OPER SUSPEND nick dias
CHAN_HELP_AOP
	Alias para gestao da lista de AUTOOPs de um canal.
	AOP ADD   Adiciona um utilizador com nivel de AUTOOP no #canal
	AOP LIST  Lista todos os utilizadores com nivel de AUTOOP no #canal
CHAN_AOP_SYNTAX
	AOP ADD nick | DEL nick | LIST
CHAN_HELP_SOP
	Alias para gestao da lista de utilizadores com permissao
	para mudanca da lista de acessos do canal.
	SOP ADD  Adiciona um utilizador com nivel de ACC-CHANGE no #canal.
	SOP LIST Lista todos os utilizadores com nivel de ACC-CHANGE no #canal
CHAN_SOP_SYNTAX
	SOP ADD nick | DEL nick | LIST
CHAN_AJOIN_ADD
	Devera' adicionar o canal a sua lista de AJOIN com /%s AJOIN ADD %s  
# SENDPASS responses
OPER_SENDPASS_SYNTAX
	SENDPASS nickname
OPER_SENDPASS_UNAVAILABLE
	SENDPASS command unavailable because encryption is in use.
OPER_SENDPASS_SUBJECT
	Password de nick (%s)
OPER_SENDPASS_HEAD
	Ola',
OPER_SENDPASS_LINE_1
	Foi pedido que lhe fosse enviada via e-mail a password para o nick %s .
OPER_SENDPASS_LINE_2
	A password para este nick e' %s . Como medida de seguranca mude a password assim que a utilizar.
OPER_SENDPASS_LINE_3
	Se desconhece o assunto em causa, ignore este email.
OPER_SENDPASS_LINE_4
	Por favor nao responda a este email.
OPER_SENDPASS_LINE_5
	PTlink Services - http://www.ptlink.net	
OPER_SENDPASS_OK
	Password para o nick %s foi enviada.
CHAN_RESTRICT_REGISTER
	O registo de canais nesta rede está restricto a Services Operators.
MEMO_WILL_EXPIRE
	O(s) seu(s) memo(s):%s sera(o) eliminado(s) em breve,
	por ser(em) demasiado antigo(s).
MEMO_HAVE_EXPIRED
	O(s) seu(s) memo(s):%s foram eliminados.
NICK_INFO_IS_ONLINE
	Utilizador está ligado.
CHAN_LIST_SERVADMIN_SYNTAX
	LIST pattern [FORBIDDEN] [NOEXPIRE]
NICK_AUTH_SENT
	Uma curta mensagem foi enviada para o seu endereço de email
	com instruçoes detalhadas para completar o registo do nick.
	Ate que finalize o registo com a autenticacao pelo codigo
	enviado para o email nao lhe sera' possivel enviar memos
	ou registar novos canais.
NICK_AUTH_INCORRET
	O codigo utilizado nao esta' correcto para o nick/email
	deste nick.
NICK_AUTH_COMPLETED
	O codigo esta correcto, o registo do seu nick/alteracao de 
	email esta completo/a.
NICK_HELP_AUTH
	Sintaxe: AUTH codigo
	 
	Valida o e-mail associado associado seu seu nick.
AUTH_EMAIL_SUBJECT
	Registo de nick
SET_EMAIL_SUBJECT
	Alteracao do e-mail de nick
NICK_SET_EMAIL_WAIT
	Por favor aguarde um dia antes de tentar alterar
	o seu endereco de email de novo.
NICK_SET_EMAIL_AUTH
	Verifique o seu email (%s) onde deverá ter recebido 
	instrucoes para que possa completar esta alteracao.
NICK_AUTH_NEEDED
	Por favor complete o registo do seu nick com a 
	autenticação do e-mail que indicou para registo.

	Se não indicou um email valido durante o registo ou nao
	recebeu o codigo de autenticaco faca a alteracao
	do email associado a este nick com 
	/%s SET EMAIL email
NICK_HELP_SET_NEWSLETTER
	Syntax: SET NEWSLETTER { ON | OFF }
	
	Activa/desactiva recepcao da newsletter.
NICK_SET_NEWSLETTER_ON
	Recepcao da Newsletter activada.
NICK_SET_NEWSLETTER_OFF
	Recepcao da Newsletter desactivada.
NICK_SET_NEWSLETTER_SYNTAX
	SET NEWSLETTER { ON | OFF }
NICK_INFO_NEWSLETTER
	Recebera' newsletter.
