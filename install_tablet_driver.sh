#!/bin/bash
# wacom used opentabletdriver from github

# https://dotnet.microsoft.com/en-us/download/dotnet/thank-you/sdk-7.0.305-linux-arm64-binaries
dot_net_path=$HOME/dotnet # /usr/local/dotnet
driver_path=$HOME/projects/OpenTabletDriver # /usr/local/dotnet
dotnet_sdk_file="dotnet-sdk-7.0.305-linux-arm64.tar.gz"
dotnet_sdk_url="https://download.visualstudio.microsoft.com/download/pr/e2ca71f5-17e9-4dbd-aaf4-1e0fa225a212/61c440dae017c7129de10cfbfe36fd90/$dotnet_sdk_file"
user_bash_file=$HOME/.bashrc
root_bash_file=/root/.bashrc
lines_to_add=(
    "export DOTNET_ROOT=$dot_net_path"
    "export PATH=\$DOTNET_ROOT:\$PATH"
)
demon_path=$driver_path/bin/OpenTabletDriver.Daemon
ui_path=$driver_path/bin/OpenTabletDriver.UX.Gtk

# debug remove dotnet
# sudo rm -r $dot_net_path

# required packages
# sudo apt install libx11-dev libxrandr-dev libevdev-dev libgtk-3-dev
if command -v pacman &>/dev/null; then
    sudo pacman -S libx11 libxrandr libevdev gtk3
else
    sudo apt install libx11-dev libxrandr-dev libevdev-dev libgtk-3-dev
fi

# here we download and build it, works as long as dotnet version is configured
cd $HOME/projects
if [ ! -d OpenTabletDriver ]; then
    git clone https://github.com/OpenTabletDriver/OpenTabletDriver
else
    echo "   > project OpenTabletDriver found"
fi

# download microsoft dotnet at
cd $HOME/Downloads
if [ ! -f "$dotnet_sdk_file" ]; then
    wget "$dotnet_sdk_url"
else
    echo "   > dotnet tar found"
fi

# in downloads directory, unzip and copy to new directory
if [ ! -d "$dot_net_path" ]; then
    echo "   > dotnet directory not found"
    sudo mkdir -p $dot_net_path && sudo tar zxf dotnet-sdk-7.0.305-linux-arm64.tar.gz -C $dot_net_path
else
    echo "   > dotnet directory found"
fi

# set dotnet path for user
if ! grep -qF "export DOTNET_ROOT=\$HOME/dotnet" ~/.bashrc; then
    echo "export DOTNET_ROOT=\$HOME/dotnet" >> ~/.bashrc
fi
if ! grep -qF "export PATH=\$DOTNET_ROOT:\$PATH" ~/.bashrc; then
    echo "export PATH=\$DOTNET_ROOT:\$PATH" >> ~/.bashrc
fi

# add to end of file
# now load path
if sudo grep -qF "${lines_to_add[0]}" "$user_bash_file" && sudo grep -qF "${lines_to_add[1]}" "$user_bash_file"; then
    echo "Lines already exist in $user_bash_file. No changes made."
else
    printf "\n%s\n%s\n" "${lines_to_add[0]}" "${lines_to_add[1]}" >> "$user_bash_file"
    echo "Lines added to $user_bash_file."
fi
source $user_bash_file
echo "   > checking user dotnet version:"
dotnet --version # should be 7

# set dotnet path for root
if sudo grep -qF "${lines_to_add[0]}" "$root_bash_file" && sudo grep -qF "${lines_to_add[1]}" "$root_bash_file"; then
    echo "Lines are in $root_bash_file."
else
    echo "Lines not in $root_bash_file."
    echo "Lines not in $root_bash_file."
    {
        echo "${lines_to_add[0]}"
        echo "${lines_to_add[1]}"
    } | sudo tee -a "$root_bash_file" >/dev/null
    # sudo cat $root_bash_file
fi
echo "   > checking root dotnet version:"
check_root_version="source $root_bash_file && dotnet --version"
sudo --preserve-env=PATH,DOTNET_ROOT bash -c "$check_root_version"


if [ -f $demon_path ]; then
    echo "driver is already built [$demon_path]"
else
    echo "   > building driver"
    # source $root_bash_file &&
    # sudo --preserve-env=PATH,DOTNET_ROOT bash -c "$bash_command"
    bash_command="bash $driver_path/build.sh linux-arm64 && bash $driver_path/generate-rules.sh"
    bash -c "$bash_command"
    sudo mv $driver_path/bin/99-opentabletdriver.rules /etc/udev/rules.d
    chmod +x $demon_path
    chmod +x $ui_path
fi

ls $driver_path/bin
echo "    > running daemon [$demon_path]"
# sudo $demon_path &
sudo --preserve-env=PATH,DOTNET_ROOT bash -c "$demon_path &"

echo "    > running ui [$ui_path]"
# sudo $ui_path &
sudo --preserve-env=PATH,DOTNET_ROOT bash -c "$ui_path &"
