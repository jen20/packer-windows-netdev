echo Rebooting Machine
shutdown /r /t 1 /d p:4:1 /c "Packer Reboot"
echo Stopping OpenSSH
taskkill /im sshd.exe /f
