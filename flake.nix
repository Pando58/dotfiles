{
  description = "Pando's dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    musnix.url = "github:musnix/musnix";
    musnix.inputs.nixpkgs.follows = "nixpkgs-unstable";

    # latex-config.url = "path:nixconfig/latex";
  };

  outputs = inputs @ {
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    musnix,
    # latex-config,
    ...
  }: let
    system = "x86_64-linux";
    hostname = "nixos";
    pkgs-unstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
      overlays = [
          (final: prev: {
            vimPlugins = prev.vimPlugins // {
              colorful-winsep-nvim = prev.vimUtils.buildVimPlugin {
                name = "colorful-winsep-nvim";
                src = inputs.nvim-colorful-winsep;
              };
            };
          })
        ];
    };
  in {
    nixosConfigurations.main = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit pkgs-unstable hostname system; stateVersion = "23.11"; };
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
    nixosConfigurations.iso = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit pkgs-unstable hostname system; stateVersion = "23.11"; };
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
    nixosConfigurations.asus-f455l = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit pkgs-unstable hostname system; stateVersion = "23.11"; };
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
        machines/asus-f455l
      ];
    };
  };
}
