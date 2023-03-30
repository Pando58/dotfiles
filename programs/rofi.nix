{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    rofi
    rofimoji
  ];

  #programs.rofi.enable = true;
}
