{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./programs
  ];

  nixpkgs.config.allowUnfree = true;

  # fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  home = {
    username = "user";
    homeDirectory = "/home/user";
    stateVersion = "22.11";
  };
}
