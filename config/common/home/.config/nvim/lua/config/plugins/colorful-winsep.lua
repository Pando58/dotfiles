require("colorful-winsep").setup({
	smooth = false,
	symbols = { "─", "│", "┌", "┐", "└", "┘" },
	only_line_seq = false,
})

local modes = {
	n = "normal",
	i = "insert",
	v = "visual",
	V = "visual",
	[""] = "visual",
	c = "command",
	-- R = "replace",
	t = "terminal",
	nt = "normal",
}

local function get_mode_color(mode)
	return vim.api.nvim_get_hl(0, { name = "lualine_a_" .. modes[mode] }).bg
end

vim.api.nvim_create_autocmd({ "ModeChanged" }, {
	callback = function()
		local mode = vim.api.nvim_get_mode().mode

		if modes[mode] then
			vim.api.nvim_set_hl(0, "NvimSeparator", { fg = "#" .. string.format("%06x", get_mode_color(mode)) })
		end

		vim.cmd.redraw() -- for command mode
	end,
})
