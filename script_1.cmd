@echo off
:begin
set /p param="Enter Auto or Manual: "
if "%param%" == "Auto" (
	echo "Auto param picked"
	goto auto
)
if "%param%" == "Manual" (
	echo "Manual param picked"
	goto manual
)
set "param="
goto begin


:auto
netsh interface ipv4 set address name="Ethernet0" source=dhcp
netsh interface ipv4 set dnsservers "Ethernet0" source=dhcp
exit /b

:manual
netsh interface ipv4 set address name="Ethernet0" static address=192.168.1.10 mask=255.255.255.0 gateway=192.168.1.1
netsh interface ipv4 set dns "Ethernet0" static 8.8.8.8
exit /b
