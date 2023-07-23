#!/bin/bash
sudo modprobe -r wacom
path=$HOME/projects/OpenTabletDriver/bin/OpenTabletDriver.Daemon
sudo --preserve-env=PATH,DOTNET_ROOT bash -c "$path"