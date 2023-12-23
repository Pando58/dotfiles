return {
	keys = function ()
		vim.keymap.set("n", "<leader>vo", ":DiffviewOpen<CR>", { desc = "Show diff view" })
		vim.keymap.set("n", "<leader>vc", ":DiffviewClose<CR>", { desc = "Close diff view" })
	end,
}
