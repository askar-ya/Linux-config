#!/bin/bash
ssh-askpass > .pass
password=$(cat ~/soft/vpn/.pass )
echo "print $password!"


if [ "$password" ==  "" ];
then
	/home/askar/soft/vpn/Hiddify-Linux-x64.AppImage
else
	echo $password | sudo -S /home/askar/soft/vpn/Hiddify-Linux-x64.AppImage
fi
#/home/askar/soft/vpn/Hiddify-Linux-x64.AppImage
