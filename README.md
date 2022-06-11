# netlogonproblem
This script file aims to reboot secure channel error affected windows servers. This situation has been more explained on event id 5719.

NetlogonReboot Version 1.3 AH@24042022 ayhanhacioglu@gmail.com
 
if you are having Netlogon problem on windows servers! 
if servers is closing the communication with unexpectly from domain and you could not find the root cause. 
This script can help you for rebooting servers when the problem occured in any time. Also, script can send mail you with error messages. 
You can choose the script name is NetlogonReboot.bat and this file must be schedule with windows task scheduler for running every hour.
Script is running with depend on TST10 telnet scripting tool at this link. https://support.moonpoint.com/downloads/windows/network/Telnet/tst10.php
All files (NetlogonReboot.bat and TST10.exe) must be in same folder like as C:\scripts\
Do not forget you must be set task scheduler start in parameter "C:\scripts\"

In Summary; Script is purposing that when the problem occured, reboot the server and send the email to help desk ticketing system (like as jira) for everyone.
