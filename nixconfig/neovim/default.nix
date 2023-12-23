{
  config,
  pkgs,
  ...
}: let
  treesitter_packages = p: with p; [
    tree-sitter-lua
    tree-sitter-javascript
    tree-sitter-typescript
    tree-sitter-tsx
    tree-sitter-svelte
    tree-sitter-json
    tree-sitter-yaml
    tree-sitter-html
    tree-sitter-css
    tree-sitter-scss
    tree-sitter-rust
    tree-sitter-toml
    tree-sitter-nix
    tree-sitter-dockerfile
    tree-sitter-c
    tree-sitter-cpp
    tree-sitter-python
    tree-sitter-vim
    tree-sitter-vimdoc
    tree-sitter-bash
  ];
in {

  programs.neovim = {
    enable = true;

    extraPackages = with pkgs; [
      gcc
      ripgrep
      fd

      lua-language-server
      nodePackages.typescript-language-server
      nodePackages.svelte-language-server
      vscode-langservers-extracted # html, css, json and eslint
      tailwindcss-language-server
      emmet-ls
      rust-analyzer
      nixd
    ];

    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      neodev-nvim
      fidget-nvim

      (nvim-treesitter.withPlugins(treesitter_packages))

      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      luasnip
      cmp_luasnip
      friendly-snippets

      lualine-nvim
      barbar-nvim
      neo-tree-nvim
      nvim-web-devicons
      which-key-nvim
      indent-blankline-nvim

      telescope-nvim
      telescope-fzf-native-nvim
      telescope-undo-nvim
      actions-preview-nvim

      neoscroll-nvim
      mini-nvim
      nvim-autopairs
      nvim-ts-autotag
      comment-nvim
      vim-sleuth

      vim-fugitive
      gitsigns-nvim
      diffview-nvim

      sonokai
    ];
  };

  xdg.configFile = { # Takes precedence over extraLuaConfig, overrides init.lua
   "nvim/init.lua" = { source = ./nvim/nix_init.lua; };
   "nvim/after/plugin/config.lua" = { source = ./nvim/nix_after.lua; };
   "nvim/lua" = { source = ./nvim/lua; recursive = true; };
   "nvim/spell" = { source = ./nvim/spell; recursive = true; };
  };
}
