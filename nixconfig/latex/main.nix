{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    texliveFull
    zathura
  ];

  xdg.configFile = {
    zathura = { recursive = true; source = ./zathura; };
  };
}
