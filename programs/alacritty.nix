{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    alacritty
  ];

  xdg.configFile.alacritty = {
    source = ../config/alacritty;
    recursive = true;
  };

  /*programs.alacritty.enable = true;

  programs.alacritty = {
    enable = true;

    settings = {
      window = {
        opacity = 0.85;
        dynamic_padding = true;
        padding = {
          x = 6;
          y = 6;
        };
      };
      font = {
        size = 10;
        normal.family = "JetBrains Mono Nerd Font";
      };
      selection.save_to_clipboard = true;
      cursor = {
        style = {
          shape = "Beam";
          blinking = "On";
        };
      };
      shell.program = "fish";
    };
  };*/
}
