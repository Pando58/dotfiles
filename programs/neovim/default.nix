{
  pkgs-unstable,
  ...
}: {
  home.packages = with pkgs-unstable; [
    neovim
  ];

  xdg.configFile.nvim = {
    source = ./nvim;
    recursive = true;
  };
}
