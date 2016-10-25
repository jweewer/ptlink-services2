###########################################################################
# Arquivo do idioma Português (do Brasil) tradução por ROD_NOKEY.
# Nome:   Rodrigo Teles Calado.
# E-mail: <rodrigo@brirc.com.br>.
###########################################################################

# Services é protegido por direitos autorais (c) 1996-1999 Andy Church.
#     E-mail: <achurch@dragonfire.net>
# Este programa é grátis, porém registrado; veja o arquivo COPYING
# para detalhes.

# Quando traduzindo este programa para outro idioma, lembre-se que a
# ordem dos parâmetros para sprintf() é fixado no código de fonte, então
# suas mensagens precisam ter os mesmos parâmetros nos mesmos padrões das
# mensagens em inglês. (Obviamente, isto não é válido para linhas no formato
# strftime() que ficam uma abaixo das outras). Não se pode adquirir uma
# tradução das mensagens naturalmente sem mudar as ordens dos parâmetros,
# avise-me (achurch@dragonfire.net) qual mensagem está causando o problema e
# eu verei o que posso fazer.
#
# Nas mensagens de ajuda, "%S" (S maiúsculo, não é minúsculo) refere-se ao nome
# do serviço que envia a mensagem; por exemplo, na mensagem de ajuda do
# NickServ, "%S" é substituído por "NickServ" (ou outro nome definido
# no config.h). Os %S's não contam como sendo parâmetros de sprintf(),
# assim podem ser reorganizados, removidos, ou adicionados se necessário.
#
# Finalmente, lembre-se de colocar TAB no começo de toda linha do texto
# (incluindo linhas vazias). Tem que ser TAB, não espaços.

###########################################################################
#
# Nome deste idioma
#
###########################################################################

# Para idiomas diferentes do inglês, essa string deve ter o seguinte formato:
#     language-name-in-language (language-name-in-English)
# Por exemplo, "Español (Spanish)" or "Français (French)".

LANG_NAME
	Portugues BR (Portuguese Brazil)

###########################################################################
#
# Mensagens Gerais
#
###########################################################################

# Strings no formato strftime(). "man 3 strftime" para informações sobre o
# significado da especificação do formato. Versão pequena:
#       %a = nome do dia da semana (pequeno)    %H = hora
#       %b = nome do mês (pequeno)              %M = minuto
#       %d = dia do mês                         %S = segundo
#       %Y = ano                                %Z = zona de fuso horário

# O seguinte é usado para o formato de uma string da strftime(), com uma
# data e horário mostrados juntamente.
STRFTIME_DATE_TIME_FORMAT
	%d %b %H:%M:%S %Y %Z
# O seguinte é usado para o formato de uma string da strftime(), com uma
# data sozinha de formato longo (Para o inglês inclui-se o dia da semana).
STRFTIME_LONG_DATE_FORMAT
	%a %d %b %Y
# O seguinte é usado para o formato de uma string da strftime(), com apenas
# a data em formato curto (Para o inglês: sem o dia da semana).
STRFTIME_SHORT_DATE_FORMAT
	%d %b %Y

# Estes especificam para a strftime() quais são os nomes dos dias e meses.
# Se não usar %a, %A, %b, or %B nas suas strings da strftime(), pode
# deixar essas partes vazias. No entanto, se colocar nomes, eles DEVEM
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
	Erro interno - impossível processar o pedido.
UNKNOWN_COMMAND
	Comando %s desconhecido.
UNKNOWN_COMMAND_HELP
	Comando %s desconhecido. "/%s HELP" para ajuda.
SYNTAX_ERROR
	Sintaxe: %s
MORE_INFO
	/%s HELP %s para mais informações.
NO_HELP_AVAILABLE
	Ajuda não disponível para %s.

BAD_USERHOST_MASK
	Hostnames devem estar no formato ident@host.

SERVICE_OFFLINE
	%s está atualmente desligado.
READ_ONLY_MODE
	Atenção: Services estão no modo read-only (somente-leitura). Mudanças não serão guardadas!
ACCESS_DENIED
	Acesso negado.
PERMISSION_DENIED
	Permissão negada.
PASSWORD_INCORRECT
	Senha incorreta.

MORE_OBSCURE_PASSWORD
	Tente novamente com uma SENHA mais difícil. As senhas devem ter no
	mínimo cinco caracteres, não devem ser algo deduzível (ex: nome ou nick) e não podem conter espaços ou TAB.
PASSWORD_TRUNCATED
	Notice: A sua senha foi limitada a %d caracteres.

NICK_NOT_REGISTERED
	O nick utilizado não está registrado.
NICK_NOT_REGISTERED_HELP
	O nick utilizado não está registrado. Digite /%s HELP para mais
	informações sobre como registrá-lo.
NICK_X_NOT_REGISTERED
	Nick %s não está registrado.
NICK_X_NOT_IN_USE
	Nick %s não está em uso neste momento.
NICK_X_NOT_ON_CHAN
	Nick %s não está no canal %s.
NICK_X_FORBIDDEN
	Nick %s não pode ser utilizado ou registrado.
CHAN_X_NOT_REGISTERED
	Canal %s não está registrado.
CHAN_X_NOT_IN_USE
	Canal %s não existe.
CHAN_X_FORBIDDEN
	Canal %s não pode ser utilizado ou registrado.
NICK_IDENTIFY_REQUIRED
	Autenticação de senha é requerida para este comando.
	Tente novamente após digitar /%s IDENTIFY senha.
CHAN_IDENTIFY_REQUIRED
	Autenticação de senha é requerida para este comando.
	Tente novamente após digitar /%s IDENTIFY %s senha.

###########################################################################
#
# Mensagens do NickServ
#
###########################################################################

# Automatic messages
NICK_IS_REGISTERED
	Este nick está registrado. Se for seu identifique-o
	(/%s IDENTIFY senha). Se não for escolha outro.
NICK_IS_SECURE
	Este nick está registrado e protegido.
	Se o nick pertencer a você, digite /%s IDENTIFY senha.
	Caso contrário escolha um nick diferente com /NICK outro_nick.
NICK_MAY_NOT_BE_USED
	Este nick não pode ser utilizado. Por favor escolha outro.
DISCONNECT_IN_1_MINUTE
	Se não trocar de nick dentro de 1 minuto, este será alterado.
DISCONNECT_IN_20_SECONDS
	Se não trocar de nick dentro de 20 segundos, será desconectado.
DISCONNECT_NOW
	Este nick está registrado, você não pode usá-lo. Por favor
	escolha um outro nick antes de reconectar.

# REGISTER responses
NICK_REGISTER_SYNTAX
	REGISTER senha email
NICK_REGISTRATION_DISABLED
	Pedimos desculpa. O registro de nicks está temporariamente desativado.
NICK_REGISTRATION_FAILED
	Pedimos desculpa. Ocorreu uma falha na hora do registro.
NICK_REG_PLEASE_WAIT
	Aguarde %d segundos antes de usar o comando REGISTER novamente.
NICK_CANNOT_BE_REGISTERED
	Nick %s não pode ser registrado.
NICK_ALREADY_REGISTERED
	Nick %s está registrado!
NICK_REGISTERED
	Nick %s registrado a partir de sua conta: %s
NICK_PASSWORD_IS
	A sua senha é %s - lembre-se dela para uso posterior.

# IDENTIFY responses
NICK_IDENTIFY_SYNTAX
	IDENTIFY senha
NICK_IDENTIFY_FAILED
	Pedimos desculpa. A sua identificação falhou.
NICK_IDENTIFY_SUCCEEDED
	Senha aceita - você está reconhecido.
# DROP responses
NICK_DROP_SYNTAX
	DROP
NICK_DROP_DISABLED
	Pedimos desculpa. Cancelamento do registro de nicks está temporariamente
	desativado.
NICK_DROPPED
	O registro do seu nick foi cancelado.
NICK_X_DROPPED
	O registro do nick %s foi cancelado.

# SET responses
NICK_SET_SYNTAX
	SET opção parâmetros
NICK_SET_SERVADMIN_SYNTAX
	SET [nick] opção parâmetros
NICK_SET_DISABLED
	Pedimos desculpa. A configuração de opções do nick está temporariamente
	desativada.
NICK_SET_UNKNOWN_OPTION
	Opção SET %s desconhecida.
NICK_SET_UNKNOWN_OPTION_OR_BAD_NICK
	Opção SET %s desconhecida, ou nick não registrado.

# SET PASSWORD responses
NICK_SET_PASSWORD_FAILED
	Pedimos desculpa. É impossível trocar a senha.
NICK_SET_PASSWORD_CHANGED
	Senha alterada com êxito.
NICK_SET_PASSWORD_CHANGED_TO
	Senha alterada para %s.

# SET URL responses
NICK_SET_URL_CHANGED
	URL modificado para %s .
NICK_SET_URL_UNSET
	Associação a URL foi apagada.

# SET EMAIL responses
NICK_SET_EMAIL_CHANGED
	E-mail modificado para %s.
NICK_SET_EMAIL_UNSET
	Associação ao endereco de e-mail foi apagada.

# SET ICQNUMBER responses
NICK_SET_ICQ_CHANGED
	Número ICQ alterado para #%s.
NICK_SET_ICQ_UNSET
	Número ICQ foi apagado.

# SET LOCATION responses
NICK_SET_LOCATION_CHANGED
	Local alterado para %s.
NICK_SET_LOCATION_UNSET
	Local foi apagado.

# SET LANGUAGE responses
NICK_SET_LANGUAGE_SYNTAX
	SET LANGUAGE número
NICK_SET_LANGUAGE_UNKNOWN
	Número de linguagem %d desconhecido. Digite /%s HELP SET LANGUAGE
	para uma lista de linguagens.
NICK_SET_LANGUAGE_CHANGED
	Linguagem modificada para Português (Brasil).

# SET KILL responses
NICK_SET_KILL_SYNTAX
	Esta proteção é agora obrigatória, não sendo por isso configurável.
NICK_SET_KILL_IMMED_SYNTAX
	Esta proteção é agora obrigatória, não sendo por isso configurável.
NICK_SET_KILL_ON
	Esta proteção é agora obrigatória, não sendo por isso configurável.
NICK_SET_KILL_QUICK
	Esta proteção é agora obrigatória, não sendo por isso configurável.
NICK_SET_KILL_IMMED
	Esta proteção é agora obrigatória, não sendo por isso configurável.
NICK_SET_KILL_IMMED_DISABLED
	Esta proteção é agora obrigatória, não sendo por isso configurável.
NICK_SET_KILL_OFF
	Esta proteção é agora obrigatória, não sendo por isso configurável.

# SET PRIVATE responses
NICK_SET_PRIVATE_SYNTAX
	SET PRIVATE {ON | OFF}
NICK_SET_PRIVATE_ON
	Opção PRIVATE ativada.
NICK_SET_PRIVATE_OFF
	Opção PRIVATE desativada.

# SET HIDE responses
NICK_SET_HIDE_SYNTAX
	SET HIDE {EMAIL | QUIT} {ON | OFF}
NICK_SET_HIDE_EMAIL_ON
	O seu endereço de e-mail está agora oculto na exibição no %s INFO.
NICK_SET_HIDE_EMAIL_OFF
	O seu endereco de e-mail está agora visível para exibição no %s INFO.
NICK_SET_HIDE_QUIT_ON
	A sua última mensagem de quit está agora oculta para exibição no %s INFO.
NICK_SET_HIDE_QUIT_OFF
	A sua última mensagem de quit está agora visível para exibição no %s INFO.

# SET NOEXPIRE responses
NICK_SET_NOEXPIRE_SYNTAX
	SET [nick] NOEXPIRE {ON | OFF}
NICK_SET_NOEXPIRE_ON
	O nick %s não irá expirar.
NICK_SET_NOEXPIRE_OFF
	O nick %s irá expirar.

# LINK responses
NICK_LINK_SYNTAX
	LINK nick senha
NICK_LINK_DISABLED
	O comando LINK não está disponível.
NICK_LINK_FAILED
	Pedimos desculpa. A ligação falhou.
NICK_NO_LINK_SAME
	Não pode fazer uma ligação para o seu nick atual!
NICK_LINK_CIRCULAR
	Impossível ligar o nick %s : ligação circular detectada.
NICK_LINKED
	Seu nick foi ligado ao nick %s.

# UNLINK responses
NICK_UNLINK_FAILED
	Pedimos desculpa, desligação de nicks falhou.
NICK_NOT_LINKED
	O seu nick não está ligado.
NICK_X_NOT_LINKED
	Nick %s não está ligado.
NICK_UNLINKED
	O seu nick foi desligado do nick %s.
NICK_X_UNLINKED
	O nick %s foi desligado do nick %s.

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
	%s é %s
NICK_INFO_ADDRESS
	         Último endereço: %s
NICK_INFO_TIME_REGGED
	        Data de registro: %s [%s]
NICK_INFO_LAST_IDENTIFY
	 Última vez identificado: %s [%s]
NICK_INFO_LAST_SEEN
	        Última vez visto: %s [%s]
NICK_INFO_ONLINE
	      Tempo total online: %s
NICK_INFO_LAST_QUIT
	 Última mensagem de quit: %s
NICK_INFO_URL
	                     URL: %s
NICK_INFO_EMAIL
	                  E-mail: %s
NICK_INFO_ICQ
	              Número ICQ: #%s
NICK_INFO_LOCATION
	                   Local: %s
NICK_INFO_OPTIONS
	                  Opções: %s
NICK_INFO_NO_EXPIRE
	Cancelamento do registro: Este nick não irá expirar.
NICK_INFO_OSUSPENDED
	  Suspensão de oline até: %s
# These strings MUST NOT be empty
NICK_INFO_OPT_KILL
	Proteção de Kill
NICK_INFO_OPT_PRIVATE
	Privado
NICK_INFO_OPT_NONE
	Nenhuma

# LIST responses
NICK_LIST_SYNTAX
	LIST padrão
NICK_LIST_SERVADMIN_SYNTAX
	LIST padrão [FORBIDDEN] [NOEXPIRE]
NICK_LIST_HEADER
	Lista das entradas que satisfazem  %s :
NICK_LIST_RESULTS
	Fim da listagem - %d/%d entradas mostradas.

NICK_RELEASED
	A proteção dos Services ao seu nick foi desligada.

# GHOST responses
NICK_GHOST_SYNTAX
	GHOST nick [senha]
NICK_NO_GHOST_SELF
	Não pode utilizar um ghost em si mesmo!
NICK_GHOST_KILLED
	O ghost do seu nick foi desligado.

# GETPASS responses
NICK_GETPASS_SYNTAX
	GETPASS nick
NICK_GETPASS_UNAVAILABLE
	Comando inválido porque encriptação está em uso.
NICK_GETPASS_PASSWORD_IS
	Senha para %s é %s.

# FORBID responses
NICK_FORBID_SYNTAX
	FORBID nick
NICK_FORBID_SUCCEEDED
	Nick %s está proibido de ser usado.
NICK_FORBID_FAILED
	Não se pode proibir o nick %s!

###########################################################################
#
# Mensagens do ChanServ
#
###########################################################################

# Access level descriptions
CHAN_LEVEL_AUTOOP
	Modo +o automático
CHAN_LEVEL_AUTOVOICE
	Modo +v automático
CHAN_LEVEL_AUTODEOP
	Não pode ser operador deste canal
CHAN_LEVEL_NOJOIN
	Não pode entrar no canal se este estiver restrito (opção RESTRICTED)
CHAN_LEVEL_INVITE
	Permitido usar o comando INVITE
CHAN_LEVEL_AKICK
	Permitido usar o comando AKICK
CHAN_LEVEL_SET
	Permitido usar o comando SET (não sendo FUNDADOR)
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
	Este canal está registrado com %s.
CHAN_NOT_ALLOWED_OP
	Não tem permissão para ser operador deste canal %s.
CHAN_MAY_NOT_BE_USED
	Este canal não pode ser usado.
CHAN_NOT_ALLOWED_TO_JOIN
	Não está com permissão para permanecer neste canal.

# REGISTER responses
CHAN_REGISTER_SYNTAX
	REGISTER canal senha descrição
CHAN_REGISTER_DISABLED
	Pedimos desculpa. Mas o registro de canal está temporariamente desativado.
CHAN_REGISTER_NOT_LOCAL
	Canais locais não podem ser registrados.
CHAN_MUST_REGISTER_NICK
	Primeiro tem de registrar o seu nick. Digite /%s HELP para obter
	informação sobre o registro de nicks.
CHAN_MUST_IDENTIFY_NICK
	Por favor, identique-se com %s primeiro utilizando o comando:
	/%s IDENTIFY senha.
CHAN_MAY_NOT_BE_REGISTERED
	O canal %s não pode ser registrado.
CHAN_ALREADY_REGISTERED
	O canal %s já está registrado!
CHAN_MUST_BE_CHANOP
	Tem que ser operador do canal para poder registrar o canal.
CHAN_REACHED_CHANNEL_LIMIT
	Pedimos desculpa. Mas já alcancou o limite de %d canais.
CHAN_EXCEEDED_CHANNEL_LIMIT
	Pedimos desculpa. Mas já ultrapassou o seu limite de %d canais.
CHAN_REGISTRATION_FAILED
	Pedimos desculpa. O registro falhou.
CHAN_REGISTERED
	O canal %s registrado com o seu nick: %s
	Não se esqueça de escolher o seu sucessor com
	/CHANSERV SET #canal SUCCESSOR nick
CHAN_PASSWORD_IS
	A senha do seu canal é %s - lembre-se dela para uso posterior.

# IDENTIFY responses
CHAN_IDENTIFY_SYNTAX
	IDENTIFY canal senha
CHAN_IDENTIFY_FAILED
	Pedimos desculpa. A identificação falhou.
CHAN_IDENTIFY_SUCCEEDED
	Senha aceita - você está reconhecido como fundador do %s.

# DROP responses
CHAN_DROP_SYNTAX
	DROP canal
CHAN_DROP_DISABLED
	Pedimos desculpa. O cancelamento do registro de canal está temporariamente
	desativado.
CHAN_DROPPED
	O registro do canal %s foi apagado.

# SET responses
CHAN_SET_SYNTAX
	SET canal opção parâmetros
CHAN_SET_DISABLED
	Pedimos desculpa. As opções do canal estão temporariamente desativadas.
CHAN_SET_UNKNOWN_OPTION
	Opção SET %s desconhecida.

# SET FOUNDER responses
CHAN_SET_FOUNDER_TOO_MANY_CHANS
	%s tem canais registrados em excesso.
CHAN_FOUNDER_CHANGED
	Fundador do canal %s alterado para %s.

# SET SUCCESSOR responses
CHAN_SUCCESSOR_CHANGED
	Sucessor de %s mudado para %s.
CHAN_SUCCESSOR_UNSET
	Sucessor para %s retirado.

# SET PASSWORD responses
CHAN_SET_PASSWORD_FAILED
	Pedimos desculpa. Mas não foi possivel alterar a senha.
CHAN_PASSWORD_CHANGED
	%s senha alterada.
CHAN_PASSWORD_CHANGED_TO
	Senha do canal %s alterada para %s.

# SET DESC responses
CHAN_DESC_CHANGED
	Descrição do canal %s alterada para %s.

# SET URL responses
CHAN_URL_CHANGED
	URL do canal %s alterado para %s.
CHAN_URL_UNSET
	Associação a URL para o canal %s foi apagada.

# SET EMAIL responses
CHAN_EMAIL_CHANGED
	Endereço de e-mail do canal %s foi mudado para %s.
CHAN_EMAIL_UNSET
	Associação ao e-mail do canal %s foi apagada.

# SET ENTRYMSG responses
CHAN_ENTRY_MSG_CHANGED
	Mensagem de entrada no canal %s alterada.
CHAN_ENTRY_MSG_UNSET
	A designação atual da mensagem de entrada do canal %s foi apagada.

# SET TOPIC responses
CHAN_SET_TOPIC_FAILED
	Pedimos desculpa. Não foi possível por o tópico escolhido.

# SET MLOCK responses
CHAN_SET_MLOCK_KEY_REQUIRED
	Parâmetro requerido para MLOCK +k.
CHAN_SET_MLOCK_LIMIT_REQUIRED
	Parâmetro requerido para MLOCK +l.
CHAN_SET_MLOCK_LIMIT_POSITIVE
	Parâmetro para MLOCK +l deve ser um número positivo.
CHAN_SET_MLOCK_UNKNOWN_CHAR
	Modo %c é desconhecido e foi ignorado.
CHAN_MLOCK_CHANGED
	Modos do canal %s alterados para %s.
CHAN_MLOCK_REMOVED
	Modos do canal %s removidos.

# SET KEEPTOPIC responses
CHAN_SET_KEEPTOPIC_SYNTAX
	SET canal KEEPTOPIC {ON | OFF}
CHAN_SET_KEEPTOPIC_ON
	Opção de retenção de tópico está ativada.
CHAN_SET_KEEPTOPIC_OFF
	Opção de retenção de tópico está desativada.

# SET TOPICLOCK responses
CHAN_SET_TOPICLOCK_SYNTAX
	SET canal TOPICLOCK {ON | OFF}
CHAN_SET_TOPICLOCK_ON
	Opção de bloqueio do tópico está ativada.
CHAN_SET_TOPICLOCK_OFF
	Opção de bloqueio do tópico está desativada.

# SET PRIVATE responses
CHAN_SET_PRIVATE_SYNTAX
	SET canal PRIVATE {ON | OFF}
CHAN_SET_PRIVATE_ON
	Opção private está ativada.
CHAN_SET_PRIVATE_OFF
	Opção private está desativada.

# SET SECUREOPS responses
CHAN_SET_SECUREOPS_SYNTAX
	SET canal SECUREOPS {ON | OFF}
CHAN_SET_SECUREOPS_ON
	Opção Secure ops está ativada.
CHAN_SET_SECUREOPS_OFF
	Opção Secure ops está desativada.

# SET LEAVEOPS responses
CHAN_SET_LEAVEOPS_SYNTAX
	SET canal LEAVEOPS {ON | OFF}
CHAN_SET_LEAVEOPS_ON
	Opção LEAVE OPS está ativada.
CHAN_SET_LEAVEOPS_OFF
	Opção LEAVE OPS está desativada.

# SET RESTRICTED responses
CHAN_SET_RESTRICTED_SYNTAX
	SET canal RESTRICTED {ON | OFF}
CHAN_SET_RESTRICTED_ON
	Opção de acesso restrito está ativada.
CHAN_SET_RESTRICTED_OFF
	Opção de acesso restrito está desativada.

# SET OPNOTICE responses
CHAN_SET_OPNOTICE_SYNTAX
	SET canal OPNOTICE {ON | OFF}
CHAN_SET_OPNOTICE_ON
	Opção Op-Notice foi ativada.
CHAN_SET_OPNOTICE_OFF
	Opção Op-Notice foi desativada.

# SET NOLINKS responses
CHAN_SET_NOLINKS_SYNTAX
	SET canal NOLINKS {ON | OFF}
CHAN_SET_NOLINKS_ON
	Opção NOLINKS foi ativada.
CHAN_SET_NOLINKS_OFF
	Opção NOLINKS foi desativada.

# SET NOEXPIRE responses
CHAN_SET_NOEXPIRE_SYNTAX
	SET canal NOEXPIRE {ON | OFF}
CHAN_SET_NOEXPIRE_ON
	Canal %s não irá expirar.
CHAN_SET_NOEXPIRE_OFF
	Canal %s irá expirar.

# ACCESS messages
CHAN_ACCESS_SYNTAX
	ACCESS canal {ADD|DEL|LIST} [nick [nível] | número_de_entrada]
CHAN_ACCESS_DISABLED
	Pedimos desculpa. A modificação da lista de acesso do canal está
	temporariamente desativada.
CHAN_ACCESS_LEVEL_NONZERO
	Nível de acesso deve ser diferente de zero.
CHAN_ACCESS_LEVEL_RANGE
	Nível de acesso deve estar entre %d e %d.
CHAN_ACCESS_NICKS_ONLY
	Listas de acesso de canais devem conter apenas nicks registrados.
CHAN_ACCESS_REACHED_LIMIT
	Pedimos desculpa. Mas só pode ter %d entradas de acesso num canal.
CHAN_ACCESS_LEVEL_UNCHANGED
	Nível de acesso de %s no canal %s não foi mudado de %d.
CHAN_ACCESS_LEVEL_CHANGED
	Nível de acesso para %s no canal %s mudado de %d para %d.
CHAN_ACCESS_ADDED
	%s adicionado a lista de acesso do canal %s com nível %d.
CHAN_ACCESS_NO_SUCH_ENTRY
	Entrada desconhecida (#%d) na lista de acesso do canal %s.
CHAN_ACCESS_NOT_FOUND
	%s não foi encontrado na lista de acesso do canal %s.
CHAN_ACCESS_NO_MATCH
	Nenhuma entrada encontrada na lista de acesso do %s.
CHAN_ACCESS_DELETED
	%s apagado da lista de acesso do canal %s.
CHAN_ACCESS_DELETED_ONE
	Apagada uma entrada da lista de acesso do %s.
CHAN_ACCESS_DELETED_SEVERAL
	Apagadas %d entradas da lista de acesso do %s.
CHAN_ACCESS_LIST_EMPTY
	Lista de acesso do %s está vazia.
CHAN_ACCESS_LIST_HEADER
	Lista de acesso do canal %s:
	  Núm   Nív  Nick
CHAN_ACCESS_LIST_FORMAT
	  %3d  %4d  %s%s%s%s


# AOP/SOP error response
CHAN_NO_AOP_SOP
	Para designar privilégios de um canal para um usuário, utilize o
	comando ACCESS; digite /%s HELP ACCESS para mais informações.

# AKICK responses
CHAN_AKICK_SYNTAX
	AKICK canal {ADD | DEL | LIST} [nick-ou-hostname]
CHAN_AKICK_DISABLED
	Pedimos desculpa. A alteração da lista de autokicks do canal está
	temporariamente desativada.
CHAN_AKICK_ALREADY_EXISTS
	%s já existe na lista de autokicks do canal %s.
CHAN_AKICK_REACHED_LIMIT
	Pedimos desculpa. Mas deve ter %d hostnames na lista de autokicks do canal.
CHAN_AKICK_ADDED
	%s adicionado a lista de autokicks do canal %s.
CHAN_AKICK_NO_SUCH_ENTRY
	Entrada desconhecida (#%d) na lista de autokicks do canal %s.
CHAN_AKICK_NOT_FOUND
	%s não foi encontrado na lista de autokicks do canal %s.
CHAN_AKICK_NO_MATCH
	Nenhuma entrada encontrada na lista de autokick do %s.
CHAN_AKICK_DELETED
	%s retirado da lista de autokicks do canal %s.
CHAN_AKICK_DELETED_ONE
	Apagada uma entrada da lista de autokick do %s.
CHAN_AKICK_DELETED_SEVERAL
	Apagada %d entradas da lista de autokick do %s.
CHAN_AKICK_LIST_EMPTY
	Lista de autokick do %s está vazia.
CHAN_AKICK_LIST_HEADER
	Lista de autokicks do canal %s:
CHAN_AKICK_LIST_FORMAT
	  %3d %s%s
CHAN_AKICK_LIST_FORMAT2
	  %3d %s por %s : %s

# LEVELS responses
CHAN_LEVELS_SYNTAX
	LEVELS canal {SET | DIS[ABLE] | LIST | RESET} [item [nível]]
CHAN_LEVELS_RANGE
	Nível deve estar entre %d e %d.
CHAN_LEVELS_CHANGED
	Nível de %s no canal %s alterado para %d.
CHAN_LEVELS_UNKNOWN
	Opção %s desconhecida. Digite /%s HELP LEVELS DESC para uma lista
	válida de opções.
CHAN_LEVELS_DISABLED
	%s desabilitado no canal %s.
CHAN_LEVELS_LIST_HEADER
	Configuração dos níveis de acesso do canal %s:
CHAN_LEVELS_LIST_DISABLED
	    %-*s  (desabilitado)
CHAN_LEVELS_LIST_FOUNDER
	    %-*s  (somente fundador)
CHAN_LEVELS_LIST_NORMAL
	    %-*s  %d
CHAN_LEVELS_RESET
	Níveis de acesso do canal %s foram refeitos usando os padrões.

# INFO responses
CHAN_INFO_SYNTAX
	INFO canal
CHAN_INFO_HEADER
	Informação sobre o canal %s :
CHAN_INFO_FOUNDER
	           Fundador: %s (%s)
CHAN_INFO_NO_FOUNDER
	           Fundador: %s
CHAN_INFO_DESCRIPTION
	          Descrição: %s
CHAN_INFO_TIME_REGGED
	         Registrado: %s [%s]
CHAN_INFO_LAST_USED
	         Última utilização: %s [%s]
CHAN_INFO_LAST_TOPIC
	      Último tópico: %s
CHAN_INFO_TOPIC_SET_BY
	Tópico inserido por: %s
CHAN_INFO_RECORD
	            Recorde: %d usuário(s) em %s [%s]
CHAN_INFO_USERS
	     Ocupação atual: %d usuário(s)
CHAN_INFO_URL
	                URL: %s
CHAN_INFO_EMAIL
	             E-mail: %s
CHAN_INFO_OPTIONS
	             Opções: %s
CHAN_INFO_NO_EXPIRE
	  Canc. do registro: Este canal não irá expirar.
CHAN_INFO_OPT_PRIVATE
	Privado
CHAN_INFO_OPT_KEEPTOPIC
	Retenção de tópico
CHAN_INFO_OPT_TOPICLOCK
	Bloqueamento do tópico
CHAN_INFO_OPT_SECUREOPS
	Proteção de ops
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
	LIST padrão
CHAN_LIST_HEADER
	Listas das entradas que satisfazem %s :
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
	Foi desbanido do canal %s.

# CLEAR responses
CHAN_CLEAR_SYNTAX
	CLEAR canal tipo
CHAN_CLEARED_BANS
	Todos os bans do canal %s foram removidos.
CHAN_CLEARED_MODES
	Todos os modos do canal %s foram removidos.
CHAN_CLEARED_OPS
	Modo +o dos operadores do canal %s foi retirado.
CHAN_CLEARED_VOICES
	Modo +v dos utilizadores do canal %s foi retirado.
CHAN_CLEARED_USERS
	Todos os utilizadores foram kickados do canal %s.

# GETPASS responses
CHAN_GETPASS_SYNTAX
	GETPASS canal
CHAN_GETPASS_UNAVAILABLE
	Comando GETPASS não está disponível porque a encriptação está em uso.
CHAN_GETPASS_PASSWORD_IS
	Senha do canal %s é %s.

# FORBID responses
CHAN_FORBID_SYNTAX
	FORBID canal
CHAN_FORBID_SUCCEEDED
	Canal %s está proibido de ser utilizado.
CHAN_FORBID_FAILED
	Não foi possível proibir o canal %s!

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
	Digite /%s READ LAST para ler.
MEMO_TYPE_READ_NUM
	Digite /%s READ %d para ler.
MEMO_TYPE_LIST_NEW
	Digite /%s LIST NEW para listar todas as mensagens.
MEMO_AT_LIMIT
	Atenção: Atingiu o limite máximo de mensagens (%d).
	Não poderá receber mais nenhuma mensagem antes de apagar alguma das suas
	atuais.
MEMO_OVER_LIMIT
	Atenção: Está acima do limite máximo de mensagens (%d).
	Não poderá receber mais nenhuma mensagem antes de apagar alguma das suas
	atuais.
MEMO_NEW_MEMO_ARRIVED
	Tem uma nova mensagem de %s.
	Digite /%s READ %d  para ler.

# Multi-use responses
MEMO_HAVE_NO_MEMOS
	Não tem mensagens.
MEMO_X_HAS_NO_MEMOS
	%s não tem mensagens.
MEMO_DOES_NOT_EXIST
	Mensagem %d não existe!
MEMO_LIST_NOT_FOUND
	Nenhuma mensagem encontrada.

# SEND responses
MEMO_SEND_SYNTAX
	SEND {nick | canal} mensagem-texto
MEMO_SEND_DISABLED
	Pedimos desculpa. O envio de mensagens está temporariamente desativado.
MEMO_SEND_PLEASE_WAIT
	Por favor espere %d segundos antes de usar o comando SEND novamente.
MEMO_X_GETS_NO_MEMOS
	%s não pode receber mensagens.
MEMO_X_HAS_TOO_MANY_MEMOS
	%s atualmente tem muitas mensagens e não pode receber mais.
MEMO_SENT
	Mensagem enviada para %s.

# LIST responses
MEMO_LIST_SYNTAX
	LIST [canal] [list | NEW]
MEMO_HAVE_NO_NEW_MEMOS
	Não tem novas mensagens.
MEMO_X_HAS_NO_NEW_MEMOS
	%s não tem novas mensagens.
MEMO_LIST_MEMOS
	Mensagens para %s. Para ler, digite: /%s READ número
MEMO_LIST_NEW_MEMOS
	Novas mensagens para %s. Para ler, digite: /%s READ número
MEMO_LIST_CHAN_MEMOS
	Mensagens para o canal %s. Para ler, digite: /%s READ %s número
MEMO_LIST_CHAN_NEW_MEMOS
	Novas mensagens para o canal %s. Para ler, digite: /%s READ %s número
MEMO_LIST_HEADER
	 Núm  Remetente         Data/Hora
MEMO_LIST_FORMAT
	%c%3d  %-16s  %s "%s..."

# READ responses
MEMO_READ_SYNTAX
	READ [canal] {list | LAST | NEW}
MEMO_HEADER
	Mensagem %d de %s (%s). Para apagar, digite: /%s DEL %d
MEMO_CHAN_HEADER
	Mensagem %d de %s (%s). Para apagar, digite: /%s DEL %s %d
MEMO_TEXT
	%s

# DEL responses
MEMO_DEL_SYNTAX
	DEL [canal] {núm | list | ALL}
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
	SET opção parâmetros
MEMO_SET_DISABLED
	Pedimos desculpa. O sistema de mensagens está temporariamente desativado.
MEMO_SET_UNKNOWN_OPTION
	Opção SET %s desconhecida.

# SET NOTIFY responses
MEMO_SET_NOTIFY_SYNTAX
	SET NOTIFY {ON | LOGON | NEW | OFF}
MEMO_SET_NOTIFY_ON
	%s notificará sobre mensagens quando se conectar e quando enviadas à
	você.
MEMO_SET_NOTIFY_LOGON
	%s notificará sobre as suas mensagens quando se conectar ou sair de um
	/AWAY.
MEMO_SET_NOTIFY_NEW
	%s notificará sobre as suas mensagens quando elas lhe forem enviadas.
MEMO_SET_NOTIFY_OFF
	%s não notificará sobre qualquer aviso de mensagens.

# SET LIMIT responses
MEMO_SET_LIMIT_SYNTAX
	SET LIMIT [canal] limite
MEMO_SET_LIMIT_SERVADMIN_SYNTAX
	SET LIMIT [usuário | canal] {limit | NONE} [HARD]
MEMO_SET_YOUR_LIMIT_FORBIDDEN
	Não está apto a alterar o limite de mensagens.
MEMO_SET_LIMIT_FORBIDDEN
	O limite de mensagens para %s não pode ser alterado.
MEMO_SET_YOUR_LIMIT_TOO_HIGH
	Não pode alterar o seu limite de mensagens acima de %d.
MEMO_SET_LIMIT_TOO_HIGH
	Não pode alterar o limite de mensagens de %s acima de %d.
MEMO_SET_LIMIT_OVERFLOW
	Limite de mensagens muito alto; limitado para %d.
MEMO_SET_YOUR_LIMIT
	O limite de mensagens foi alterado para %d.
MEMO_SET_YOUR_LIMIT_ZERO
	Não está apto a receber mensagens.
MEMO_UNSET_YOUR_LIMIT
	O limite de mensagens foi desativado.
MEMO_SET_LIMIT
	Limite de mensagens para %s alterado para %d.
MEMO_SET_LIMIT_ZERO
	Limite de mensagens para %s alterado para 0.
MEMO_UNSET_LIMIT
	Limite de mensagens para %s está desativado.

# INFO responses
MEMO_INFO_SYNTAX
	INFO [canal]
MEMO_INFO_SERVADMIN_SYNTAX
	INFO [nick | canal]
MEMO_INFO_NO_MEMOS
	Não tem mensagens.
MEMO_INFO_MEMO
	Tem uma mensagem.
MEMO_INFO_MEMO_UNREAD
	Atualmente tem uma mensagem, que ainda não foi lida.
MEMO_INFO_MEMOS
	Atualmente tem %d mensagens.
MEMO_INFO_MEMOS_ONE_UNREAD
	Atualmente tem %d mensagens, das quais uma não foi lida.
MEMO_INFO_MEMOS_SOME_UNREAD
	Atualmente tem %d mensagens, das quais %d não foram lidas.
MEMO_INFO_MEMOS_ALL_UNREAD
	Tem %d mensagens; nenhuma lida.
MEMO_INFO_LIMIT
	O seu limite de mensagens é %d.
MEMO_INFO_HARD_LIMIT
	O seu limite de mensagens é %d, e não pode ser mudado.
MEMO_INFO_LIMIT_ZERO
	O seu limite de mensagens é 0 ; não pode receber nenhuma mensagem.
MEMO_INFO_HARD_LIMIT_ZERO
	O seu limite de mensagens é 0 ; não pode receber nenhuma mensagem, e não
	pode mudar este limite.
MEMO_INFO_NO_LIMIT
	Não tem limite para as mensagens que poderá possuir.
MEMO_INFO_X_NO_MEMOS
	%s não tem mensagens.
MEMO_INFO_X_MEMO
	%s tem atualmente uma mensagem.
MEMO_INFO_X_MEMO_UNREAD
	%s tem atualmente uma mensagem, ainda não lida.
MEMO_INFO_X_MEMOS
	%s tem atualmente %d mensagens.
MEMO_INFO_X_MEMOS_ONE_UNREAD
	%s tem atualmente %d mensagens,  uma  não lida.
MEMO_INFO_X_MEMOS_SOME_UNREAD
	%s tem atualmente %d mensagens,  %d  não lidas.
MEMO_INFO_X_MEMOS_ALL_UNREAD
	%s tem atualmente %d mensagens; nenhuma lida.
MEMO_INFO_X_LIMIT
	O limite de mensagens de %s é %d.
MEMO_INFO_X_HARD_LIMIT
	O limite de mensagens de %s é %d e não pode ser mudado.
MEMO_INFO_X_NO_LIMIT
	%s não tem limite de mensagens.

###########################################################################
#
# Mensagens do OperServ
#
###########################################################################

# General messages
OPER_BOUNCY_MODES
	Services não estão a conseguir mudar modos.
	Servidores estão configurados corretamente?
OPER_BOUNCY_MODES_U_LINE
	Services não estão a conseguir mudar modos.
	As U:lines dos seus servidores estão configuradas corretamente?

# GLOBAL responses
OPER_GLOBAL_SYNTAX
	GLOBAL mensagem

# STATS responses
OPER_STATS_UNKNOWN_OPTION
	Opção STATS %s desconhecida.
OPER_STATS_CURRENT_USERS
	Usuários atuais   :  %d  (%d  IRCops, %d Helpers, %d Bots)
OPER_STATS_MAX_USERS
	Máximo de usuários:  %d
# This is ugly, but at least it's language-portable...
OPER_STATS_UPTIME_DHMS
	Services ativos há %d dias, %02d:%02d
OPER_STATS_UPTIME_1DHMS
	Services ativos há %d dia, %02d:%02d
OPER_STATS_UPTIME_HMS
	Services ativos há %d horas, %d minutos
OPER_STATS_UPTIME_HM1S
	Services ativos há %d horas, %d minutos
OPER_STATS_UPTIME_H1MS
	Services ativos há %d horas, %d minuto
OPER_STATS_UPTIME_H1M1S
	Services ativos há %d horas, %d minuto
OPER_STATS_UPTIME_1HMS
	Services ativos há %d hora, %d minutos
OPER_STATS_UPTIME_1HM1S
	Services ativos há %d hora, %d minutos
OPER_STATS_UPTIME_1H1MS
	Services ativos há %d hora, %d minuto
OPER_STATS_UPTIME_1H1M1S
	Services ativos há %d hora, %d minuto
OPER_STATS_UPTIME_MS
	Services ativos há %d minutos, %d segundos
OPER_STATS_UPTIME_M1S
	Services ativos há %d minutos, %d segundo
OPER_STATS_UPTIME_1MS
	Services ativos há %d minuto, %d segundos
OPER_STATS_UPTIME_1M1S
	Services ativos há %d minuto, %d segundo
OPER_STATS_USER_MEM
	Usuários: %6d registros, %5d kB
OPER_STATS_CHANNEL_MEM
	Canal   : %6d registros, %5d kB
OPER_STATS_NICKSERV_MEM
	NickServ: %6d registros, %5d kB
OPER_STATS_CHANSERV_MEM
	ChanServ: %6d registros, %5d kB
OPER_STATS_OPERSERV_MEM
	OperServ: %6d registros, %5d kB
OPER_STATS_AKILL_COUNT
	Número atual de AKILLs: %d
OPER_STATS_AKILL_EXPIRE_DAYS
	Tempo default para expirar AKILL: %d dias
OPER_STATS_AKILL_EXPIRE_DAY
	Tempo default para expirar AKILL: 1 dia
OPER_STATS_AKILL_EXPIRE_HOURS
	Tempo default para expirar AKILL: %d horas
OPER_STATS_AKILL_EXPIRE_HOUR
	Tempo default para expirar AKILL: 1 hora
OPER_STATS_AKILL_EXPIRE_MINS
	Tempo default para expirar AKILL: %d minutos
OPER_STATS_AKILL_EXPIRE_MIN
	Tempo default para expirar AKILL: 1 minuto
OPER_STATS_AKILL_EXPIRE_NONE
	Tempo default para expirar AKILL: Não irá expirar.

# ADMIN responses
OPER_ADMIN_SYNTAX
	ADMIN {ADD | DEL | LIST} [nick]
OPER_ADMIN_ADD_SYNTAX
	ADMIN ADD nick
OPER_ADMIN_DEL_SYNTAX
	ADMIN DEL nick
OPER_ADMIN_SKELETON
	Services estão no modo skeleton; o comando ADMIN não está disponível.
OPER_ADMIN_EXISTS
	%s já está na lista de Administradores dos Services.
OPER_ADMIN_ADDED
	%s adicionado a lista de Administradores dos Services.
OPER_ADMIN_TOO_MANY
	Muitas entradas (%d) na lista dos Administradores dos Services é impossível
	adicionar mais.
OPER_ADMIN_REMOVED
	%s foi removido da lista dos Administradores dos Services.
OPER_ADMIN_NOT_FOUND
	%s não foi encontrado na lista dos Administradores dos Services.
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
	Services estão no modo skeleton, o comando OPER não está disponível.
OPER_OPER_EXISTS
	%s já existe na lista dos Operadores dos Services.
OPER_OPER_ADDED
	%s adicionado a lista de Operadores dos Services.
OPER_OPER_TOO_MANY
	Muitas entradas (%d) na lista dos Operadores dos Services é impossível
	adicionar mais.
OPER_OPER_REMOVED
	%s removido da lista de Operadores dos Services.
OPER_OPER_NOT_FOUND
	%s não encontrado na lista de Operadores dos Services.
OPER_OPER_LIST_HEADER
	Lista de Operadores dos Services:

# MODE responses
OPER_MODE_SYNTAX
	MODE canal modos

# CLEARMODES responses
OPER_CLEARMODES_SYNTAX
	CLEARMODES canal [ALL]
OPER_CLEARMODES_DONE
	Bans e modos binários do canal %s foram limpos.
OPER_CLEARMODES_ALL_DONE
	Todos os modos do canal %s foram limpos.

# KICK responses
OPER_KICK_SYNTAX
	KICK canal usuário razão

# AKILL responses
OPER_AKILL_SYNTAX
	AKILL {ADD | DEL | LIST | VIEW} [[+tempo] hostname [razão]]
OPER_AKILL_ADD_SYNTAX
	AKILL ADD [+tempo] hostname razão
OPER_AKILL_DEL_SYNTAX
	AKILL DEL hostname
OPER_AKILL_NO_NICK
	Lembre-se : hostnames de AKILL não podem conter nicks;
	tenha a certeza que não incluiu uma porção do nick no hostname.
OPER_TOO_MANY_AKILLS
	Lista de AKILL está cheia!
OPER_AKILL_ADDED
	%s adicionado na lista de AKILL.
OPER_AKILL_REMOVED
	%s removido da lista de AKILL.
OPER_AKILL_NOT_FOUND
	%s não encontrado na lista de AKILL.
OPER_AKILL_LIST_HEADER
	Lista de AKILL atual:
# mask, reason
OPER_AKILL_LIST_FORMAT
	%-32s  %s
# mask, set-by, set-time, expires, reason
OPER_AKILL_VIEW_FORMAT
	%s (pelo %s em %s; %s)
	    %s
OPER_AKILL_NO_EXPIRE
	Não irá expirar.
OPER_AKILL_EXPIRES_SOON
	expira na próxima atualização do banco de dados
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
	SET opção seleção
OPER_SET_IGNORE_ON
	Ignore code será usado.
OPER_SET_IGNORE_OFF
	Ignore code não será usado.
OPER_SET_IGNORE_ERROR
	Parâmetro para IGNORE deve ser ON ou OFF.
OPER_SET_READONLY_ON
	Services estão agora no modo read-only (somente-leitura).
OPER_SET_READONLY_OFF
	Services agora estão no modo leitura-escrita (read-write).
OPER_SET_READONLY_ERROR
	Parâmetro para READONLY deve ser ON ou OFF.
OPER_SET_DEBUG_ON
	Services estão agora no modo de debug.
OPER_SET_DEBUG_OFF
	Services estão no modo de non-debug.
OPER_SET_DEBUG_LEVEL
	Services estão no modo de debug (nível %d).
OPER_SET_DEBUG_ERROR
	Parâmetro para DEBUG deve ser ON, OFF ou um número positivo.
OPER_SET_UNKNOWN_OPTION
	Opção %s desconhecida.

# JUPE responses
OPER_JUPE_SYNTAX
	JUPE nome-do-servidor [razão]

# RAW responses
OPER_RAW_SYNTAX
	RAW texto

# UPDATE responses
OPER_UPDATING
	Atualizando banco de dados.

# RESTART responses
OPER_CANNOT_RESTART
	SERVICES_BIN não definido, não é possível reiniciar.
	Execute novamente o script CONFIGURE e recompile os Services para
	habilitar o comando RESTART.

# LISTIGNORE responses
OPER_IGNORE_LIST
	Lista de ignore dos Services:
OPER_IGNORE_LIST_EMPTY
	Lista de ignore está vazia.

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
	LOGONNEWS {ADD|DEL|LIST} [texto|número]
NEWS_LOGON_LIST_HEADER
	Mensagens de entrada:
NEWS_LOGON_LIST_ENTRY
	%5d (%s por %s)
	    %s
NEWS_LOGON_LIST_NONE
	Não existe nenhuma mensagem de entrada.
NEWS_LOGON_ADD_SYNTAX
	LOGONNEWS ADD texto
NEWS_LOGON_ADD_FULL
	Lista de mensagens está cheia!
NEWS_LOGON_ADDED
	Adicionada nova mensagem de entrada (#%d).
NEWS_LOGON_DEL_SYNTAX
	LOGONNEWS DEL {número | ALL}
NEWS_LOGON_DEL_NOT_FOUND
	Mensagem de entrada número %d não encontrada!
NEWS_LOGON_DELETED
	Mensagem de entrada número %d apagada.
NEWS_LOGON_DEL_NONE
	Não há mensagem de entrada para apagar!
NEWS_LOGON_DELETED_ALL
	Todas as mensagens de entrada apagadas.

NEWS_OPER_SYNTAX
	OPERNEWS {ADD|DEL|LIST} [texto|número]
NEWS_OPER_LIST_HEADER
	Oper news itens:
NEWS_OPER_LIST_ENTRY
	%5d (%s por %s)
	    %s
NEWS_OPER_LIST_NONE
	Não há oper news.
NEWS_OPER_ADD_SYNTAX
	OPERNEWS ADD texto
NEWS_OPER_ADD_FULL
	Lista de oper news está cheia!
NEWS_OPER_ADDED
	Adicionada nova oper news (#%d).
NEWS_OPER_DEL_SYNTAX
	OPERNEWS DEL {número | ALL}
NEWS_OPER_DEL_NOT_FOUND
	Oper news número %d não encontrada!
NEWS_OPER_DELETED
	Oper news número %d apagada.
NEWS_OPER_DEL_NONE
	Não há oper news para apagar!
NEWS_OPER_DELETED_ALL
	Todas as oper news foram apagadas.

NEWS_HELP_LOGON
	Sintaxe:  LOGONNEWS ADD texto
	          LOGONNEWS DEL {número | ALL}
	          LOGONNEWS LIST

	Edita ou mostra a lista de logon news. Quando um usuário
	se conecta à rede, estas mensagens são enviadas para o mesmo.
	(No entanto, não mais que três mensagens serão enviadas
	simultaneamente para evitar flood. Se houver mais que três
	mensagens novas, apenas essas mais novas serão mostradas.)

	LOGONNEWS LIST pode ser usado por qualquer IRC operator
	para listar as mensagens atuais. ADD e DEL só podem
	ser usados pelos Administradores dos Services.

NEWS_HELP_OPER
	Sintaxe:  OPERNEWS ADD texto
	          OPERNEWS DEL {número | ALL}
	          OPERNEWS LIST

	Edita ou mostra a lista de oper news. Quando um usuário
	se torna operador (pelo comando /OPER), estas mensagens
	serão enviadas. (No entanto, não mais que três
	mensagens serão enviadas simultaneamente para evitar
	flood. Se houver mais que três mensagens novas, apenas
	as três mais novas serão mostradas.)

	OPERNEWS LIST pode ser usado por qualquer IRC operator
	para listar as oper news. ADD e DEL só podem ser usados
	pelos Administradores dos Services.

###########################################################################
#
# Mensagens de help do NickServ
#
###########################################################################

NICK_HELP
	%S permite que "registre" um nick evitando que
	outras pessoas o utilizem. Se o nick não for usado por %d
	dias, o registro será removido. Os seguintes comandos
	permitem o registro e a manutenção dos nicks, para
	utilizá-los, digite /%S comando. Para mais informações
	sobre um comando, digite /%S HELP comando.

	    AJOIN      Modifica a lista de canais com entrada automática
	    REGISTER   Registra um nick
	    IDENTIFY   Identifica o seu nick com a sua senha
	    LINK       Faz uma ligação do seu nick com outro
	    SET        Altera opções do seu nick
	    DROP       Cancela o registro de um nick
	    LISTLINKS  Lista os nicks ligados ao seu nick
	    NOTES      Permite guardar anotações
	    GHOST      Cancela uma ligação do nick

	Outros comandos: UNLINK, INFO, LIST, STATUS

	NOTA: Este serviço tem a intenção de proporcionar um modo para
	que os usuários desta rede não tenham a identidade comprometida.
	Isto NÃO tem como fim facilitar o "roubo" dos nicks ou
	outras atitudes consideradas ilícitas. O abuso do %S
	resultará em, no mínimo, perda do(s) nick(s) abusivo(s).

NICK_HELP_EXPIRE_ZERO
	%S permite "registrar" um nick e impede que
	outros o utilizem. Os comandos seguintes permitem o
	registro e a manutenção dos nicks, para usá-los, digite
	/%S comando. Para mais informações sobre um
	comando específico, digite /%S HELP comando.

	   REGISTER  Registra um nick
	   IDENTIFY  Identifica o seu nick com a sua senha
	   LINK      Faz uma ligação do seu nick com outro
	   SET       Altera opções do seu nick
	   DROP      Cancela o registro de um nick

	Outros comandos: UNLINK, GHOST, INFO, LIST, STATUS

	NOTA: Este serviço tem a intenção de proporcionar um modo para que
	os usuários desta rede não tenham a sua identidade comprometida.
	Isto NÃO tem como fim facilitar o "roubo" dos nicks ou
	outras atitudes consideradas ilíticas. O abuso do %S resultará
	em, no mínimo, perda do(s) nick(s) abusivos.

NICK_HELP_REGISTER
	Sintaxe:  REGISTER senha email

	Registra o nick no banco de dados do %S.
	Se não possuir uma conta de email indique NOMAIL como email.
	Depois de ter o nick registrado, pode usar o comando
	SET para configurar as opções do seu nick como
	preferir. Certifique-se que guarda a sua senha durante
	o registro, precisará dela para fazer alterações no
	nick futuramente. (Lembre-se que maiúsculas diferem : FIDO,
	Fido, e fido são senhas diferentes!)

	Sugestões ao escolher sua senha:

	As senhas não devem ser de fácil acesso aleatório. Por exemplo,
	usar o nome como senha é uma péssima idéia. Utilizar o
	nick como senha é ainda uma idéia muito pior e, de fato, o %S
	não permitirá isso. Da mesma maneira, senhas curtas são
	vulneráveis a testes de brute-force, deve
	escolher uma senha com pelo menos 5 caracteres. Finalmente,
	o caracter "ESPAÇO" não pode ser usado em SENHAS.

NICK_HELP_IDENTIFY
	Sintaxe:  IDENTIFY senha

	Diz ao %S que realmente é o dono do nick.
	Muitos comandos exigem que se identifique com este
	comando antes de os poder usar. A senha é a mesma que
	enviou com o comando REGISTER.

NICK_HELP_DROP
	Sintaxe:  DROP

	Retira o seu nick do banco de dados do %S. O nick que
	foi retirado está livre para qualquer pessoa registrar
	novamente.

	Para utilizar este comando, tem que se identificar
	com a senha primeiro ( /%S HELP IDENTIFY para mais
	informações).

NICK_HELP_LINK
	Sintaxe: LINK nick senha

	Liga o seu nick a outro, efetivamente, fazendo uma ligação
	do nick atual com um outro nick especificado. Quando
	emite este comando, a lista de acesso do seu nick
	atualmente em uso é apagada e substituída pelo nick a
	que está a ligar-se, todos os memos do nick atual são
	adicionados na lista de memos do nick alvo (isso pode
	causar um excesso no limite de memos do nick, em alguns
	casos vai precisar de apagar alguns memos antes de poder
	receber mais de outra pessoa).

	Uma vez que a ligação seja estabilizada, o seu nick será
	transparentemente convertido para o nick alvo em todos
	os lugares dos Services, exceto para os comandos %S
	UNLINK e DROP.
	Por exemplo, pode usar um nick ou outro para ler
	o mesmo conjunto de memos (e mensagens enviadas para um nick
	ou outro irão para a mesma lista). Se você identificar
	para um nick, estará automaticamente identificado para o
	outro. Se um nick ou outro está na lista de acesso de um
	canal, ambos os nicks terão os mesmos privilégios de acesso.

	Para usar este comando, deve identificar o nick atual
	(usando o comando  IDENTIFY ), e deve fornecer a
	senha para o nick que deseja linkar.

NICK_HELP_UNLINK
	Sintaxe:  UNLINK [nick senha]

	Remove a ligação com outro nick. Quando uma ligação é
	removida, os modos de um nick e a lista de acesso do nick
	previamente ligado são copiados para o nick atual e podem
	ser independetemente alterados. As suas mensagens não são
	copiadas, todas as mensagens permanecerão armazenadas no
	nick anteriormente ligado.

	Informando nick e senha como parâmetros, pode desligar o seu
	nick do nick especificado.

NICK_HELP_SET
	Sintaxe:  SET opção parâmetros

	Altera várias opções do nick. A opção pode ser:

	    PASSWORD   Altera a senha do seu nick.
	    LANGUAGE   Altera a linguagem dos Services quando
	                  lhe são enviadas mensagens
	    URL        Associa um endereço URL ao seu nick
	    EMAIL      Associa um endereço de e-mail ao seu nick
	    LOCATION   Associa um local ao seu nick.
	    ICQNUMBER  Associa um número ICQ ao seu nick.
	    KILL       Esta proteção é agora obrigatória, não sendo
	               por isso configurável.
	    PRIVATE    Previne o seu nick de aparecer num /%S LIST.
	    HIDE       Esconde certas informações sobre o seu nick.
	    NEWSLETTER Ativa/desativa recepção de newsletter.

	Para usar este comando, deve primeiro estar identificado
	com a sua SENHA ( /%S HELP IDENTIFY para mais
	informações).

	Digite /%S HELP SET opção para mais informações
	sobre um comando específico.

NICK_HELP_SET_PASSWORD
	Sintaxe:  SET PASSWORD nova-senha

	Muda a senha que é utilizada para identificar o dono do
	nick.

NICK_HELP_SET_LANGUAGE
	Sintaxe:  SET LANGUAGE número

	Muda a linguagem que os Services usam ao enviar mensagens
	(por exemplo, quando responde a um comando que
	emite). O número deve ser escolhido da seguinte lista
	de línguas de apoio.


NICK_HELP_SET_URL
	Sintaxe:  SET URL url

	Associa um dado URL ao seu nick. Este URL será mostrado
	sempre que alguem solicitar informações sobre o seu nick
	através do comando INFO.

NICK_HELP_SET_EMAIL
	Sintaxe:  SET EMAIL endereço

	Associa um endereço de e-mail ao seu nick. Este
	endereço será sempre mostrado quando alguem solicitar
	informação sobre o seu nick através do comando INFO.

NICK_HELP_SET_KILL
	Sintaxe:  SET KILL {}

	Possibilita a proteção de KILL no seu nick. Com a proteção
	de KILL acionada, se outro utilizador tentar usar o seu nick,
	será dado 1 minuto para que este o mude, após isso, será
	forçadamente removido do IRC pelo %S.

	NOTA:
	Esta proteção é agora obrigatória, não sendo por isso configurável.

NICK_HELP_SET_SECURE
	Sintaxe:  SET SECURE {ON | OFF}

	Torna os recursos de segurança do %S ativos (ON) ou
	desativos (OFF) sobre um nick. Com o SECURE acionado,
	deve entrar com a sua senha antes de ser reconhecido
	como utilizador do nick, independentemente do fato do
	endereço constar na lista de acesso. Entretanto, se
	está na lista de acesso, o %S não irá dar auto-kill
	de acordo com os ajustes da opção KILL.

NICK_HELP_SET_PRIVATE
	Sintaxe:  SET PRIVATE {ON | OFF}

	Torna a opção de privacidade do %S sobre o seu nick
	ativa (ON) ou desativa (OFF). Com PRIVATE acionado,
	o seu nick não aparecerá nas listagens de nicks geradas com
	o comando %S LIST. (Entretanto, alguém que saiba o seu
	nick ainda pode obter informações utilizando o comando INFO ).

NICK_HELP_SET_HIDE
	Sintaxe:  SET HIDE {EMAIL | QUIT} {ON | OFF}

	Permite que previnir que certas informações sejam mostradas
	quando alguém faz um INFO ao seu nick. Pode esconder
	o endereço de e-mail (EMAIL), e a última mensagem de saída
	(QUIT). O segundo parâmetro especifica quando a informação
	deve ser ou não mostrada (OFF) (ON).

NICK_HELP_GHOST
	Sintaxe:  GHOST nick [senha]

	Elimina uma sessão "fantasma" de IRC que esteja utilizando o seu
	nick. A sessão "fantasma" é aquela que não está realmente
	conectada, mas que o servidor de IRC acredita estar ainda
	ativa por qualquer razão. Isso acontece normalmente quando o
	computador crasha ou se a sua ligação Internet ou modem cair
	por um período curto de tempo enquanto estiver no IRC.

	Para usar o comando GHOST num nick, o seu endereço atual
	como mostrado no /WHOIS deve pertencer a lista de acesso do
	nick, ou deve fornecer a senha correta para o nick.

NICK_HELP_INFO
	Sintaxe:  INFO nick

	Mostra a informação sobre o nick dado, como, o dono do nick,
	último endereço utilizado, tempo e opções.

NICK_HELP_LIST
	Sintaxe:  LIST padrão

	Lista todos os nicks registrados que combinam com o padrão
	fornecido no formato nick!ident@host. Nicks com a opção
	PRIVATE ligada não serão mostrados.

	Exemplos:

	     LIST *!bond@*.meuip.com.br
	        Lista todos os nicks de bond@*.meuip.com.br.

	     LIST *Bot*!*@*
	        Lista todos os nicks registados com Bot nos seus nomes.

	     LIST *!*@*.meuip.com.br
	        Lista todos os nicks do domínio meuip.com.br.

NICK_HELP_STATUS
	Sintaxe:  STATUS nick

	Retorna se o utilizador que está a utilizar um determinado nick
	é reconhecido como dono do nick. A resposta tem este formato:

	    nickname código-de-status

	onde nickname e o nick enviado com o comando, e
	código-de-status é um dos seguintes:

	    0 - utilizador não está conectado ou o nick não está registrado
	    1 - utilizador não reconhecido como dono do nick
	    2 - utilizador reconhecido como dono só pela lista de acesso
	    3 - utilizador reconhecido como dono via identificação por senha

	Até dezesseis nicks podem ser enviados com cada comando, o
	resto será ignorado. Não é gerada mensagem de erro se nenhum
	nick for fornecido.

NICK_SERVADMIN_HELP

	Os comandos abaixo estão disponíveis para Administradores dos
	Services :

	     GETPASS     Recupera a senha de um nick
	                   (se a encriptação está desativada)
	     FORBID      Previne um nick de ser usado
	     LISTLINKS   Lista os nicks ligados a um determinado nick.

	Administradores dos Services podem também cancelar registro
	de qualquer nick sem a necessidade de identificação e podem
	ver a lista de ajoin de qualquer nick
	( /%S AJOIN LIST nick ).

NICK_SERVADMIN_HELP_DROP
	Sintaxe:  DROP [nick]

	Sem parâmetros, cancela o registro do seu nick no banco de
	dados do %S.

	Com parâmetros, cancela o registro de um nick especificado
	do banco de dados.
	Este comando é restrito aos Administradores dos Services.

NICK_SERVADMIN_HELP_UNLINK

	Os Administradores dos Services podem desfazer uma ligação sem
	precisar da senha.

NICK_HELP_LISTLINKS
	Sintaxe:  LISTLINKS

	Lista os nicks ligados a um determinado nick.

NICK_SERVADMIN_HELP_LISTLINKS
	Sintaxe:  LISTLINKS nick [ALL]

	Lista os nicks ligados a um determinado nick. Se ALL é
	fornecido, lista todos os nicks com os mesmos privilégios de
	um determinado nick, caso contrário, lista apenas os nicks
	que estão ligados ao nick especificado.

NICK_SERVADMIN_HELP_SET

	Administradores dos Services podem ajustar a opção NOEXPIRE,
	com a qual os nicks podem ser protegidos de expirar.
	E ainda, Administradores dos Services, podem ajustar opções
	para qualquer nick sem se identificar com a senha, usando o
	SET nick opção parâmetros.

NICK_SERVADMIN_HELP_SET_NOEXPIRE
	Sintaxe:  SET nick NOEXPIRE {ON | OFF}

	Determina se um nick fornecido poderá ser expirado.
	Ajustando este para ON, evita que o nick seja expirado.

	Limitado aos Administradores dos Services.

NICK_SERVADMIN_HELP_LIST
	Sintaxe:  LIST padrão [FORBIDDEN] [NOEXPIRE]

	Lista todos os nicks registrados que combinem com o padrão
	fornecido (formato nick!user@host). Nicks com opção PRIVATE
	serão somente exibidos para os Administradores dos Services.
	Nicks com opção NOEXPIRE ajustada terão um ! preposto ao nick
	na lista quando for a pedido de Administrador dos Services.
	Se as opções FORBIDDEN ou NOEXPIRE forem fornecidas, somente os
	nicks proibidos (forbidden) ou os que tem a flag NOEXPIRE serão
	exibidos, respectivamente. Se ambas as opções são fornecidas,
	ambos os tipos de nicks serão exibidos.

	Essas opções são limitadas aos Administradores dos Services.

	Exemplos:

	     LIST *!bond@ab1-23.meuip.com.br
	        Lista todos os nicks de bond@ab1-23.meuip.com.br.

	     LIST *Bot*!*@*
	        Lista todos os nicks registrados com Bot em seus nomes.

	     LIST * NOEXPIRE
	        Lista todos os nicks registrados cujos registros foram
	        ajustados para não expirar.

NICK_SERVADMIN_HELP_GETPASS
	Sintaxe:  GETPASS nick

	Mostra a senha de um nick especificado.
	Note que sempre que este comando for usado, uma mensagem
	incluindo o nick da pessoa que emitiu o comando o nick
	requisitado será gravado e enviado para WALLOPS/GLOBOPS.

	Limitado aos Administradores dos Services.

	Este comando não é disponível quando a encriptação está habilitada.

NICK_SERVADMIN_HELP_FORBID
	Sintaxe:  FORBID nick

	Não permite que um nick seja registrado ou usado por
	ninguém. Pode ser cancelado desregistrando o nick.

	Limitado aos Administradores dos Services.

###########################################################################
#
# Mensagens de help do ChanServ
#
###########################################################################

CHAN_HELP
	%S permite que registre e controle vários
	aspectos do canal. %S pode prevenir o "take over"
	do canal de users maliciosos limitando quem possui
	o privilégio de OP do canal. Os comandos disponíveis
	estão listados abaixo.
	Para usá-los, digite /%S comando.
	Para mais informações de um comando, digite
	/%S HELP comando.

	    REGISTER   Registra um canal
	    IDENTIFY   Identifica com uma senha
	    SET        Altera as opções e informações do canal
	    ACCESS     Modifica a lista de users privilegiados
	    AOP/SOP    Aliases para gestão da lista de acesso
	    LEVELS     Redefine os níveis de acesso
	    AKICK      Faz a manutenção da Lista de Autokick
	    DROP       Cancela o registro de um canal

	Outros comandos: INFO, LIST, INVITE, OP, DEOP, UNBAN,
	                 KICK, CLEAR

CHAN_HELP_EXPIRES

	Note que qualquer canal não utilizado por %d dias
	(entenda como se nenhum usuário da lista de acesso
	desse canal entrar neste período de tempo) terá
	automaticamente cancelado o seu registro.

CHAN_HELP_REGISTER
	Sintaxe:  REGISTER canal senha descrição

	Registra um canal no banco de dados do %S. Para
	utilizar este comando, deve primeiro ser OP do
	canal que está a tentar registrar. A senha é usada
	com o comando IDENTIFY e permitirá que faça
	mudanças nas opções do canal futuramente. O último
	parâmetro que deve ser incluído, é uma breve
	descrição do propósito do canal.

	Quando registra um canal, será registrado
	como o "fundador" do canal. O fundador do canal tem
	permissão para mudar todas as opções do canal, o %S
	também irá dar ao fundador automaticamente o privilégio
	de OP do canal quando ele/ela entra no canal. Veja o
	comando ACCESS ( /%S HELP ACCESS ) para
	informações dos subconjuntos destes privilégios para
	outros users do canal.

	IMPORTANTE: Para registrar um canal, deve antes ter
	registrado seu nick. Se ainda não, digite /%s HELP
	para mais informações de como fazê-lo.

CHAN_HELP_IDENTIFY
	Sintaxe:  IDENTIFY canal senha

	Identifica no %S como fundador do canal fornecido.
	Muitos comandos exigem que use este comando antes
	de usá-los. A senha deverá ser a mesma que usou
	no comando REGISTER.

CHAN_HELP_DROP
	Sintaxe:  DROP #canal

	Cancela o registro do canal. Só poder ser usado pelo
	fundador do canal, que primeiramente deverá usar o
	comando IDENTIFY.

CHAN_HELP_SET
	Sintaxe:  SET canal opção parâmetros

	Permite ao fundador do canal alterar as várias opções do
	canal e outras informações. O fundador deve utilizar o
	comando IDENTIFY antes de usar o SET.

	Comandos disponíveis:

	    FOUNDER     Altera o fundador do canal
	    SUCCESSOR   Altera o sucessor do canal
	    PASSWORD    Altera a senha do fundador
	    DESC        Altera a descrição do canal
	    URL         Associa uma URL a um canal
	    EMAIL       Associa um e-mail a um canal
	    ENTRYMSG    Altera a mensagem que deve ser mandada
	                aos usuários quando eles entram no canal.
	    TOPIC       Altera o tópico do canal
	    KEEPTOPIC   Mantem o tópico quando o canal
	                não está em uso.
	    TOPICLOCK   O tópico pode ser mudado apenas
	                com o SET TOPIC.
	    MLOCK       Liga ou desliga o bloqueio dos modos do canal
	    PRIVATE     Esconde o canal do comando LIST
	    RESTRICTED  Acesso restrito ao canal
	    SECUREOPS   Rigoroso controle de status de OP
	    LEAVEOPS    Nunca tira (de-op) op dos users exceto com
	                o comando DEOP.
	    OPNOTICE    Envia uma notice quando os comandos OP/DEOP
	                são usados.
	    NOLINKS     Ignora reconhecimento de nível de acesso no canal
	                por nick links.

	Digite /%S HELP SET opções para maiores informações
	sobre uma opção em particular.

CHAN_HELP_SET_FOUNDER
	Sintaxe:  SET canal FOUNDER nick

	Muda o fundador do canal. O novo nick deve estar
	registrado.

CHAN_HELP_SET_SUCCESSOR
	Sintaxe:  SET canal SUCCESSOR nick

	Muda o sucessor de um canal. Se o nick do founder expirar
	ou estiver dropado enquanto o canal ainda estiver registrado,
	o sucessor se tornará o novo founder do canal.
	No entanto, se o sucessor possuir muitos canais registrados
	(%d), o canal será dropado, como se nenhum sucessor tivesse
	sido ajustado. O novo nick deverá estar registrado.

CHAN_HELP_SET_PASSWORD
	Sintaxe:  SET canal PASSWORD senha

	Altera a senha utilizada para identificação do
	fundador do canal.

CHAN_HELP_SET_DESC
	Sintaxe:  SET canal DESC descrição

	Altera a descrição para o canal, que é mostrada com
	os comandos LIST e INFO.

CHAN_HELP_SET_URL
	Sintaxe:  SET canal URL [url]

	Associa um URL ao canal. Este URL será mostrado
	sempre que alguém solicitar informação sobre o canal
	com o comando INFO. Se nenhum parâmetro for fornecido,
	apaga qualquer URL atualmente designada para o canal.

CHAN_HELP_SET_EMAIL
	Sintaxe:  SET canal EMAIL [endereço]

	Associa um endereço de e-mail fornecido ao canal.
	Este endereço será mostrado sempre que alguém solicitar
	informação sobre o canal com o comando INFO. Se nenhum
	parâmetro for fornecido, apaga qualquer endereço de e-mail
	do canal.

CHAN_HELP_SET_ENTRYMSG
	Sintaxe:  SET canal ENTRYMSG [mensagem]

	Altera a mensagem que será enviada via /notice para
	os users quando eles entrarem no canal. Se nenhum
	parâmetro é fornecido, nenhuma mensagem será enviada
	ao entrar no canal.

CHAN_HELP_SET_TOPIC
	Sintaxe:  SET canal TOPIC tópico

	Faz o %S mudar o tópico do canal pelo tópico dado.
	Este comando é muito mais útil em conjunto com o
	SET TOPICLOCK.

CHAN_HELP_SET_KEEPTOPIC
	Sintaxe:  SET canal KEEPTOPIC {ON|OFF}

	Ativa ou desativa a opção de retenção de tópico para
	um canal. Quando a retenção de tópico está acionada,
	o tópico para o canal será relembrado pelo %S mesmo
	depois de os users deixarem o canal, e será
	restaurado na próxima vez que o canal for re-aberto.

CHAN_HELP_SET_TOPICLOCK
	Sintaxe:  SET canal TOPICLOCK {ON|OFF}

	Ativa ou desativa a opção que bloqueia o tópico de um canal.
	Quando o Bloqueio do tópico está ativado, o %S não permitirá
	a mudança do tópico do canal exceto pelo comando SET TOPIC.


CHAN_HELP_SET_MLOCK
	Sintaxe:  SET canal MLOCK modos

	Ajusta o parâmetro de bloqueio do modo para um canal. O %S
	permite que defina certos modos no canal a serem sempre ativos
	(ou desativos). Os modos podem ser i, k, l, m, n,
	p, s e t, cada um desses bloqueado como ativo, desativo
	ou não bloqueado. O parâmetro modos é usado exatamente do
	mesmo modo como o comando /MODE, isto é, modos seguidos
	de + são bloqueados como ativos, e modos seguidos de - são
	bloqueados como desativos.

	Cuidado: Se bloqueia uma senha, como no segundo exemplo
	abaixo, deveria também ajustar a opção RESTRICTED para
	o canal (veja HELP SET RESTRICTED), ou qualquer usuário
	que entra no canal que está vazio será capaz de ver a senha!

	Exemplos:

	     SET #canal MLOCK +nt-iklps
	        Bloqueia os modos n e t ativados, e os modos
	        i, k, l, p, s desligados. Modo m é livremente
	        deixado para ser ligado(on) ou desligado(off).

	     SET #canal MLOCK +knst-ilmp minha-senha
	        Bloqueia os modos k, n, s, t como ligados e os
	        modos i, l, m, p como desligados. Também bloqueia
	        a senha do canal como "minha-senha".

	     SET #canal MLOCK +
	        Elimina o bloqueio dos modos, todos os modos do
	        canal ficam livres para ser ativados ou desativados.

CHAN_HELP_SET_PRIVATE
	Sintaxe:  SET canal PRIVATE {ON|OFF}

	Ativa ou desativa a opção private para um canal. Quando
	private está ativada, um /%S LIST não irá incluir
	o canal em qualquer listagem.

CHAN_HELP_SET_RESTRICTED
	Sintaxe:  SET canal RESTRICTED {ON|OFF}

	Ativa ou desativa a opção de acesso restrito para um canal.
	Quando o acesso restrito estiver ativado, users que
	normalmente não possuem privilégios de OP no canal
	(users com nível negativo de acesso e, se secure ops
	estiver ativado, users que não pertencem a lista de
	acesso) serão imediatamente kickados e banidos do canal.

CHAN_HELP_SET_SECUREOPS
	Sintaxe:  SET canal SECUREOPS {ON|OFF}

	Ativa ou desativa a opção de segurança de ops para um canal.
	Quando secure-ops estiver ativada, os usuários que não
	estiverem na lista de acesso não poderão ter o status de OP.

CHAN_HELP_SET_LEAVEOPS
	Sintaxe:  SET canal LEAVEOPS {ON | OFF}

	Ativa e desativa a opção LEAVE OPS para um canal. Quando
	LEAVE OPS estiver ativado, o ChanServ nunca irá retirar op
	(de-op) do usuário no canal, exceto se o comando DEOP for
	usado.

CHAN_HELP_SET_OPNOTICE
	Sintaxe:  SET canal OPNOTICE {ON | OFF}

	Ativa e desativa a opção Op-Notice para um canal. Quando
	Op-Notice estiver ativado, o ChanServ enviará uma notice para
	o canal sempre que os comandos OP ou DEOP forem usados em
	um usuário no canal.

CHAN_HELP_SET_NOLINKS
	Sintaxe:  SET canal NOLINKS {ON | OFF}

	Ativa e desativa a opção NOLINKS para um canal. Quando
	NOLINKS estiver ativado, o ChanServ apenas reconhecerá o
	nick real com acesso no canal. Se o nick estiver linkado
	a outro presente na access list não será reconhecido como
	tal.

CHAN_HELP_ACCESS
	Sintaxe:  ACCESS canal ADD nick nível
	          ACCESS canal DEL {nick | entry-num | list | ALL}
	          ACCESS canal LIST [hostname | list]

	Faz manutenção da lista de acesso de um canal. A lista
	de acesso especifica que usuários tem permissão para
	o status de OP ou tem acesso aos comandos do %S em um
	canal. Níveis diferentes de usuários permitem acesso a
	diferentes subníveis de privilégios; /%S HELP ACCESS
	LEVELS para mais informações específicas. Por padrão,
	qualquer nick não presente na lista de acesso possui
	nível 0.

	O comando ACCESS ADD adiciona um nick ou hostname de um
	user na lista de acesso com o nível especificado, se o
	nick ou hostname já estiver presente na lista, o seu nível
	de acesso será alterado para o nível especificado.
	O nível especificado deve ser menor do que o user
	que emitiu o comando.

	O comando ACCESS DEL remove um nick especificado da lista
	de acesso. Se uma lista de números é fornecida, essas
	entradas são apagadas. (Veja o exemplo para LIST abaixo.)
	A utilização de ALL apagará todos os registros, esta opção
	apenas pode ser usada por utilizador com nível de founder.

	O comando ACCESS LIST mostra a lista de acesso do canal. Se
	uma hostname for fornecida, somente as entradas que combinarem
	com o padrão especificado na hostname serão mostradas. Se uma
	lista de numeros é fornecida, somente essas entradas serão
	mostradas, por exemplo:

	ACCESS #canal LIST 2-5,7-9
	   Lista as entradas de acesso numeradas de 2 a 5 e 7 a 9.

CHAN_HELP_ACCESS_LEVELS
	 Níveis de Acesso do Usuário

	Por padrão, os seguintes níveis de acesso são definidos:

	    Founder     Acesso total as funções do %S, OP automático
	                     quando entrar no canal. Note que
	                     somente uma pessoa pode ter o status
	                     fundador (não pode ser dado usando
	                     o comando ACCESS).
	         10       Acesso ao comando AKICK, OP automático.
	          5       OP automático.
	          3       Voice automático.
	          0       Sem privilégios especiais, pode-se tornar OP
	                     através de outros ops (a menos que
	                     secure-ops esteja ativada).
	         <0       Não pode ser OP.

	Esses níveis podem ser mudados, ou adicionar novos, usando o
	comando LEVELS; digite /%S HELP LEVELS para informações.

CHAN_HELP_AKICK
	Sintaxe:  AKICK canal ADD hostname [razão]
	          AKICK canal DEL [ hostname | ALL ]
	          AKICK canal LIST [hostname]

	Faz a manutenção da lista de AutoKick de um canal.
	Se um user que estiver na lista de AutoKick tentar
	entrar no canal, o %S banirá este user do canal,
	e depois o kickará.

	O comando AKICK ADD adiciona o usuário especificado ou
	hostname na lista de AutoKick. Se uma razão é dada com
	o comando, esta razão será usada quando o user for
	kickado, senão, a razão padrão será "Você foi banido deste
	canal.".

	O comando AKICK DEL remove um nick ou hostname da lista
	de AutoKick. Isso, entretanto, não remove qualquer ban
	colocado pelo AutoKick estes devem ser removidos
	manualmente. A opção ALL eliminará todas as entradas da
	lista de AutoKick, esta opção pode apenas ser utilizada
	por utilizadores com nível de founder.

	O comando AKICK LIST mostra a lista de AutoKick, ou
	opcionalmente, só os registros de AutoKick quem se
	encaixam com o padrão de uma hostname dada.

CHAN_HELP_LEVELS
	Sintaxe:  LEVELS canal SET tipo nível
	          LEVELS canal {DIS | DISABLE} tipo
	          LEVELS canal LIST
	          LEVELS canal RESET

	O comando LEVELS permite ajuste detalhado sobre o
	significado númerico dos níveis de acesso usados pelos
	canais. Com esse comando, pode definir o nível de
	acesso requerido pela maioria das funções do %S.
	(Os comandos SET FOUNDER e SET PASSWORD, assim como este
	comando, são sempre restritos ao fundador do canal).

	LEVELS SET permite que o nível de acesso para uma função ou
	grupo de funções sejam alterados. LEVELS DISABLE (ou DIS
	para encurtar) desabilita automaticamente os dispositivos ou
	não permite o acesso a funções para qualquer outra pessoa
	que não seja o fundador do canal. LEVELS LIST mostra os
	níveis atuais para cada função ou para um grupo de funções.
	LEVELS RESET  recoloca os níveis de acordo com o padrão de um
	canal recém-criado (veja HELP ACCESS LEVELS).

	Para lista de recursos e funções cujo níveis podem ser
	ajustados, veja HELP LEVELS DESC.

CHAN_HELP_LEVELS_DESC
	As seguintes características/funções são entendidas. Note
	que estes níveis para AUTODEOP e NOJOIN são os níveis máximos,
	enquanto que todos os outros são níveis mínimos.

CHAN_HELP_LEVELS_DESC_FORMAT
	    %-*s  %s

CHAN_HELP_INFO
	Sintaxe:  INFO canal

	Lista os dados referentes ao canal registrado dado, incluindo
	seu fundador, data do registro, última vez que foi usado,
	descrição e bloqueio dos modos (se existirem).

CHAN_HELP_LIST
	Sintaxe:  LIST padrão 

	Lista todos os canais registrados que combinam com o padrão
	dado. (Canais com opção PRIVATE ativada não serão listados).

CHAN_HELP_OP
	Sintaxe:  OP #canal nick

	Atribui status de Operador (modo +o) para o nick dado
	num determinado canal. Limitado aos users de nível 5,
	no mínino, do canal especificado.

CHAN_HELP_DEOP
	Sintaxe:  DEOP #canal nick 

	Remove o status de Operador (modo +o) do nick dado para
	um determinado canal. Limitado aos users de nível 5,
	no mínino, do canal especificado.

CHAN_HELP_KICK
	Sintaxe:  KICK #canal nick motivo

	Retira um utilizador de um canal, aplicando um KICK
	com o ChanServ especifificando o motivo.
	Por defeito está limitado aos users com nível 5
	no mínimo.

CHAN_HELP_INVITE
	Sintaxe:  INVITE #canal

	Manda o %S dar um invite para o canal dado.
	Somente funcionará se seu nível de acesso for maior
	que zero.
CHAN_HELP_UNBAN
	Sintaxe:  UNBAN #canal

	Diz ao %S para remover todos os bans permitindo que
	você entre num canal. Por padrão, somente funciona
	se seu nível de acesso no canal for maior que zero.

CHAN_HELP_CLEAR
	Sintaxe:  CLEAR canal opção

	Diz ao %S para remover certas colocações de um canal.
	A opção pode ser uma das seguintes:

	     MODES    Anula todos os modos do canal (isto é, remove
	                  os modos i,k,l,m,n,p,s,t).
	     BANS     Remove todos os bans do canal.
	     OPS      Remove o status de Operador do canal (mode +o)
	                  de todos os Operadores do canal.
	     VOICES   Remove o status "voice" (mode +v) de qualquer
	                  pessoa que tenha esse modo.
	     USERS    Remove (kicka) todos os usuários do canal.

	Por padrao, seu nível de acesso no canal dever ser no
	mínimo 10 para usar este comando.

CHAN_SERVADMIN_HELP

	Os seguintes comandos estão disponíveis para
	os  Administradores dos Services :

	    GETPASS    Recupera a senha de fundador de um canal
	               (somente se a encriptação está desativada).
	    FORBID     Proíbe um canal de ser usado.
	    STATUS     Fornece o atual nível de acesso de um
	               usuário num canal.

	Administradores do Services podem também cancelar o registro sem
	a necessidade de identificação através da senha, podem ver os
	acessos, AKICK, e ajuste da lista de níveis de qualquer canal.

CHAN_SERVADMIN_HELP_DROP
	Sintaxe:  DROP canal

	Cancela o registro de um canal. Somente Administradores dos
	Services podem cancelar canais para os quais eles não tenham
	sido identificados.

CHAN_SERVADMIN_HELP_SET

	Administradores dos Services também podem ajustar a opção
	NOEXPIRE, fazendo com que canais sejam impedidos de ter seu
	registro expirado. Administradores dos Services ainda podem
	ajustar opções para qualquer canal sem precisar da identificação
	do canal através da SENHA.

CHAN_SERVADMIN_HELP_SET_NOEXPIRE
	Sintaxe:  SET canal NOEXPIRE {ON | OFF}

	Determina se o canal poderá ter seu registro expirado.
	Ajustando para ON, evita que o canal seja desregistrado
	por passar do tempo de expiração.

	Limitado aos Administradores dos Services.

CHAN_SERVADMIN_HELP_LIST
	Sintaxe:  LIST padrão

	Lista todos os canais registrados que combinam com o
	padrão fornecido. Canais com opção PRIVATE ativada
	só serão mostrados aos Administradores dos Services.

CHAN_SERVADMIN_HELP_GETPASS
	Sintaxe:  GETPASS canal

	Mostra a SENHA de um canal. Note que toda a vez que esse
	este comando for usado, uma mensagem incluindo o nick da
	pessoa que emitiu o comando e o canal que foi dado serão
	gravados e enviados para WALLOPS/GLOBOPS.

	Limitado aos Administradores dos Services.

CHAN_SERVADMIN_HELP_FORBID
	Sintaxe:  FORBID canal

	Proíbe que qualquer pessoa registre e utilize o canal
	dado. Pode ser cancelado pelo desregistro do canal.

	Limitado aos Administradores dos Services.

CHAN_SERVADMIN_HELP_STATUS
	Mostra o nível de acesso atual de um determinado nick
	em um determinado canal. A resposta será no formato:

	    STATUS canal nick nível-de-acesso

	Se um erro ocorrer, a resposta será no formato:

	    STATUS ERROR mensagem-de-erro

###########################################################################
#
# Mensagens de help do MemoServ
#
###########################################################################

MEMO_HELP
	%S é um utilitário que permite aos usuários de IRC
	enviar curtas mensagens a outros users, mesmo
	que eles não estejam conectados no momento; ou
	aos canais(*). Ambos, destinatários e remetentes,
	devem possuir seu nick (ou canal) registrados para
	que possam enviar uma mensagem (memo).
	Os comandos do %S são:

	    SEND   Envia uma mensagem para um nick ou para um canal
	    LIST   Lista suas mensagens
	    READ   Lê a(s) mensagem(ns)
	    DEL    Apaga a(s) mensagem(ns)
	    SET    Altera opções relacionadas com as mensagens

	Digite /%S HELP <comando> para ajuda em qualquer um dos
	comandos acima.

	(*) Por padrão, qualquer usuário com no mínimo
	    nível 10 pode ler as mensagens do canal. Isto
	    pode ser alterado com o comando /%s LEVELS.

MEMO_HELP_SEND
	Sintaxe:  SEND {nick | canal} [?]mensagem

	Envia um memo ao nick ou ao canal determinado contendo
	a mensagem. Quando enviada para o destinatário, este
	receberá um aviso que possui uma nova mensagem. O nick/
	/canal de destino deverá estar registrado.
	A utilização do sinal ? no início da mensagem indica que
	pretende receber uma notificação quando o destinatário ler
	a sua mensagem. A notificação consiste num memo automático
	vindo do destinatário com a mensagem que enviou, entre
	os delimitadores -( )-

MEMO_HELP_LIST
	Sintaxe:  LIST [canal] [list | NEW]

	Lista quaisquer mensagens que tiver. Com NEW, lista apenas
	as novas mensagens (não lidas). Mensangens não lidas são marcadas
	com "*" a esquerda do número. Você também pode especificar uma
	lista de números, como no exemplo abaixo:
	LIST 2-5,7-9
	   Lista mensagens numeradas de 2 a 5 e de 7 a 9.

MEMO_HELP_READ
	Sintaxe: READ [canal] {num | list | LAST | NEW}

	Mostra as mensagens especificadas. Se LAST é fornecido, envia
	a mensagem recebida mais recentemente. Se NEW é fornecido,
	envia a todas as suas novas mensagens. Caso contrário, envia
	a uma mensagem numerada. Você também pode fornecer uma lista
	de números, como por exemplo:

	READ 2-5,7-9
	   Mostra as mensagens numeradas de 2 a 5 e 7 a 9.

MEMO_HELP_DEL
	Sintaxe: DEL [canal] {num | list | ALL}

	Apaga a(s) mensagem(ns) especificada(s). Você pode fornecer
	vários números de mensagens ou seqüências de números ao invés
	de um único número, como no segundo exemplo abaixo.

	Se ALL é fornecido, apaga todas suas mensagens.

	Exemplos:

	    DEL 1
	      Apaga a primeira mensagem.

	    DEL 2-5,7-9
	      Apaga as mensagens numeradas de 2 a 5 e de 7 a 9.

MEMO_HELP_SET
	Sintaxe:  SET opção parâmetros

	Altera várias opções de mensagens. Opção pode ser uma dessas:

	    NOTIFY      Muda quando for notificado sobre novas
	                    mensagens (só para nicks)
	    LIMIT       Altera o número maximo de mensagens que você
	                    pode receber.

	Digite /%S HELP SET <comando>, para mais informações sobre
	um comando específico.

MEMO_HELP_SET_NOTIFY
	Sintaxe:  SET NOTIFY {ON | LOGON | NEW | OFF}

	Mudanças que ocorrem quando for notificado sobre novas
	mensagens:

	    ON      Só será notificado sobre mensagens quando você
	                se conectar, quando voltar de um /AWAY e quando
	                são enviadas è você.
	    LOGON   Só será notificado sobre mensagens quando você
	                se conectar ou quando voltar de um /AWAY.
	    NEW     Só será notificado sobre mensagens quando
	                estiverem a enviar mensagens a você.
	    OFF     Não receberá nenhuma notificação sobre mensagens.

	    ON é essencialmente a combinação de LOGON e NEW.

MEMO_HELP_SET_LIMIT
	Sintaxe:  SET LIMIT [canal] limite

	Altera o número máximo de mensagens que pode ter
	(ou do canal fornecido). Se alterar para 0, ninguém
	lhe poderá enviar mensagens. Entretanto, não pode
	alterar este limite para mais que %d.

MEMO_HELP_INFO
	Sintaxe:  INFO [canal]

	Informa o número de mensagens que tem, quantas
	mensagens não foram lidas e o total de quantas
	mensagens pode receber.
	Com o parâmetro, mostra a mesma informação para o canal
	fornecido.

MEMO_SERVADMIN_HELP_SET_LIMIT
	Sintaxe:  SET LIMIT [usuário | canal] {limite | NONE} [HARD]

	Altera o número máximo de mensagens que um nick ou canal podem
	ter. Alterando o limite para 0, previne o user de receber
	qualquer mensagem, colocando o limite em NONE permite que o
	usuário receba e mantenha quantas mensagens quiser. Se você
	não fornecer o nick ou canal, o limite do seu nick será alterado.

	Adicionando HARD previne que o user mude o limite.
	Não colocar HARD tem o efeito contrário, permitindo
	que o user mude o limite (mesmo se um limite anterior
	foi ajustado com HARD).

	O uso do comando SET LIMIT é limitado aos  Administradores
	dos Services. Outros users somente alterarão seus
	próprios limites ou de um canal onde tenham privilégios
	para isso, não podem remover seu próprio limite, não
	podem alterar o limite acima de %d e não podem alterar
	um limite máximo (HARD).

MEMO_SERVADMIN_HELP_INFO
	Sintaxe:  INFO [nick | canal]

	Sem um parâmetro, informa o número de mensagens que têm,
	quantas mensagens ainda não foram lidas e o total
	de quantas mensagens pode receber.

	Com o parâmetro do canal, mostra a mesma informação sobre
	um canal.

	Com o parâmetro de nick, mostra a mesma informação sobre
	um nick. Esta derivação do comando é limitada aos
	Administradores dos Services.


###########################################################################
#
# Mensagens de help do OperServ
#
###########################################################################

OPER_HELP
	%S comandos:
	    GLOBAL      Manda mensagens a todos os usuários.
	    STATS       Mostra o status dos Services e da Rede.
	    OPER LIST   Lista todos os Operadores dos Services.
	    ADMIN LIST  Lista todos os Administradores dos Services.

	Comandos disponíveis somente para Operadores e Administradores dos
	Services:
	    MODE        Muda os modos de um canal.
	    KICK        Kicka um usuário de um canal.
	    AKILL       Manipula a lista de AKILL.
	    VLINE       Manipula a lista de VLINEs.
	    BOT         Manipula a lista de BOTs.
	    SESSION     Informação relativa ao controle de sessões.

	Comandos disponíveis somente para Administradores dos Services:
	    SQLINE      Manipula a lista de SQLINEs.
	    OPER        Modifica a lista de Operadores dos Services.
	    LOGONNEWS   Define mensagens a serem mostradas aos usuários
	                quando estiverem conectando.
	    OPERNEWS    Define mensagens a serem mostradas aos IRCops.
	    JUPE        Desconecta um servidor da rede.

	    SET         Altera opções globais dos Services.
	    UPDATE      Força a atualização imediata do banco de dados
	                dos Services no disco.
	    QUIT        Termina o programa dos Services.
	    RESTART     Salva o banco de dados e reinicia os Services.
	    REHASH      Relê o arquivo de configuração dos Services.
	    GETFOUNDER  Atribui privilégios de founder para um canal.

	Comandos disponíveis para Administradores dos Services:
	    ADMIN       Modifica a lista de Administradores dos Services.
	    RAW         Manda uma série de texto ao servidor IRC.

	AVISO: Todos os comandos enviados ao %S são gravados!

OPER_HELP_GLOBAL
	Sintaxe:  GLOBAL mensagem

	Permite os IRCops mandarem mensagens a todos os usuários da rede.
	Esta mensagem será enviada pelo %s.

OPER_HELP_STATS
	Sintaxe:  STATS [RECORD AKILL | ALL]

	Sem nenhuma opção, mostra o número atual de usuários e
	IRCops online (excluindo Services), o número máximo de
	usuários online conectados simultaneamente e o tempo
	de duração desde que a sessão dos Services começou a
	funcionar.

	Com a opção AKILL, mostra o tamanho atual da lista de
	AKILL e o tempo default para um AKILL expirar.

	A opção ALL é disponível somente para os Administradores
	dos Services, e mostra informações sobre o consumo de memória
	dos Services. Usando este comando, pode-se congelar os
	Services por um curto período de tempo em redes grandes,
	portanto não abuse deste comando!

	A opção RECORD mostra a data e o valor dos recordes para
	o número total de utilizadores, ops, helpers e bots na rede.

	UPTIME pode ser usado como um sinônimo para STATS.

OPER_HELP_OPER
	Sintaxe:  OPER ADD nick
	          OPER DEL nick
	          OPER LIST

	Permite aos Administradores dos Services adicionar ou remover
	nicks da lista de Operadores dos Services. O usuário que
	tem o nick na lista de Operadores dos Services e que está
	identificado no %s é capaz de usar os comandos de
	Operador dos Services.

	Qualquer IRCop pode usar o OPER LIST.
	Todos as outras derivações do comando OPER são limitados
	aos Administradores dos Services.

OPER_HELP_ADMIN
	Sintaxe:  ADMIN ADD nick
	          ADMIN DEL nick
	          ADMIN LIST

	Permite que os Administradores dos Services adicionem ou
	removam nicks da lista de Administradores dos Services.
	Os usuários que tem o nick na lista de Administradores dos
	Services e que já se tenham identificado no %s será
	capaz de ter acesso aos comandos de Administradores dos
	Services.

	Qualquer IRCop pode usar o comando ADMIN LIST.
	Todas as outras derivações do ADMIN são limitadas ao
	Services root.

OPER_HELP_MODE
	Sintaxe:  MODE canal modos

	Permite que os Operadores dos Services ajustem os modos de
	qualquer canal. Os parâmetros são os mesmos que o do
	comando /MODE padrão.

	Limitado aos Operadores dos Services.

OPER_HELP_CLEARMODES
	Sintaxe:  CLEARMODES canal [ALL]

	Limpa todos os modos binários (i,k,l,m,n,p,s,t) e bans de um
	canal. Se ALL é fornecido, limpa também todos os ops e
	voices (modos +o e +v) de um canal.

	Limitado aos Operadores dos Services.

OPER_HELP_KICK
	Sintaxe:  KICK canal usuário razão

	Permite IRCops kickar qualquer usuário de um canal.
	OS parâmetros são os mesmos que comando /KICK padrão.
	A mensagem do kick tem o nick do IRCop que envia o
	comando KICK, por exemplo:

	*** SpamMan has been kicked off from channel #my_channel by %S (ROD_NOKEY       (Flood))

	Limitado aos Operadores dos Services.

OPER_HELP_AKILL
	Sintaxe:  AKILL ADD [+tempo] hostname razão
	          AKILL DEL hostname
	          AKILL LIST [hostname]
	          AKILL VIEW [hostname]

	Permite que Operadores dos Services manipulem a lista de
	AKILL. Se um user que tenta conectar possui uma hostname
	prevista na lista de AKILL, os Services emitem um KILL para
	aquele usuário, para servidores que suporta, e instrui todos
	os servidores da rede a adicionar um ban (K-line) para a
	hostname do user encontrado.

	AKILL ADD adiciona uma hostname ident@host na lista de AKILL
	para uma dada razão (deve ser posta obrigatoriamente).
	AKILL DEL remove uma dada hostname da lista de AKILL, se está
	estiver presente. AKILL LIST mostra todos os AKILLs atuais;
	se uma hostname opcional for fornecida, a listagem será
	limitada aquela hostname. AKILL VIEW é uma versão mais
	detalhada do AKILL LIST e mostrará quem adicionou o AKILL, a
	data que foi adicionado e quando será expirado, como também
	a hostname (ident@host) e a razão.

	Opcionalmente, um tempo para o akill expirar pode ser
	fornecido com o comando AKILL ADD. O tempo precede a
	hostname ident@host e é especificado como um número inteiro
	seguido por um dos d (dias), h (horas) ou m (minutos).
	Combinações (como de 1h30m) não são permitidas. Se uma
	unidade específica não é incluída, o default é em dias
	(então +30 significa 30 dias). Para adicionar um AKILL que
	não expira, use  +0 . Se a hostname a ser adicionada começar
	com um +, o tempo do AKILL deve ser fornecido, até mesmo se
	este tempo for igual ao default. O atual tempo de expiração
	de AKILLs pode ser encontrado com o comando STATS AKILL.

	A razão existe apenas para uso dos IRCops, e não será
	mostrada aos users nas mensagens de KILL.

	Este comando é limitado aos Operadores dos Services.

OPER_HELP_JUPE
	Sintaxe:  JUPE servidor

	Diz aos Services para desconectar um servidor, isto é, criar
	um falso servidor conectado aos Services que previne que o
	servidor real com aquele nome se conecte na rede. O jupe
	pode ser removido usando um simples SQUIT.

	Limitado aos Administradores dos Services.

OPER_HELP_RAW
	Sintaxe:  RAW texto

	Envia uma série de texto diretamente ao servidor onde os
	Services estão conectados. Este comando tem várias
	limitações de uso, e pode criar confusões e problemas na
	rede se usado impropriamente. NÃO USE ESTE COMANDO a menos
	que tenha a certeza do que esteja fazendo!

	Limitado aos Administradores dos Services.

OPER_HELP_SET
	Sintaxe:  SET opção seleção

	Altera várias opções globais dos Services. Nomes de opção
	atualmente definidas são:
	     READONLY    Determina o modo read-only ou read-write.
	     DEBUG       Ativa ou desativa o modo de depuração (debug).

	Limitado aos Administradores dos Services.

OPER_HELP_SET_READONLY
	Sintaxe:  SET READONLY {ON | OFF}

	Ativa ou desativa o modo read-only. No modo read-only,
	usuários normais não serão capazes de modificar nenhum dado
	nos Services, incluindo lista de acesso de canais e nick,
	etc. IRCops com privilégios suficientes nos Services serão
	capazes de mudar a lista de AKILL e de proibir e cancelar o
	registro de canais ou nicks, embora quaisquer mudanças não
	serão salvas no banco de dados a menos que o modo read-only
	seja desativado antes dos Services serem terminados ou
	reiniciados.

	Esta opção é equivalente a opção da linha de comando
	"-readonly".

OPER_HELP_SET_DEBUG
	Sintaxe:  SET DEBUG {ON | OFF | número}

	Ativa ou desativa o modo de depuração (debug). No modo de
	depuração, todos os dados enviados para os Services, assim
	como todas as outras mensagens de depuração são enviadas a
	um arquivo de log. Se número é fornecido, o modo de depuração
	é ativado, com o nível de debug fornecido.

	Esta opção é equivalente a opção da linha de comando
	"-debug".

OPER_HELP_UPDATE
	Sintaxe:  UPDATE

	Faz com que os Services atualizem o banco de dados logo que
	você envia este comando.

	Limitado aos Administradores dos Services.

OPER_HELP_QUIT
	Sintaxe:  QUIT

	Faz com que desligue os Services imediatamente, o banco de
	dados não é salvo. Este comando não deve ser usado a menos
	que haja um dano da cópia do banco de dados na memória e por
	isso eles não devem ser salvos. Para desligar normalmente,
	use o comando SHUTDOWN.

	Limitado aos Administradores dos Services.

OPER_HELP_SHUTDOWN
	Sintaxe:  SHUTDOWN

	Salva o banco de dados dos Services e os desliga.

	Limitado aos Administradores dos Services.

OPER_HELP_RESTART
	Sintaxe:  RESTART

	Salva o banco de dados dos Services e os reinicia.
	(sai e executa imediatamente o executável).

	Limitado aos Administradores dos Services.
OPER_HELP_REHASH
	Sintaxe:  REHASH

	Relê o arquivo de configuração dos services.
	Nota: Os parâmetros do tipo string não serão alterados
	para manter a integridade dos services.

	Limitado aos Administradores dos Services.
OPER_REHASH_DONE
	Leitura da nova configuração foi efetuada com êxito.
OPER_REHASH_ERROR
	Ocorreu um erro lendo o arquivo de configuração.
CHAN_LEVEL_PROTECT
	Protege um usuário contra deops/kicks.
NICK_AUTORECON
	Nick reconhecido automaticamente.
NICK_HELP_SET_AUTOJOIN
	Sintaxe:  SET AUTOJOIN {ON | OFF}

	Ativa ou desativa a entrada automática em canais do %S.
	Quando ativada o utilizador entrará nos canais
	inseridos na sua AJOIN LIST quando se identificar.
NICK_SET_AUTOJOIN_ON
	Entrada automática nos canais ativada.
NICK_SET_AUTOJOIN_OFF
	Entrada automática nos canais desativada.
NICK_SET_AUTOJOIN_SYNTAX
	Sintaxe:  SET AUTOJOIN {ON | OFF}
NICK_HELP_AJOIN
	Sintaxe: AJOIN { ADD | DEL | LIST } [#canal]

	Permite adicionar/retirar/listar a lista de entrada
	automática de canais.
	Quando você se identificar, entrará automaticamente
	nos canais existentes nesta lista.

	A qualquer momento podes utilizar o comando
	/%S AJOIN NOW para entrares em todos os canais
	da tua lista de entrada automática.
NICK_AJOIN_LIST_X
	Lista de canais com entrada automática para  %s :
NICK_AJOIN_SYNTAX
	Sintaxe: AJOIN { ADD | DEL | LIST } [#canal]
NICK_AJOIN_REACHED_LIMIT
	Pedimos desculpa, só pode ter %d canais na lista
	de entrada automática
NICK_AJOIN_ALREADY_PRESENT
	Canal  %s  já existe na sua lista de canais.
NICK_AJOIN_ADDED
	%s adicionado a sua lista de canais.
NICK_AJOIN_NOT_FOUND
	%s não encontrado na sua lista de canais.
NICK_AJOIN_DELETED
	%s apagado da sua lista de canais.
NICK_AJOIN_LIST
	Lista de canais com entrada automática:
NICK_INFO_OPT_AUTOJOIN
	Entrada automática
BAD_CHAN_NAME
	O canal deve estar no formato #canal.
OPER_IDENTIFY_REQUIRED
	O novo sistema de segurança só permite o funcionamento
	de IRC Operadores registrados nos serviços.
	Procure o Administrador do seu servidor para maiores informações.
NICK_ALREADY_IDENTIFIED
	Este nick já está identificado.
TODAYSTATS
	Estatísticas para o dia de hoje (%s):

STATS_TOTAL
	Total      : %d
STATS_REGISTERED
	Registrados: %d
STATS_DROPPED
	Libertos   : %d
STATS_EXPIRED
	Eliminados : %d
STATS_BALANCE
	Saldo      : %s
OPER_HELP_BOTLIST
	Syntax:
	   BOT ADD hostname maxcon motivo
	   BOT DEL hostname
	   BOT LIST [máscara]
	   BOT VIEW [máscara]

	Permite aos IRC Operadores manipular a lista de BOTs.
	Esta lista define o limite de ligações para um determinado
	host.
OPER_TOO_MANY_BOTLIST
	A lista está cheia.
OPER_BOTLIST_NO_NICK
	Lista de BOTs pode apenas conter hostnames absolutos!
OPER_BOTLIST_ADDED
	Nova entrada na lista de bots para %s
OPER_BOTLIST_ADD_SYNTAX
	BOT ADD host maxcon motivo
OPER_BOTLIST_DEL_SYNTAX
	BOT DEL hostname motivo
BOTLIST_REMOVED
	O hostname %s foi eliminado da lista de BOTs.
OPER_BOTLIST_NOT_FOUND
	O hostname %s não foi encontrado na lista de BOTs.
OPER_BOTLIST_HEADER
	BotList atual:
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
	Neste momento você está utilizando um nick não registrado,
	basta registrá-lo para que você possa usá-lo com exclusividade,
	registre este nick com o comando /%s REGISTER senha email.
	Se não possuir email utilize NOMAIL no campo email.
CHANGE_IN_1_MINUTE
	Se não mudar de nick, dentro de um minuto este será alterado.
NICK_AJOIN_EMPTY
	Lista de canais está vazia.
FEATURE_DISABLED
	Funcionalidade inexistente neste servidor.
CHAN_ACCESS_LIST_FORMAT2
	  %3d  %4d  %s%s%s%s por %s
NICK_AUTORECON_R
	Reconhecimento automático de nick por modo +r.
NICK_STATUS_0
	STATUS de %s : 0 - utilizador não está conectado ou o nick não está registrado
NICK_STATUS_1
	STATUS de %s : 1 - utilizador não reconhecido como dono do nick
NICK_STATUS_2
	STATUS de %s : 2 - utilizador reconhecido como dono só pela lista de acesso
NICK_STATUS_3
	STATUS de %s : 3 - utilizador reconhecido como dono via identificação por senha
OPER_HELP_SQLINE
	Syntax: SQLINE ADD nick reason
	        SQLINE DEL  nick
	        SQLINE LIST [mask]
	        SQLINE VIEW [mask]

	Permite que os Operadores dos Serviços manipulem a lista de SQLINE.
	Um nick na SQLINE não poderá ser utilizado nesta rede.
OPER_TOO_MANY_SQLINE
	Pedimos desculpas, mas a lista de SQLINE está cheia.
OPER_SQLINE_JUST_NICK
	Você pode usar somente nick/wildcards na lista de SQLINE.
OPER_SQLINE_ADDED
	Nova SQLINE adicionada para %s.
OPER_SQLINE_ADD_SYNTAX
	SQLINE ADD nick razão
OPER_SQLINE_DEL_SYNTAX
	SQLINE DEL nick razão
OPER_SQLINE_REMOVED
	Removida SQLINE %s da lista de SQLINE.
OPER_SQLINE_NOT_FOUND
	SQLINE para %s não foi encontrada na lista.
OPER_SQLINE_HEADER
	Lista atual de SQLINE:
# mask, reason
OPER_SQLINE_FORMAT
	%-32s %s
#mask, set-by, set-time, reason
OPER_SQLINE_VIEW_FORMAT
	%s (by %s at %s)
	   %s
OPER_SQLINE_SYNTAX
	SQLINE {ADD | DEL | LIST | VIEW} nick [razão]
BAD_EMAIL_ADDRESS
	Email inválido!
	Utilize usuário@servidor-de-email ou NOMAIL se não pretender indicar
	o seu email.
CHAN_DROP_CANCEL
	O pedido de DROP do canal efetuado em %s foi cancelado.
CHAN_DROP_AT
	O registro do canal será cancelado dentro de %d dia(s).
NICK_DROP_CANCEL
	O pedido de DROP do nick efetuado em %s foi cancelado.
NICK_DROP_AT
	O registro do nick será cancelado dentro de %d dia(s).
OPER_STATS_USERS_RECORD
	Recorde de usuários foi %d em %s
	Neste momento existe(m) %d usuário(s) (%d%)
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
	O serviço %S permite receber notícias em tempo real
	de acordo com os temas subscritos.
	Existem vários comandos que pode utilizar
	digite /%S comando.
	Para mais informações sobre um determinado comando
	digite /%S HELP comando.

	    LIST         Lista os vários temas e o seu estado de subscrição
	    SUBSCRIBE    Subscreve um tema
	    UNSUBESCRIBE Cancela a subscrição de um tema
	    SET          Define opções
	    RECENT       Lista as notícias enviadas recentemente
NEWSS_HELP_OPER

	Comandos de Operadores de Notícias:
	    SEND         Envia uma notícia
	    VIEW         Ver as notícias recentes com infor. detalhada
	    DEL          Apaga uma entrada das notícias recentes
	    OPER LIST    Lista os operadores de notícias
	    ADMIN LIST   Lista os administradores de notícias
NEWSS_HELP_ADMIN

	Comandos de Administradores de Notícias:
	    SUBJECT      Altera a lista de temas
	    OPER         Adiciona/Remove operador de notícias
NEWSS_HELP_SADMIN

	Comando de Operadore de Serviços:
	    ADMIN        Adiciona/Remove administrador de notícias
NEWSS_OPER_SYNTAX
	OPER {ADD | DEL | LIST} [nick]
NEWSS_OPER_ADD_SYNTAX
	OPER ADD nick
NEWSS_OPER_DEL_SYNTAX
	OPER DEL nick
NEWSS_OPER_SKELETON
	Os serviços estão no modo SKELETON; o comando OPER está indisponível.
NEWSS_OPER_EXISTS
	%s já existe na lista de Operadores de notícias.
NEWSS_OPER_ADDED
	%s adicionado a lista de Operadores de notícias.
NEWSS_OPER_TOO_MANY
	Demasiadas entradas (%d) na lista de Operadores de notícias,
	não pode adicionar mais.
NEWSS_OPER_REMOVED
	%s removido da lista de Operadores de notícias.
NEWSS_OPER_NOT_FOUND
	%s não foi encontrado na lista de Operadores de notícias.
NEWSS_OPER_LIST_HEADER
	Lista de Operadores de notícias:

NEWSS_OPER_HELP
	Syntax: OPER ADD nick
	        OPER DEL nick
	        OPER LIST

	Permite aos administradores de notícias, adicionar ou
	remover nicks de ou a lista de Operadores de notícias
	Um usuário cujo nick esteja na lista de Operadores
	de notícias e se tenha identificado pelo %s terá acesso
	aos comandos de Operador de notícias.

	Qualquer operador pode usar o comando OPER LIST
	Todos os outros comando estão limitados aos
	administradores de notícias.

# News Server ADMIN responses
NEWSS_ADMIN_SYNTAX
	ADMIN {ADD | DEL | LIST} [nick]
NEWSS_ADMIN_ADD_SYNTAX
	ADMIN ADD nick
NEWSS_ADMIN_DEL_SYNTAX
	ADMIN DEL nick
NEWSS_ADMIN_SKELETON
	Os serviços estão no modo SKELETON; o comando ADMIN está indisponível.
NEWSS_ADMIN_EXISTS
	%s já existe na lista de Administradores de notícias.
NEWSS_ADMIN_ADDED
	%s adicionado a lista de Administradores de notícias.
NEWSS_ADMIN_TOO_MANY
	Demasiadas entradas (%d) na lista de Administradores de notícias,
	não pode adicionar mais!
NEWSS_ADMIN_REMOVED
	%s removido da lista de Administradores de notícias.
NEWSS_ADMIN_NOT_FOUND
	%s não encontrado na lista de Administradores de notícias.
NEWSS_ADMIN_LIST_HEADER
	Lista de Administradores de notícias:

NEWSS_SUBJECT_HELP
	Permite alterar/criar uma entrada na lista de temas
	do %S.

	Sintaxe: SUBJECT número tema
NEWSS_SUBJECT_SYNTAX
	SUBJECT número tema
NEWSS_SUBJECT_ERROR
	O número tem de estar entre 1 e %d.
NEWSS_LIST_HELP
	O comando LIST exibe a lista de assuntos disponíveis
	e o seu estado de subsrição.

	Os marcados com um X estão subscritos.
	Para subscrever/cancelar subscrição utilize os comandos:
	    SUBCRIBE/UNSUBSCRIBE

NEWSS_LIST_HEADER
	No Subs Tema

NEWSS_LIST
	%2d  %c   %s
NEWSS_LIST_END
	Fim da lista de temas
NEWSS_SUBJECT_NOTFOUND
	O tema número %d não existe!
NEWSS_SUBJECT_CHANGED
	Tema alterado de %s para %s.
NEWSS_SUBJECT_CREATED
	Tema %s criado.
NEWSS_SUBSCRIBE_SYNTAX
	SUBSCRIBE  número [,número] | ALL
NEWSS_SUBSCRIBE_HELP
	Este comando permite subscrever um tema.

	Sintaxe: SUBSCRIBE  número [,número] | ALL 

	Pode subscrever vários temas num só comando
	usando números separados com vírgulas.
	Indicando ALL subscreve todos os temas.
NEWSS_SUBSCRIBE_SUBSCRIBED
	Subscreveu %d tema(s).
NEWSS_UNSUBSCRIBE_SYNTAX
	UNSUBSCRIBE  número [,número] | ALL
NEWSS_UNSUBSCRIBE_HELP
	Este comando permite cancelar a subscrição de um tema.

	Sintaxe: UNSUBSCRIBE número [,número] |  ALL

	Pode cancelar a subsrição de vários temas num só comando,
	usando números separados por vírgulas.
	Indicando ALL cancelará subscrição de todos os temas.
NEWSS_UNSUBSCRIBE_UNSUBSCRIBED
	Cancelou a subscrição de %d tema(s).
NEWSS_SEND_SYNTAX
	SEND número notícia
NEWSS_SEND_HELP
	Permite enviar uma notícia.

	Sintaxe: SEND número notícia
NEWSS_SEND_SENT
	Notícia foi enviada.
NEWSS_SET_SYNTAX
	SET opção valor
NEWSS_SET_HELP
	Sintaxe: SET opção valor

	Define as opções do %S.  Opção pode ser:
	    NOTICE    Recebe as notícias por notice ou por msg.
NEWSS_SET_NOTICE_SYNTAX
	SET NOTICE [ON | OFF]
NEWSS_SET_NOTICE_HELP
	Sintaxe: SET NOTICE [ON | OFF]

	Se a opção NOTICE estiver ligada (ON) as notícias
	serão recebidas via NOTICE caso contrário serão
	enviadas por mensagem em privado.
NEWSS_SET_NOTICE_ON
	Opção de NOTICE está agora ligada (ON)
NEWSS_SET_NOTICE_OFF
	Opção de NOTICE está agora desligada (OFF)
NEWSS_RECENT_HELP
	Sintaxe: RECENT

	Lista as notícias mais recentes.
NEWSS_RECENT_HEADER
	Lista das notícias mais recentes
NEWSS_RECENT_LIST
	%s : %s
NEWSS_RECENT_END
	Fim da lista das notícias mais recentes
NEWSS_VIEW_HELP
	Sintaxe: VIEW

	Lista as notícias mais recentes com infor. detalhada,
	o tema número 0 indica notícias eliminadas.
NEWSS_VIEW_HEADER
	Nr. : Sub. : Data : notícia (emissor)
NEWSS_VIEW_LIST
	%s%2d : %2d : %s : %s (%s)%s
NEWSS_DEL_SYNTAX
	DEL número
NEWSS_DEL_HELP
	Syntax: DEL número

	Este comando elimina um item da lista das notícias
	mais recentes. O item apenas desparece da lista
	apresentada com o comando /%S RECENT.
	O número do item deverá ser escolhido da primeira
	coluna da lista obtida com /%S VIEW.
NEWSS_DEL_NOTEXIST
	A notícia número %d não existe.
NEWSS_DEL_DELETED
	A notícia número %d foi eliminada.
NICK_INFO_PRIVATE
	A informação sobre %s é privada.
CHAN_INFO_PRIVATE
	A informação sobre %s é privada.
CHAN_NEED_REGNICK
	Neste canal só são permitidos nicks registrados!
CHAN_MODE_PROTECTED
	Este canal utiliza modos de entrada protegida.
NEWS_REC_PLEASE_WAIT
	Aguarde %d segundos antes de usar o comando RECENT novamente.
NICK_HELP_NOTES
	Permite-lhe guardar algumas anotações.

	Para guardar uma anotação utilize /%S NOTES ADD texto
	Para eliminar uma anotação utilize /%S NOTES DEL number
	Para listar todas as anotações /%S NOTES LIST
NICK_NOTES_SYNTAX
	LIST | ADD texto | DEL number
NICK_NOTES_ADDED
	Anotação foi guardada com o número %d.
NICK_NOTES_NOADD
	Atingiu o número máximo de anotações (%d) disponíveis para
	o seu nick, apague alguma anotação mais antiga para poder
	adicionar esta.
NICK_NOTES_DELETED
	Anotação número %d foi eliminada.
NICK_NOTES_NOTFOUND
	A anotação número %d não existe.
NICK_NOTES_LIST_HEADER
	No  Anotação
NICK_NOTES_LIST
	%2d %s
NICK_NOTES_NONOTES
	Lista de anotações vazia.
CHAN_ACCESS_CLEARALL
	Todos os elementos da lista de acesso foram eliminados.
CHAN_AKICK_CLEARALL
	Todos os elementos da lista de AKICKS foram eliminados.
NICK_STATUS_SYNTAX
	STATUS nick
NICK_X_ISFOUNDER
	O nick %s é fundador do canal, não pode ser defenido
	como sucessor.
NICK_X_ISSUCCESSOR
	O nick %s é sucessor do canal, não pode ser defenido
	como fundador.
AGO_TIME_D
	Há %d dia(s), %d hora(s), %d minuto(s) e %d segundo(s)
AGO_TIME
	Há %d hora(s), %d minuto(s) e %d segundo(s)
TOTAL_TIME
	%d dia(s), %d hora(s), %d minuto(s) e %d segundo(s).
OPER_OPER_SUSPENDED
	O operador %s está agora suspenso durante %d dias.
OPER_OPER_UNSUSPEND
	Suspensão do operador %s foi cancelada.
OPER_OPER_SUSPEND_SYNTAX
	OPER SUSPEND nick dias
CHAN_HELP_AOP
	Alias para gestão da lista de AUTOOPs de um canal.
	AOP ADD   Adiciona um usuário com nível de AUTOOP no #canal
	AOP LIST  Lista todos os usuários com nível de AUTOOP no #canal
CHAN_AOP_SYNTAX
	AOP ADD nick | DEL nick | LIST
CHAN_HELP_SOP
	Alias para gestão da lista de utilizadores com permissão
	para mudança da lista de acessos do canal.
	SOP ADD  Adiciona um utilizador com nível de ACC-CHANGE no #canal.
	SOP LIST Lista todos os utilizadores com nível de ACC-CHANGE no #canal
CHAN_SOP_SYNTAX
	SOP ADD nick | DEL nick | LIST
CHAN_AJOIN_ADD
	Deverá adicionar o canal a sua lista de AJOIN com /%s AJOIN ADD %s
# SENDPASS responses
OPER_SENDPASS_SYNTAX
	SENDPASS nickname
OPER_SENDPASS_UNAVAILABLE
	O comando SENDPASS está indisponível porque o modo de encriptação está em uso.
OPER_SENDPASS_SUBJECT
	Senha de nick (%s)
OPER_SENDPASS_HEAD
	Olá,
OPER_SENDPASS_LINE_1
	Foi pedido que lhe fosse enviada via e-mail a senha para o nick %s.
OPER_SENDPASS_LINE_2
	A senha para este nick é %s. Como medida de seguranca mude a senha assim que a utilizar.
OPER_SENDPASS_LINE_3
	Se desconhece o assunto em causa, ignore este email.
OPER_SENDPASS_LINE_4
	Por favor não responda a este email.
OPER_SENDPASS_LINE_5
	PTlink Services - http://www.ptlink.net/
OPER_SENDPASS_OK
	Senha para o nick %s foi enviada.
CHAN_RESTRICT_REGISTER
	O registro de canais nesta rede está restrito a Services Operators.
MEMO_WILL_EXPIRE
	O(s) seu(s) memo(s):%s será(ão) eliminado(s) em breve,
	por ser(em) demasiado antigo(s).
MEMO_HAVE_EXPIRED
	O(s) seu(s) memo(s):%s foram eliminados.
NICK_INFO_IS_ONLINE
	O usuário está online.
CHAN_LIST_SERVADMIN_SYNTAX
	LIST pattern [FORBIDDEN] [NOEXPIRE]
NICK_AUTH_SENT
	Uma curta mensagem foi enviada para o seu endereço de email
	com instruções detalhadas para completar o registro do nick.
	Até que finalize o registro com a autenticação pelo código
	enviado para o email não lhe será possível enviar memos
	ou registrar novos canais.
NICK_AUTH_INCORRET
	O código utilizado não está correto para o nick/email
	deste nick.
NICK_AUTH_COMPLETED
	O código está correto, o registro do seu nick/alteração de
	email está completo/a.
NICK_HELP_AUTH
	Sintaxe: AUTH código

	Valida o e-mail associado associado seu seu nick.
AUTH_EMAIL_SUBJECT
	Registro de nick
SET_EMAIL_SUBJECT
	Alteração do e-mail de nick
NICK_SET_EMAIL_WAIT
	Por favor aguarde um dia antes de tentar alterar
	o seu endereço de email de novo.
NICK_SET_EMAIL_AUTH
	Verifique o seu email (%s) onde deverá ter recebido
	instruções para que possa completar esta alteração.
NICK_AUTH_NEEDED
	Por favor complete o registro do seu nick com a
	autenticação do e-mail que indicou para registro.

	Se não indicou um email válido durante o registro ou não
	recebeu o código de autenticação faça a alteração
	do email associado a este nick com
	/%s SET EMAIL email
NICK_HELP_SET_NEWSLETTER
	Syntax: SET NEWSLETTER { ON | OFF }

	Ativa/desativa recepção da newsletter.
NICK_SET_NEWSLETTER_ON
	Recepção da Newsletter ativada.
NICK_SET_NEWSLETTER_OFF
	Recepção da Newsletter desativada.
NICK_SET_NEWSLETTER_SYNTAX
	SET NEWSLETTER { ON | OFF }
NICK_INFO_NEWSLETTER
	Receberá newsletter.

