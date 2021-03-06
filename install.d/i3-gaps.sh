#!/usr/bin/env bash

deps='libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf libxcb-xrm0 libxcb-xrm-dev automake'
src_url='https://www.github.com/Airblader/i3'
dest='i3-gaps~repo'
prefix='/usr/local'
sysconfdir='/etc'

# Install dependencies
sudo apt install $deps || (echo 'Failed to install dependencies'; exit 1)

rm -rf "${dest}.tmp"
git clone "$src_url" "${dest}.tmp" || (echo 'Failed to clone the repo'; exit 1)
rm -rf "$dest"
mv -T "${dest}.tmp" "$dest"
cd "$dest"

# Compile & install
autoreconf --force --install
rm -rf build
mkdir -p build && cd build

../configure --prefix="$prefix" --sysconfdir="$sysconfdir" --disable-sanitizers
make
sudo make install

# Copy ssh-agent.service to systemd
rsync -a systemd/ ~/.config/systemd/
