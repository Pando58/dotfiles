{
  pkgs,
  stateVersion,
  ...
}: let
  username = "user";
in {
  users.users.${username} = {
    isNormalUser = true;
    description = "User";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  services.xserver.enable = true;
  services.xserver.windowManager.awesome.enable = true;

  home-manager.users.${username} = {
    home = {
      inherit username stateVersion;
      homeDirectory = "/home/${username}";
    };

    imports = map (f: ../../programs + "/${f}") [
      "git"
      "awesome"
      "fish"
      "neofetch"
      "alacritty"
      "rofi"
      "brave"
      "vscodium"
      "nodejs"
      "rust"
    ];

    home.packages = with pkgs; [
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
  };
}
