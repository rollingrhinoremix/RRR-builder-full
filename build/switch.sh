#!/bin/sh

# Initialise the development by grabbing assets
apt-get install git xdg-user-dirs -yq
mkdir -p ~/creation/assets && cd ~/creation || exit
git clone https://github.com/rollingrhinoremix/assets ~/creation/assets
# Perform system upgrade
apt-get update -y
apt-get upgrade -y
apt autopurge -y
# Move all required assets to the correct directories
mv ~/creation/assets/rolling_rhino.png /usr/share/backgrounds
mv ~/creation/assets/rolling_rhino-dark.png /usr/share/backgrounds
mv ~/creation/assets/.bash_aliases /etc/skel
mv ~/creation/assets/.bashrc /etc/skel
rm -rf /usr/share/glib-2.0/schemas/10_ubuntu-settings.gschema.override
mv ~/creation/assets/10_ubuntu-settings.gschema.override /usr/share/glib-2.0/schemas
# Install rhino-config onto system 
mkdir ~/creation/rhino-config
cd ~/creation/rhino-config
wget -q https://github.com/rollingrhinoremix/rhino-config/releases/latest/download/rhino-config
chmod +x ~/creation/rhino-config/rhino-config
mv ~/creation/rhino-config/rhino-config /usr/bin
# Install rhino-deinst onto system
mkdir ~/creation/rhino-deinst
cd ~/creation/rhino-deinst
wget -q https://github.com/rollingrhinoremix/rhino-deinst/releases/latest/download/rhino-deinst
chmod +x ~/creation/rhino-deinst/rhino-deinst
mv ~/creation/rhino-deinst/rhino-deinst /usr/bin
# Install the latest Linux kernel (from Ubuntu mainline repositories)
mkdir ~/creation/kernel
cd ~/creation/kernel
wget -q --show-progress --progress=bar:force https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.18.2/amd64/linux-headers-5.18.2-051802-generic_5.18.2-051802.202206060740_amd64.deb
wget -q --show-progress --progress=bar:force https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.18.2/amd64/linux-headers-5.18.2-051802_5.18.2-051802.202206060740_all.deb
wget -q --show-progress --progress=bar:force https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.18.2/amd64/linux-image-unsigned-5.18.2-051802-generic_5.18.2-051802.202206060740_amd64.deb
wget -q --show-progress --progress=bar:force https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.18.2/amd64/linux-modules-5.18.2-051802-generic_5.18.2-051802.202206060740_amd64.deb
sudo apt install ./*.deb -y
# Clean up system files
apt-get clean -y
sed -i 's/kinetic/devel/g' /etc/apt/sources.list
sed -i 's/kinetic/devel/g' /etc/lsb-release
sed -i 's/kinetic/devel/g' /usr/lib/os-release
#So much release info that are mostly same!
sed -i 's/PRETTY_NAME="Ubuntu Kinetic Kudu (development branch)"/PRETTY_NAME="Rolling Rhino Remix"/g' /etc/os-release
sed -i 's%HOME_URL="https://www.ubuntu.com/"%HOME_URL="https://www.rollingrhino.org"%g' /etc/os-release
apt-get --allow-releaseinfo-change update -y
apt-get --allow-releaseinfo-change dist-upgrade -y
apt-get autopurge -y
apt-get clean
echo '<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE wallpapers SYSTEM "gnome-wp-list.dtd">
<wallpapers>
  <wallpaper>
    <name>Rolling-Rhino</name>
    <name xml:lang="en_GB">Rolling-Rhino</name>
    <filename>/usr/share/backgrounds/rolling_rhino.png</filename>
    <filename-dark>/usr/share/backgrounds/rolling_rhino-dark.png</filename-dark>
    <options>zoom</options>
    <shade_type>solid</shade_type>
  </wallpaper>
</wallpapers>' > /usr/share/gnome-background-properties/rolling-rhino-wallpapers.xml
rm -rf ~/creation
