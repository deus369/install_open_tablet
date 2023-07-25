#!/bin/bash
home_path=$HOME # "/home/deus"
path1=$home_path/projects/OpenTabletDriver/bin/OpenTabletDriver.Daemon
path2=$home_path/projects/OpenTabletDriver/bin/OpenTabletDriver.UX.Gtk
sudo modprobe -r wacom
echo "	> running [$path1]"
sudo --preserve-env=PATH,DOTNET_ROOT $path1 &
sleep 1
echo "	> running [$path2]"
sudo --preserve-env=PATH,DOTNET_ROOT $path2 &

# sudo --preserve-env=PATH,DOTNET_ROOT bash -c "$path &"
# sudo --preserve-env=PATH,DOTNET_ROOT bash -c "sleep 3 && $path2 &"
#sudo --preserve-env=PATH,DOTNET_ROOT bash -c "$path &"

# sudo --preserve-env=PATH,DOTNET_ROOT bash -c "$path2 &"