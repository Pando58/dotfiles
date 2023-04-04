{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    geany
  ];

  xdg.configFile.geany = {
    source = ./geany;
    recursive = true;
  };
}
