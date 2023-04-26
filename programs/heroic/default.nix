{
  pkgs-unstable,
  ...
}: {
  home.packages = with pkgs-unstable; [
    heroic
  ];
}
