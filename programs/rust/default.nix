{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    gcc
    rustc
    cargo
    rustfmt
    rust-analyzer
  ];
}
