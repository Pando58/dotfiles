{
  pkgs,
  pkgs-unstable,
  username,
  ...
}: {
  home-manager.users.${username} = {
    home.packages = (with pkgs; [
      progress
      brave
      nodejs
      nodePackages.eslint_d
      gcc
    ]) ++ (with pkgs-unstable; [
      obsidian
      qpwgraph
      inkscape
    ]);
  };

  programs.git = {
    config = {
      user.email = "enr.pando@gmail.com";
      user.name = "Enrique pando";
    };
  };
}
