basedir=$(dirname "$0")
pkgs_pacman=$basedir/.pkglist/pacman
pkgs_aur=$basedir/.pkglist/aur

# Install packages
sudo pacman -S --needed - < "$pkgs_pacman"

# Install Yay
if ! [[ $(command -v yay) ]]; then
    cd "$HOME"
    git clone https://aur.archlinux.org/yay-bin.git
    cd yay-bin
    makepkg -si
    cd "$basedir"
    rm -rf "$HOME"/yay-bin
fi

# Install yay packages
for pkg in $(<$pkgs_aur); do
    yay -S --answerdiff None "$pkg"
done

# Launch wm from custom script
sudo cp "$basedir"/.xsessions/*.desktop /usr/share/xsessions

# Move everything to home and set dotfiles git folder to ~/.dotfiles
shopt -s dotglob
mv "$basedir/.git" "$HOME/.dotfiles"
cp -r "$basedir"/* "$HOME"

echo "Deleting: $basedir"
read -p "Are you sure? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    rm -rf "$basedir"
else
    echo "Aborting delete"
    # [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi

# Generate default user folders
xdg-user-dirs-update

# Wallpaper
nitrogen --set-zoom-fill --save "$HOME/Pictures/Wallpapers/949049.png"

# mpd
mkdir -p "$HOME/.mpd/playlists"
