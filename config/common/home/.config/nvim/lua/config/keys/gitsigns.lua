local gs = require("gitsigns")

local function map(keys, action, desc)
	vim.keymap.set("n", keys, action, { desc = desc, silent = true })
end

return {
	keys = function ()
		map("<leader>gm", gs.toggle_current_line_blame, "[g]it toggle line commit [m]essage")
		map("<leader>gw", gs.toggle_word_diff, "[g]it toggle [w]ord diff")
		map("<leader>ge", function ()
			gs.toggle_linehl()
			gs.toggle_numhl()
			gs.toggle_deleted()
		end, "[g]it toggle [e]xpand hunks")
		map("<leader>ghs", gs.stage_hunk, "[g]it [h]unk [s]tage")
		map("<leader>ghu", gs.undo_stage_hunk, "[g]it [h]unk [u]ndo stage")
		map("<leader>ghp", gs.preview_hunk_inline, "[g]it [h]unk [p]review")
		map("<leader>ghr", gs.reset_hunk, "[g]it [h]unk [r]eset")

		vim.keymap.set("v", "<leader>gs", ":'<,'>Gitsigns stage_hunk<CR>", { desc = "[g]it [s]tage visual selection", silent = true })

		vim.keymap.set("n", "]h", function ()
			if vim.wo.diff then return "]h" end
			vim.schedule(function () gs.next_hunk() end)
			return "<Ignore>"
		end, { expr = true, desc = "Next hunk" })

		vim.keymap.set("n", "[h", function ()
			if vim.wo.diff then return "[h" end
			vim.schedule(function () gs.prev_hunk() end)
			return "<Ignore>"
		end, { expr = true, desc = "Previous hunk" })
	end,
}
