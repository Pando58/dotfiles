{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    carla
  ];
}
