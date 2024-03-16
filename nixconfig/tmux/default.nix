{
  pkgs,
  ...
}: {
  programs.tmux = {
    enable = true;
    package = pkgs.tmux;
    /* plugins = with pkgs.tmuxPlugins; [
      mode-indicator
    ];
    sensibleOnTop = false;
    extraConfig = ""; */
  };


  xdg.configFile = { # overrides default tmux.conf
    tmux = { recursive = true; source = ./tmux; };
  };
}
