{
  description = "Pando's dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";
    musnix.url = "github:musnix/musnix";
  };

  outputs = inputs @ {
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    nixos-generators,
    musnix,
    ...
  }: let
    system = "x86_64-linux";
    stateVersion = "23.05";
    hostname = "nixos";
    pkgs-unstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit pkgs-unstable hostname system stateVersion; };
      modules = [
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = { inherit pkgs-unstable; };
          };
        }
        musnix.nixosModules.musnix
        machines/main
      ];
    };
    packages.x86_64-linux.iso = nixos-generators.nixosGenerate {
      inherit system;
      format = "iso";
      specialArgs = { inherit pkgs-unstable hostname system stateVersion; };
      modules = [
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = { inherit pkgs-unstable; };
          };
        }
        machines/usb
      ];
    };
  };
}
