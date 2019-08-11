::Este Script foi criado pelo professor Gustavo Schwarz, juntamente com os alunos Felipe Lückemeyer e William Pêz.
::Para poder utilizá-lo em seu computador, precisa alterar a linha 50 e colocar seu usuario e sua senha ;)
@ECHO OFF
:: Limpa a tela (CLear Screen)
CLS

:: Titulo da janela
TITLE Configuracao de proxy do IFSUL Sapiranga 

:: Imprime as opcoes disponiveis
ECHO ----- Opcoes de configuracao de proxy -----
ECHO  1. Ajustar proxy para o ionic
ECHO  2. Ajustar proxy para o git
ECHO  3. Resetar todas configuracoes de proxy
ECHO  4. Sair
ECHO -------------------------------------------

:options
:: Le a opcao digitada pelo usuario (tendo opcao de 1 ate 4)
CHOICE /C 1234 /M "Qual opcao voce deseja: "

:: A lista de opcoes deve ser em ordem decrescente
:: Se o usuario digitar 4 vai até o ponto ":close"
IF ERRORLEVEL 4 GOTO close
:: Se o usuario digitar 3 vai até o ponto ":resetProxy"
IF ERRORLEVEL 3 GOTO resetProxy
:: Se o usuario digitar 3 vai até o ponto ":setProxyGit"
IF ERRORLEVEL 2 GOTO setProxyGit
:: Se o usuario digitar 3 vai até o ponto ":setProxyIonic"
IF ERRORLEVEL 1 GOTO setProxyIonic

:setProxyIonic
	ECHO [CONFIGURACAO DO IONIC]
	call npm config set proxy http://10.0.10.6:3128
	call npm config set https-proxy http://10.0.10.6:3128
	call npm config set registry https://registry.npmjs.org
	call ionic config set -g proxy http://10.0.10.6:3128
	ECHO Proxy para o ionic configurado com sucesso!
	ECHO.
	:: Volta para o inicio do script para o usuario digitar novamente uma opcao
	GOTO options

:setProxyGit
	ECHO [CONFIGURACAO DO GIT]
	ECHO Voce deve informar seu usuario e senha de rede
	:: Solicita o nome de usuario da rede e guarda na variavel user
	::SET /P user=Informe seu login de rede: 
	:: REM Solicita a senha da rede e guarda na variavel pass
	::SET /P pass=Informe sua senha de rede: 
	call git config --global http.proxy http://usuario:senha@10.0.10.6:3128
	ECHO Proxy para o Git configurado com sucesso!
	ECHO.
	:: Volta para o inicio do script para o usuario digitar novamente uma opcao
	GOTO options

:resetProxy
	ECHO [REDEFINICAO DE PROXY]
	call npm config rm proxy
	call npm config rm https-proxy
	call ionic config unset --global proxy
	call git config --global --unset http.proxy
	ECHO Proxy resetado com sucesso!
	ECHO.
	:: Volta para o inicio do script para o usuario digitar novamente uma opcao
	GOTO options

:close
	ECHO Arquivo finalizado
