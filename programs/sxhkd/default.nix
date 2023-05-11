{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    sxhkd
    xdotool
  ];
  
  xdg.configFile.sxhkd = {
    source = ./sxhkd;
    recursive = true;
  };
}
