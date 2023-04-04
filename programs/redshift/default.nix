{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    redshift
  ];
}
