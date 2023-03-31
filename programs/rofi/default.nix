{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    rofi
    rofimoji
  ];

  xdg.configFile.rofi = {
    source = ./rofi;
    recursive = true;
  };

  #programs.rofi.enable = true;
}
