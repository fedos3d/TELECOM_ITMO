$param = Read-Host -Prompt 'Enter Auto or Manual: '
while (($param -ne 'Auto') -and ($param -ne 'Manual')) {
    $param = Read-Host -Prompt 'Enter Auto or Manual: '
}
$info = Read-Host -Prompt 'Do you want to list additional info? (enter YES or NO): '
while (($param -ne 'YES') -and ($param -ne 'NO')) {
    $info = Read-Host -Prompt 'Do you want to list additional info? (enter YES or NO): '
}
if ($info -eq 'YES') {
     Get-NetAdapter | select InterfaceDescription, Status, FullDuplex, Speed
}
if ($param -eq 'Auto') {
    netsh interface ipv4 set address name="Ethernet0" source=dhcp
    netsh interface ipv4 set dnsservers "Ethernet0" source=dhcp
}
if ($param -eq 'Manual') {
    netsh interface ipv4 set address name="Ethernet0" static address=192.168.1.10 mask=255.255.255.0 gateway=192.168.1.1
    netsh interface ipv4 set dns "Ethernet0" static 8.8.8.8
}
