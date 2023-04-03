{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    picom
  ];

  xdg.configFile.picom = {
    source = ./picom;
    recursive = true;
  };
}
