require("config.plugins.lsp").setup_mason()
require("config.plugins.treesitter")({ using_nix = false })
require("config.plugins.init_common")
