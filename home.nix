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
}
