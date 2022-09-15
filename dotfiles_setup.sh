pkgs_pacman=$HOME/.pkglist/pacman
pkgs_aur=$HOME/.pkglist/aur

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

# Wallpaper
nitrogen --set-zoom-fill $HOME/Pictures/Wallpapers/949049.png
