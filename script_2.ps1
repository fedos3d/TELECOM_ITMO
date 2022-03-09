$param = Read-Host -Prompt 'Enter Auto or Manual: '
while (($param -ne 'Auto') -and ($param -ne 'Manual')) {
    $param = Read-Host -Prompt 'Enter Auto or Manual: '
}
$info = Read-Host -Prompt 'Do you want to list additional info? (enter YES or NO): '
while (($info -ne 'YES') -and ($info -ne 'NO')) {
    $info = Read-Host -Prompt 'Do you want to list additional info? (enter YES or NO): '
}
if ($info -eq 'YES') {
     Get-NetAdapter | select InterfaceDescription, Status, FullDuplex, Speed
}
if ($param -eq 'Auto') {
    netsh interface ipv4 set address name="Ethernet 2" source=dhcp
    netsh interface ipv4 set dnsservers "Ethernet 2" source=dhcp
}
if ($param -eq 'Manual') {
    netsh interface ipv4 set address name="Ethernet 2" static address=192.168.0.193 mask=255.255.255.0 gateway=192.168.0.1
    netsh interface ipv4 set dns "Ethernet 2" static 1.1.1.1
}
