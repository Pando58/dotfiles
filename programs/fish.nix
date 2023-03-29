{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    fish
  ];

  xdg.configFile.fish = {
    source = ../config/fish;
    recursive = true;
  };

  # programs.fish.enable = true;
}
