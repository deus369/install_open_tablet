#!/bin/bash
sudo modprobe -r wacom
path=$HOME/projects/OpenTabletDriver/bin/OpenTabletDriver.Daemon
path2=$HOME/projects/OpenTabletDriver/bin/OpenTabletDriver.UX.Gtk
sudo --preserve-env=PATH,DOTNET_ROOT bash -c "$path &"
sudo --preserve-env=PATH,DOTNET_ROOT bash -c "$path2 &"
