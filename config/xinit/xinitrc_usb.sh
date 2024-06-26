#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/nix/store/yrwf6s0z8ig9sx3fry3225wl0ax2yihn-xinit-1.4.2/etc/X11/xinit/.Xresources
sysmodmap=/nix/store/yrwf6s0z8ig9sx3fry3225wl0ax2yihn-xinit-1.4.2/etc/X11/xinit/.Xmodmap

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# Session

dex -a -s /mnt/K128_files/config/autostart &

exec awesome
