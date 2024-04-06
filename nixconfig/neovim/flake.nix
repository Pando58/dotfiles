{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    plugin-neorg = {
      url = "github:nvim-neorg/neorg";
      flake = false;
    };
    plugin-lua-utils = {
      url = "github:nvim-neorg/lua-utils.nvim";
      flake = false;
    };
    plugin-nvim-nio = {
      url = "github:nvim-neotest/nvim-nio";
      flake = false;
    };
    plugin-pathlib = {
      url = "github:pysan3/pathlib.nvim";
      flake = false;
    };
  };

  outputs = inputs @ {
    nixpkgs,
    ...
  }: let
    pkgs = import nixpkgs {
      system = "x86_64-linux";

      overlays = [
        (final: prev: {
          vimPlugins = prev.vimPlugins // {
            neorg = prev.vimUtils.buildVimPlugin {
              name = "neorg";
              src = inputs.plugin-neorg;
            };
            lua-utils = prev.vimUtils.buildVimPlugin {
              name = "lua-utils";
              src = inputs.plugin-lua-utils;
            };
            nvim-nio = prev.vimUtils.buildVimPlugin {
              name = "nvim-nio";
              src = inputs.plugin-nvim-nio;
            };
            pathlib = prev.vimUtils.buildVimPlugin {
              name = "pathlib";
              src = inputs.plugin-pathlib;
            };
          };
        })
      ];
    };
  in {
    config = import ./main.nix { inherit pkgs; };
  };
}
