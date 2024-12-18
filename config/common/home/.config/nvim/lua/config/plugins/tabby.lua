local api = require("tabby.module.api")
local win_name = require('tabby.feature.win_name')

local theme = {
	fill = "Whitespace",
	win = "TabLineFill",
	current_win = "PMenu",
	tab = "PMenu",
	current_tab = "TabLineSelBold",
	head = "TabLineFill",
	tail = "TabLineFill",
}

require("tabby.tabline").set(function(line)
	vim.api.nvim_set_hl(0, "TabLineSelBold",
		vim.tbl_extend("force", {}, vim.api.nvim_get_hl(0, { name = "TabLineSel" }), { bold = true }))

	return {
		{
			{ "  ", hl = theme.head },
			line.sep("", theme.head, theme.fill),
		},
		line.tabs().foreach(function(tab)
			local current = tab.is_current()
			local hl = current and theme.current_tab or theme.tab

			return {
				line.sep("", hl, theme.fill),
				tab.number(),
				tab.name(),
				tab.close_btn(""),
				line.sep("", hl, theme.fill),
				hl = hl,
				margin = " ",
			}
		end),
		line.spacer(),
		--[[ line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
			local current = win.is_current()
			local hl = current and theme.current_win or theme.win

			return {
				line.sep("", hl, theme.fill),
				current and "●" or "○",
				win.buf_name(),
				line.sep("", hl, theme.fill),
				hl = hl,
				margin = " ",
			}
		end),
		{
			line.sep("", theme.tail, theme.fill),
			{ " ", hl = theme.tail },
		}, ]]
		hl = theme.fill,
	}
end, {
	tab_name = {
		name_fallback = function(tabid)
			local wins = api.get_tab_wins(tabid)
			local cur_win = api.get_tab_current_win(tabid)

			local name =
				(api.is_float_win(cur_win) and "[F] " or "") ..
				win_name.get(cur_win) ..
				(#wins > 1 and string.format(" [%d]", #wins) or "")

			return name
		end,
	},
})
