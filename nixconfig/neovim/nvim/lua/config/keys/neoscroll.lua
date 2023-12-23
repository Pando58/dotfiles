local neoscroll = require("neoscroll")

local function map(keys, f, value, spd, center_cursor)
	vim.keymap.set({ "n", "x" }, keys, function ()
		if center_cursor then vim.api.nvim_input("M") end
		neoscroll[f](
			value == "full"
				and vim.api.nvim_win_get_height(0)
				or value == "-full"
				and -vim.api.nvim_win_get_height(0)
				or value,
			center_cursor,
			spd,
			"circular"
		)
	end, { desc = "[e]xplorer [o]pen", silent = true })
end

local speed = 100;

return {
	keys = function ()
		map("<C-d>", "scroll", 0.5, speed, true)
		map("<C-u>", "scroll", -0.5, speed, true)
		map("<C-f>", "scroll", "full", speed, true)
		map("<C-b>", "scroll", "-full", speed, true)
		map("D", "scroll", 0.25, speed, true)
		map("U", "scroll", -0.25, speed, true)
	end,
}
