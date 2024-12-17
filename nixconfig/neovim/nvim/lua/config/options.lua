vim.g.mapleader = " "
vim.g.maplocalleader = " "

for option, value in pairs({
	tabstop = 4,
	shiftwidth = 4,

	termguicolors = true,

	number = true,
	relativenumber = true,
	signcolumn = "yes",

	list = true,

	hlsearch = false,
	incsearch = true,

	scrolloff = 10,

	wrap = false,

	cursorline = true,
	cursorcolumn = true,

	showtabline = 2,

	mouse = "a",

	breakindent = true,

	undofile = true,

	updatetime = 500,

	jumpoptions = "",
}) do vim.opt[option] = value end

vim.opt.listchars:append("trail:▓")

-- Disable automatic comments on new lines
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function ()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end
})

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function ()
		vim.highlight.on_yank({
			timeout = 100,
		})
	end,
	group = highlight_group,
	pattern = '*',
})

-- Diagnostic icons
vim.fn.sign_define("DiagnosticSignError", {text = " ", texthl = "DiagnosticSignError"})
vim.fn.sign_define("DiagnosticSignWarn", {text = " ", texthl = "DiagnosticSignWarn"})
vim.fn.sign_define("DiagnosticSignInfo", {text = " ", texthl = "DiagnosticSignInfo"})
vim.fn.sign_define("DiagnosticSignHint", {text = "󰌵", texthl = "DiagnosticSignHint"})
