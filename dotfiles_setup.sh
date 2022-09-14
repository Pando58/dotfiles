# Install packages
sudo pacman -S --needed - < $HOME/.pkglist/pacman

# Yay
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
# cd $HOME
