pkgs_pacman=$(pwd)/.pkglist/pacman
pkgs_aur=$(pwd)/.pkglist/aur

# Install packages
sudo pacman -S --needed - < $pkgs_pacman

# Install Yay
if ! [[ $(command -v yay) ]]; then
    git clone https://aur.archlinux.org/yay-bin.git
    cd yay-bin
    makepkg -si
    cd ..
fi

# Install yay packages
for pkg in $(<$pkgs_aur); do
    yay -S --answerdiff None "$pkg"
done

# Move everything to home and set dotfiles git folder to ~/.dotfiles
shopt -s dotglob
mv $(pwd)/.git $(pwd)/.dotfiles
cp -r $(pwd)/* $HOME
echo "Deleting: $(pwd)"
echo "(y/n)"
rm -rI $(pwd)

# Generate default user folders
xdg-user-dirs-update

# Wallpaper
nitrogen --set-zoom-fill $HOME/Pictures/Wallpapers/949049.png

# mpd
mkdir -p $HOME/.mpd/playlists
