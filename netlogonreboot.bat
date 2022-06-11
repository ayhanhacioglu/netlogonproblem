@Echo off
REM -----------------------------------------------------------------------------------------------------------------------------
REM
REM NetlogonReboot Version 1.3 AH@24042022 ayhanhacioglu@gmail.com
REM 
REM if you are having Netlogon problem on windows servers! 
REM if servers is closing the communication with unexpectly from domain and you could not find the root cause. 
REM This script can help you for rebooting servers when the problem occured in any time. Also, script can send mail you with error messages. 
REM You can choose the script name is NetlogonReboot.bat and this file must be schedule with windows task scheduler for running every hour.
REM Script is running with depend on TST10 telnet scripting tool at this link. https://support.moonpoint.com/downloads/windows/network/Telnet/tst10.php
REM All files (NetlogonReboot.bat and TST10.exe) must be in same folder like as C:\scripts\
REM Do not forget you must be set task scheduler start in parameter "C:\scripts\"
REM
REM In Summary; Script is purposing that when the problem occured, reboot the server and send the email to help desk ticketing system (like as jira) for everyone.
REM
REM -----------------------------------------------------------------------------------------------------------------------------
SET _time=%time%
SET _date=%date%
SET _longtime=%_time%
SET _longdate=%_date%
SET _filepath=c:\scripts\telnetcmd.txt
SET _logonresult=%logonserver%
SET _logonlastresult=%_logonresult:~2%
SET _hostname=%computername%
SET _windowsdomain="please set windows domain"
SET _mailserver="please set mailserver name or ip address"
SET _mailserverport="please set mailserver port address like as 587"
SET _frommaildomain="please set from maildomain for sender"
SET _tommaildomain="please set to maildomain for receipent"
SET _receipent="please set email receipent name"
SET _tempvar=0
SET _rebootreason=0
IF %_logonlastresult% == %_hostname% SET _tempvar=1
IF %_logonlastresult% == %_hostname% SET _rebootreason="LogonServerName Does Not Match"
SET _errorparam=1
nltest /sc_verify:%_windowsdomain% | findstr /irc:"ERROR_NO_LOGON_SERVERS"
SET _errorparam=%errorlevel%
IF %_errorparam% EQU 0 SET _tempvar=1
IF %_errorparam% EQU 0 SET _rebootreason="nltest /sc_verify:%_windowsdomain% result getting error"
IF %_tempvar% EQU 1 (
	IF NOT EXIST c:\scripts\telnetcmd.txt (
		ECHO %_mailserver% %_mailserverport% > %_filepath%
		ECHO SEND "mail from:%_hostname%@%_frommaildomain%\m">> %_filepath%
		ECHO SEND "rcpt to:%_receipent%@%_tommaildomain%\m">> %_filepath%
		ECHO SEND "data\m">> %_filepath%
		ECHO SEND "subject:Server %_hostname% is affected Netlogon problem and it will be scheduled rebooting at %_longtime% %_longdate% %_rebootreason%\m">> %_filepath%
		ECHO SEND ".\m">> %_filepath%
		ECHO SEND "quit\m">> %_filepath%
		shutdown -r -t 180
		c:\scripts\TST10.exe /r:telnetcmd.txt /o:output.txt && del /q %_filepath%
	)
) ELSE (
	IF EXIST c:\scripts\telnetcmd.txt (
		IF %_tempvar% NEQ 1 c:\scripts\TST10.exe /r:telnetcmd.txt /o:output.txt && del /q %_filepath%
		)
	)
EXIT
