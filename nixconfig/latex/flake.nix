{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?rev=57d6973abba7ea108bac64ae7629e7431e0199b6";
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
