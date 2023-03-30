{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    fish
  ];

  xdg.configFile.fish = {
    source = ./fish;
    recursive = true;
  };

  # programs.fish.enable = true;
}
