require("config.plugins.lsp").setup_nix()
require("config.plugins.treesitter")({ using_nix = true })
require("config.plugins.init_common")
