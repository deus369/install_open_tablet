#!/bin/bash
sudo modprobe -r wacom
path=/home/alarm/projects/OpenTabletDriver/bin/OpenTabletDriver.Daemon
path2=/home/alarm/projects/OpenTabletDriver/bin/OpenTabletDriver.UX.Gtk
sudo --preserve-env=PATH,DOTNET_ROOT bash -c "$path &"
sudo --preserve-env=PATH,DOTNET_ROOT bash -c "$path2 &"
