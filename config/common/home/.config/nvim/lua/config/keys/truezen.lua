return {
	keys = function ()
		vim.keymap.set("n", "<leader>zf", ":TZFocus<CR>", { desc = "[z]en toggle [f]ocus" })
	end,
}
