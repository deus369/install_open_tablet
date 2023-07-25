#!/bin/bash

home_path=$HOME # "/home/deus"
# source $home_path/.bashrc
# ls $home_path/dotnet
echo "	> running open wacom daemon at [$HOME]"
# execute alias_command here
# echo "	> setting alias to [$home_path/dotnet/dotnet]"
# alias dotnet='$HOME/dotnet/dotnet'
echo "	> checking user dotnet version"
dotnet --version
# whereis dotnet
echo "	> checking sudo dotnet version"
sudo --preserve-env=PATH,DOTNET_ROOT bash -c "dotnet --version"
# sudo --preserve-env=PATH,DOTNET_ROOT bash -c "whereis dotnet"
echo "	> checking direct dotnet version"
$HOME/dotnet/dotnet --version

echo "	> ending wacom drivers"
sudo modprobe -r wacom

path1=$HOME/projects/OpenTabletDriver/bin/OpenTabletDriver.Daemon
echo "	> running daemon [$path1]"
# sudo --preserve-env=PATH,DOTNET_ROOT bash -c "gnome-terminal -- $path1"
sudo --preserve-env=PATH,DOTNET_ROOT bash -c $path1
# sleep 66666
# sudo -E bash -c "$path1"
# sleep 16

# sudo --preserve-env=PATH,DOTNET_ROOT bash -c "$path"
# sudo -E bash -c "dotnet --version"
# sudo -E bash -c "whereis dotnet"