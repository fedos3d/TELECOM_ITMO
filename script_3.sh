#!/usr/bin/env bash

while [ -n "$1" ]
do
    case "$1" in
        -m)
            mode="$2"
            if [[ $mode == "static" ]]; then
                read -p "Enter ip address: " ip
                read -p "Enter mask: " mask
                read -p "Enter gateway: " gateway
                read -p "Enter DNS server: " dns
                
                cp /home/timurbabs/lab_1/debian_interfaces_static_template /etc/network
                rm /etc/network/interfaces
                mv /etc/network/debian_interfaces_static_template /etc/network/interfaces
                
                sed -i "s/address $PARTITION_COLUMN.*/address $ip/" /etc/network/interfaces
                sed -i "s/netmask $PARTITION_COLUMN.*/netmask $mask/" /etc/network/interfaces
                sed -i "s/gateway $PARTITION_COLUMN.*/gateway $gateway/" /etc/network/interfaces
                sed -i "s/dns-nameservers $PARTITION_COLUMN.*/dns-nameservers $dns/" /etc/network/interfaces
                
            elif [[ $mode == "dhcp" ]]; then
                
                cp /home/timurbabs/lab_1/debian_interfaces_dhcp_template /etc/network
                rm /etc/network/interfaces
                mv /etc/network/debian_interfaces_dhcp_template /etc/network/interfaces
                
            else
                echo "Wrong argument. Possible arguments are: static and dhcp."
                exit 1
            fi
            
            /etc/init.d/networking restart
            
            shift
        ;;
        
        -v)
            adapter="$2"
            
            if [[ -z $adapter ]]; then
                echo -e "-v \t Provide adapter name."
                exit 1
            fi
            
            echo "Network card:"
            lspci | grep 'Ethernet'
            echo -e "\n"
            
            echo "Speed and Duplex:"
            speed=$(cat /sys/class/net/$adapter/speed)
            duplex=$(cat /sys/class/net/$adapter/duplex)
            echo "Speed - $speed"
            echo "Duplex - $duplex"
            echo -e "\n"
            
            echo "Link:"
            carrier=$(cat /sys/class/net/$adapter/carrier)
            if [[ $carrier -ge 1 ]]; then
                echo "Physical link is up"
            else
                echo "Physical link is down"
                echo -e "\n"
            fi
            
            shift
        ;;
        
        *) echo "$1 is not an option";;
    esac
    shift
done
