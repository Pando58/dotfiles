{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    pcmanfm
    lxmenu-data # "open with" menu
  ];
}
