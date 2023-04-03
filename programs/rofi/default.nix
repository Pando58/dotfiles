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

  xdg.configFile.rofimoji = {
    source = ./rofimoji;
    recursive = true;
  };

  xdg.configFile."rofimoji.rc" = {
    source = ./rofimoji.rc;
  };

  #programs.rofi.enable = true;
}
