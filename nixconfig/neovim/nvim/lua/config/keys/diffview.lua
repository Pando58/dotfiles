return {
	keys = function ()
		vim.keymap.set("n", "<leader>vo", ":DiffviewOpen<CR>", { desc = "Open diffview" })
		vim.keymap.set("n", "<leader>vc", ":DiffviewClose<CR>", { desc = "Close diffview" })
		vim.keymap.set("n", "<leader>vh", ":DiffviewFileHistory<CR>", { desc = "Show diffview git history" })
	end,
}
