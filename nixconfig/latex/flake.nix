{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = inputs @ {
    nixpkgs,
    ...
  }: let
    pkgs = import nixpkgs {
      system = "x86_64-linux";
    };
  in {
    config = import ./main.nix { inherit pkgs; };
  };
}
