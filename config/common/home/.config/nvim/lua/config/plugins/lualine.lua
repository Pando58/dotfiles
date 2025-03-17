--[[ local winbar_config = {
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
} ]]

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
	-- inactive_winbar = winbar_config,
	-- winbar = winbar_config,
})
