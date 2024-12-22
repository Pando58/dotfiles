local winbar_config = {
	lualine_c = {
		{
			"", -- filename
			fmt = function() return "%=%r%m %f" end,
			path = 1,
			color = { bg = "transparent" },
		},
		{
			"filetype",
			color = { bg = "transparent" },
		},
	},
}

require("lualine").setup({
	options = {
		section_separators = { left = "", right = "" },
		component_separators = { left = "·", right = "·" },
		globalstatus = true, -- or vim.opt.laststatus = 3
	},
	sections = {
		lualine_c = {
			{ "filename", path = 1 },
		},
	},
	inactive_winbar = winbar_config,
	winbar = winbar_config,
})


-- winbar - options_after.lua

--[[ vim.opt.winbar = "%=%h%w%q%r%m %f"

local hl_winbar = vim.api.nvim_get_hl(0, { name = "WinBar" })
local hl_winbarnc = vim.api.nvim_get_hl(0, { name = "WinBarNC" })

hl_winbar["bg"] = nil
hl_winbarnc["bg"] = nil

-- local separator_color = vim.api.nvim_get_hl(0, { name = "VertSplit" }).fg
-- hl_winbar = vim.tbl_extend("force", {}, hl_winbar, { underline = true, sp = separator_color })

vim.api.nvim_set_hl(0, "WinBar", hl_winbar)
vim.api.nvim_set_hl(0, "WinBarNC", hl_winbarnc) ]]
