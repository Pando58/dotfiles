{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    awesome
  ];
  
  xdg.configFile.awesome = {
    source = ./awesome;
    recursive = true;
  };
}
