#!/bin/bash

filename=open_tablet.desktop

echo ">	desktop file is $filename"
cp bash/$filename ~/.local/share/applications/$filename
echo ">	copied $filename to ~/.local/share/applications"

# run_daemon_command="bash /home/deus/projects/install_open_tablet/run_daemon.sh"
# install_command_file="/etc/rc.d/rc.local"
# if ! grep -qF "$run_daemon_command" $install_command_file; then
#    echo "   > added [$run_daemon_command] to bashrc file"
#    echo "$run_daemon_command" >> $install_command_file
#	chmod +x /etc/rc.d/rc.local
#else
#    echo "   > found [$run_daemon_command] in bashrc file"
#fi