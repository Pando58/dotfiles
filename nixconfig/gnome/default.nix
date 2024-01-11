{
  pkgs,
  username,
  ...
}: {
  services.xserver = {
    enable = true;

    displayManager = {
      gdm.enable = true;
      gdm.wayland = false;

      autoLogin = {
	enable = true;
	user = username;
      };
    };

    desktopManager.gnome.enable = true;
  };

  environment.systemPackages = with pkgs; [
    gnome.gnome-tweaks
    gnome.dconf-editor
  ];

  # Conflicts with pipewire
  hardware.pulseaudio.enable = false;

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;
}
