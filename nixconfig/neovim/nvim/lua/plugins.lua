return {
	"neovim/nvim-lspconfig", -- Configs for the LSP client
	"williamboman/mason.nvim", -- LSP manager
	{
		"williamboman/mason-lspconfig.nvim", -- Bridges mason with lspconfig
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},
	},
	"folke/neodev.nvim", -- Neovim config lua completion
	"j-hui/fidget.nvim", -- LSP notifications

	{
		"nvim-treesitter/nvim-treesitter", -- Syntax tree for highlighting
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
	},

	{
		"hrsh7th/nvim-cmp", -- Completion box
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
	},

	{
		"nvim-lualine/lualine.nvim", -- Bottom status bar
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- Filetype icons
		},
	},
	{
		-- Works without opts anyway, but the call to setup is still in config/plugins
		"romgrk/barbar.nvim", -- Tab bar
		version = '^1.0.0',
		dependencies = {
			"lewis6991/gitsigns.nvim", -- For git status
			"nvim-tree/nvim-web-devicons", -- For file icons
		},
	},
	{
		"nvim-neo-tree/neo-tree.nvim", -- File explorer sidebar
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim", -- Lua functions library
			"MunifTanjim/nui.nvim", -- UI component library
			"nvim-tree/nvim-web-devicons", -- Filetype icons
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
	},
	{
		"stevearc/oil.nvim",
		opts = {},
		dependencies = {
			"nvim-tree/nvim-web-devicons"
		},
	},
	"folke/which-key.nvim", -- Keys popup
	"lukas-reineke/indent-blankline.nvim", -- Show indentation lines

	{
		"nvim-telescope/telescope.nvim", -- Search over lists window
		dependencies = {
			"nvim-lua/plenary.nvim", -- Lua functions library
		},
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim", -- Fuzzy finder
		build = "make",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		cond = function ()
			return vim.fn.executable 'make' == 1
		end,
	},
	{
		"debugloop/telescope-undo.nvim", -- Undo tree browser
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
	},
	"aznhe21/actions-preview.nvim",

	-- "karb94/neoscroll.nvim",
	{
		"echasnovski/mini.nvim", -- Move selection with alt + hjkl
		version = '*', -- Stable
	},
	"windwp/nvim-autopairs", -- Autocomplete brackets and other characters
	{
		"windwp/nvim-ts-autotag", -- Close and rename html tags automatically
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},
	"numToStr/Comment.nvim", -- Comment key mappings
	"tpope/vim-sleuth", -- Detect file indentation

	"tpope/vim-fugitive", -- Git commands
	"lewis6991/gitsigns.nvim", -- Git decorations
	"sindrets/diffview.nvim", -- Diff comparison view

	-- Color schemes
	{ "sainnhe/sonokai", priority = 1000 },
}
