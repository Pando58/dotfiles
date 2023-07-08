-- Install package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- Configuration before lazy setup
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.termguicolors = true

-- Plugins
require("lazy").setup({
  {
    -- Icons
    "nvim-tree/nvim-web-devicons",
    opts = {},
  },

  {
    -- LSP configuration and plugins
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        -- External editor tooling manager
        "williamboman/mason.nvim",
        config = true
      },
      "williamboman/mason-lspconfig.nvim",
      {
        -- Progress UI for LSP
        "j-hui/fidget.nvim",
        opts = {
          window = {
            blend = 0,
          }
        }
      },
      -- Additional lua configuration
      "folke/neodev.nvim",
      {
        "MunifTanjim/eslint.nvim",
        dependencies = {
          "jose-elias-alvarez/null-ls.nvim",
        },
        config = function()
          local null_ls = require("null-ls")
          local eslint = require("eslint")

          null_ls.setup()

          eslint.setup({
            bin = 'eslint_d', -- or `eslint_d`
            code_actions = {
              enable = true,
              apply_on_save = {
                enable = true,
              },
            },
          })
        end,
      }
    },
  },

  {
    -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      {
        -- Tag completion
        "windwp/nvim-ts-autotag",
        opts = {},
      },
    },
    build = ":TSUpdate",
  },

  {
    -- Autocompletion
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip" },
  },

  {
    -- Fuzzy finder
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "debugloop/telescope-undo.nvim", -- Undo tree browser
    },
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    config = function()
      return vim.fn.executable "make" == 1
    end,
  },

  {
    -- Search and replace across files
    "nvim-pack/nvim-spectre",
    opts = {},
  },

  --[[ { -- Save sessions
    'rmagatti/auto-session',
    config = function()
      require("auto-session").setup()
    end,
  }, ]]

  -- Show pending keybinds
  { "folke/which-key.nvim",  opts = {} },

  -- Detect indentation
  "tpope/vim-sleuth",

  -- Git plugin
  "tpope/vim-fugitive",

  -- Comment mappings
  { "numToStr/Comment.nvim", opts = {} },

  -- Autopairs
  { "windwp/nvim-autopairs", opts = {} },

  {
    -- Selection movement
    "echasnovski/mini.move",
    version = '*',
    config = function()
      require("mini.move").setup()
    end,
  },

  {
    -- Show indentation lines
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("indent_blankline").setup({
        show_end_of_line = false,
        show_trailing_blankline_indent = false,
        char = "│",
        char_blankline = "┆",
        show_current_context = true,
        show_current_context_start = true,
      })
    end,
  },

  {
    -- Highlight word under cursor
    "yamatsum/nvim-cursorline",
    opts = {
      cursorline = { enable = false },
      cursorword = {
        enable = true,
        min_length = 1,
        hl = { underline = true },
      },
    },
  },

  {
    -- Status bar
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        section_separators = { left = "", right = "" },
        component_separators = { left = '·', right = '·' },
      },
      sections = {
        lualine_c = { { "filename", path = 1 } },
      },
    },
  },

  {
    "romgrk/barbar.nvim",
    dependencies = 'nvim-tree/nvim-web-devicons',
    init = function() vim.g.barbar_auto_setup = false end,
    config = function()
      require('bufferline').setup({
        animation = false
      })

      vim.opt.showtabline = 2
    end,
  },

  {
    -- File explorer
    "nvim-tree/nvim-tree.lua",
    opts = {
      git = {
        ignore = false,
      },
    },
  },

  --[[ { -- Notification popup
    "rcarriga/nvim-notify",
    config = function ()
      require("notify").setup({
        background_colour = "#000000",
      })

      vim.notify = require("notify")
    end,
  }, ]]

  -- Themes
  {
    "navarasu/onedark.nvim",
    priority = 1000,
    opts = {
      style = "dark",
      transparent = true,
    },
  },
  {
    "loctvl842/monokai-pro.nvim",
    priority = 1000,
    opts = {
      filter = "spectrum",
      transparent_background = true,
    },
  },
  {
    "sainnhe/edge",
    priority = 1000,
    config = function()
      vim.g.edge_style = "default"
      vim.g.edge_transparent_background = 1
    end,
  },
  {
    "sainnhe/sonokai",
    priority = 1000,
    config = function()
      vim.g.sonokai_style = "atlantis"
      vim.g.sonokai_transparent_background = 1
    end,
  },
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    opts = {
      style = "moon",
      transparent = true,
    },
  },
  {
    "savq/melange-nvim",
    priority = 1000,
  },
})

-- Options
vim.opt.list = true
vim.opt.listchars:append "trail:▓"

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 10
vim.opt.wrap = false

vim.opt.cursorline = true
vim.opt.cursorcolumn = true

vim.opt.mouse = "a"

vim.opt.breakindent = true

vim.opt.undofile = true

vim.o.updatetime = 500
vim.opt.timeoutlen = 200 -- Set timeout for which-key

vim.cmd.colorscheme("sonokai")

-- Disable automatic comments on new lines
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end
})

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({
      timeout = 100,
    })
  end,
  group = highlight_group,
  pattern = '*',
})

-- Configure Treesitter
require("nvim-treesitter.configs").setup {
  ensure_installed = { "lua", "javascript", "typescript", "tsx", "rust" },
  auto_install = false,
  highlight = { enable = true },
  indent = { enable = true, disable = { "python" } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<c-space>",
      node_incremental = "<c-space>",
      scope_incremental = "<c-s>",
      node_decremental = "<M-space>",
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]f"] = "@function.outer",
        ["]c"] = "@class.outer",
      },
      goto_next_end = {
        ["]F"] = "@function.outer",
        ["]C"] = "@class.outer",
      },
      goto_previous_start = {
        ["[f"] = "@function.outer",
        ["[c"] = "@class.outer",
      },
      goto_previous_end = {
        ["[F"] = "@function.outer",
        ["[c"] = "@class.outer",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>a"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>A"] = "@parameter.inner",
      },
    },
  },
}

-- Configure Telescope
require("telescope").setup {
  defaults = {
    layout_strategy = 'horizontal',
    layout_config = {
      prompt_position = "top",
    },
    sorting_strategy = "ascending",
    mappings = {
      i = {
        ["<C-u>"] = false,
        ["<C-d>"] = false,
      },
    },
  },
  extensions = {
    undo = {
      side_by_side = true,
      layout_strategy = "vertical",
      layout_config = {
        preview_height = 0.8,
      },
      mappings = {
        i = {
          ["<CR>"] = require("telescope-undo.actions").yank_additions,
          ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
          ["<C-cr>"] = require("telescope-undo.actions").restore,
        },
      },
    },
  },
}

pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "undo")

-- Enable language servers
local servers = {
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
  tsserver = {},
  cssls = {},
  emmet_ls = {},
  rust_analyzer = {},
}


-- Setup neovim lua configuration
require("neodev").setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require "mason-lspconfig"

mason_lspconfig.setup({
  ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
  function(server_name)
    require("lspconfig")[server_name].setup {
      capabilities = capabilities,
      on_attach = function(_, bufnr)
        local nmap = function(keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end

          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end

        nmap('<leader>lr', vim.lsp.buf.rename, '[r]ename')
        nmap('<leader>la', vim.lsp.buf.code_action, 'Code [a]ction')
        nmap('<leader>ld', vim.lsp.buf.definition, 'Go to [d]efinition')
        nmap('<leader>lD', vim.lsp.buf.type_definition, 'Go to type [D]efinition')
        nmap('<leader>li', vim.lsp.buf.implementation, 'Goto [i]mplementation')
        nmap('<leader>lr', require('telescope.builtin').lsp_references, 'Go to [r]eferences')
        nmap('<leader>ls', require('telescope.builtin').lsp_document_symbols, 'Document [s]ymbols')
        nmap('<leader>lS', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace [S]ymbols')
        nmap('<leader>lk', vim.lsp.buf.hover, 'Hover Documentation')
        nmap('<leader>lK', vim.lsp.buf.signature_help, 'Signature Documentation')

        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function()
          vim.lsp.buf.format()
        end, { desc = 'Format current buffer with LSP' })

        vim.api.nvim_buf_create_user_command(bufnr, 'W', function()
          vim.lsp.buf.format()
          vim.cmd.write()
        end, { desc = 'Format and save current buffer' })
      end,
      settings = servers[server_name],
    }
  end,
})

-- nvim-cmp setup
local cmp = require "cmp"
local luasnip = require "luasnip"

luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete {},
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
  }),
}

-- Keymaps
vim.keymap.set({ "n", "x" }, "<Space>", "<Nop>", { silent = true })

vim.keymap.set("n", "<C-d>", "<C-d>M")
vim.keymap.set("n", "<C-u>", "<C-u>M")
vim.keymap.set("n", "D", "10<C-e>")
vim.keymap.set("n", "U", "10<C-y>")
-- vim.keymap.set("n", "n", "nzzzv")
-- vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("i", "<C-h>", "<Left>")
vim.keymap.set("i", "<C-j>", "<Down>")
vim.keymap.set("i", "<C-k>", "<Up>")
vim.keymap.set("i", "<C-l>", "<Right>")

vim.keymap.set({ "n", "x" }, "<leader>D", "\"_d")
vim.keymap.set("x", "<leader>c", "\"_c")
vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set("n", "<C-j>", "i<CR><Esc>")

vim.keymap.set('n', '<leader>t', ':terminal<CR>i', { desc = "Open a new terminal window", silent = true })
vim.keymap.set('t', '<C-[>', '<C-\\><C-n>', { desc = "Exit terminal mode" })

vim.api.nvim_create_user_command('Q', function() vim.cmd.quitall() end, {})

vim.keymap.set('n', '<leader>dh', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set('n', '<leader>dl', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set('n', '<leader>dm', vim.diagnostic.open_float, { desc = "Open floating [d]iagnostic [m]essage" })
vim.keymap.set('n', '<leader>dL', vim.diagnostic.setloclist, { desc = "Open [d]iagnostics [l]ist" })

vim.keymap.set('n', '<leader>wh', ':vsplit<CR>', { silent = true })
vim.keymap.set('n', '<leader>wj', ':split<CR><C-w>j', { silent = true })
vim.keymap.set('n', '<leader>wk', ':split<CR>', { silent = true })
vim.keymap.set('n', '<leader>wl', ':vsplit<CR><C-w>l', { silent = true })

vim.keymap.set('n', '<leader><tab>n', ":tabnew<CR>", { desc = "New tab", silent = true })
vim.keymap.set('n', '<leader><tab>q', ":tabclose<CR>", { desc = "Close tab", silent = true })
vim.keymap.set('n', '<leader><tab>h', ":tabprev<CR>", { desc = "Go to previous tab", silent = true })
vim.keymap.set('n', '<leader><tab>l', ":tabnext<CR>", { desc = "Go to next tab", silent = true })

vim.keymap.set('n', '<A-,>', "<Cmd>BufferPrevious<CR>", { silent = true })
vim.keymap.set('n', '<A-.>', "<Cmd>BufferNext<CR>", { silent = true })
vim.keymap.set('n', '<A-<>', "<Cmd>BufferMovePrevious<CR>", { silent = true })
vim.keymap.set('n', '<A->>', "<Cmd>BufferMoveNext<CR>", { silent = true })
vim.keymap.set('n', '<A-q>', "<Cmd>BufferClose<CR>", { desc = "Close current buffer", silent = true })

vim.keymap.set('n', '<leader>e', ":NvimTreeToggle<CR>", { desc = "Go to next tab", silent = true })

vim.keymap.set('n', '<leader>SO', '<Cmd>lua require("spectre").open()<CR>',
  { desc = "Open Spectre" })
vim.keymap.set('n', '<leader>SW', '<Cmd>lua require("spectre").open_visual({select_word=true})<CR>',
  { desc = "Search current word" })
vim.keymap.set('v', '<leader>SW', '<Esc><Cmd>lua require("spectre").open_visual()<CR>',
  { desc = "Search current word" })
vim.keymap.set('n', '<leader>SF', '<Cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
  { desc = "Search on current file" })
vim.keymap.set('v', '<leader>SF', '<Esc><Cmd>lua require("spectre").open_file_search()<CR>',
  { desc = "Search current word" })

local telescope = require("telescope")
local telescope_builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>sb', telescope_builtin.current_buffer_fuzzy_find, { desc = '[s]earch in current [b]uffer' })
vim.keymap.set('n', '<leader>sB', telescope_builtin.buffers, { desc = '[s]earch [B]uffers' })
vim.keymap.set('n', '<leader>sf', telescope_builtin.find_files, { desc = '[s]earch [f]iles in current directory' })
vim.keymap.set('n', '<leader>sF', telescope_builtin.oldfiles, { desc = '[s]earch old [F]iles' })
vim.keymap.set('n', '<leader>sh', telescope_builtin.help_tags, { desc = '[s]earch [h]elp' })
vim.keymap.set('n', '<leader>sc', telescope_builtin.commands, { desc = '[s]earch [c]ommands' })
vim.keymap.set('n', '<leader>sr', telescope_builtin.registers, { desc = '[s]earch [r]egisters' })
vim.keymap.set('n', '<leader>sw', telescope_builtin.grep_string, { desc = '[s]earch current [w]ord' })
vim.keymap.set('n', '<leader>sG', telescope_builtin.live_grep, { desc = '[s]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', telescope_builtin.diagnostics, { desc = '[s]earch [d]iagnostics' })
vim.keymap.set('n', '<leader>su', telescope.extensions.undo.undo, { desc = '[s]earch [g]it [b]ranches' })
vim.keymap.set('n', '<leader>sgs', telescope_builtin.git_status, { desc = '[s]earch [g]it [s]tatus' })
vim.keymap.set('n', '<leader>sgS', telescope_builtin.git_stash, { desc = '[s]earch [g]it [s]tash' })
vim.keymap.set('n', '<leader>sgc', telescope_builtin.git_commits, { desc = '[s]earch [g]it [c]ommits' })
vim.keymap.set('n', '<leader>sgb', telescope_builtin.git_branches, { desc = '[s]earch [g]it [b]ranches' })
