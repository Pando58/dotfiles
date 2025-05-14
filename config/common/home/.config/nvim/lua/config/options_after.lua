vim.cmd.colorscheme("sonokai")

vim.lsp.set_log_level("OFF")

--[[ if (vim.api.nvim_win_get_width(0) > 160) then
	vim.cmd("Neotree show")
end ]]

-- from colorful-winsep.lua
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


vim.opt.winbar = "%=%h%w%q%r%m %f"

local hl_winbar = vim.api.nvim_get_hl(0, { name = "WinBar" })
local hl_winbarnc = vim.api.nvim_get_hl(0, { name = "WinBarNC" })

local win_separator_color = vim.api.nvim_get_hl(0, { name = "VertSplit" }).fg
local mode_color = get_mode_color("n")

hl_winbar["bg"] = nil
hl_winbarnc["bg"] = nil

hl_winbar = vim.tbl_extend("force", {}, hl_winbar, {
	-- fg = mode_color,
	sp = mode_color,
	underline = #vim.fn.tabpagebuflist() > 1,
})
hl_winbarnc = vim.tbl_extend("force", {}, hl_winbarnc, {
	sp = win_separator_color,
	underline = true,
})

vim.api.nvim_set_hl(0, "WinBar", hl_winbar)
vim.api.nvim_set_hl(0, "WinBarNC", hl_winbarnc)

-- neovim 0.11
-- "Whitespace" hl group was used in tabby to get a transparent background, but it doesn't work anymore
local hl_tablinefill = vim.api.nvim_get_hl(0, { name = "TabLineFill" })
hl_tablinefill = vim.tbl_extend("force", {}, hl_tablinefill, { bg = "none" })
vim.api.nvim_set_hl(0, "TabLineFill", hl_tablinefill)

vim.api.nvim_create_autocmd({ "ModeChanged" }, {
	callback = function()
		local mode = vim.api.nvim_get_mode().mode

		if modes[mode] then
			local sep_color = get_mode_color(mode)

			hl_winbar = vim.tbl_extend("force", {}, hl_winbar, {
				-- fg = sep_color,
				sp = sep_color,
			})

			vim.api.nvim_set_hl(0, "WinBar", hl_winbar)
		end

		vim.cmd.redraw() -- for command mode
	end,
})

vim.api.nvim_create_autocmd({ "WinNew", "TabEnter" }, {
	callback = function()
		hl_winbar = vim.tbl_extend("force", {}, hl_winbar, {
			underline = #vim.fn.tabpagebuflist() > 1,
		})

		vim.api.nvim_set_hl(0, "WinBar", hl_winbar)
	end
})

vim.api.nvim_create_autocmd({ "WinClosed" }, {
	callback = function()
		hl_winbar = vim.tbl_extend("force", {}, hl_winbar, {
			underline = #vim.fn.tabpagebuflist() > 2, -- updates before being removed
		})

		vim.api.nvim_set_hl(0, "WinBar", hl_winbar)
	end
})
