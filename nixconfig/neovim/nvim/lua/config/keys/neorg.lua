return {
	keys = function ()
		vim.keymap.set("n", "<leader>oc", ":Neorg toggle-concealer<CR>", { desc = "Ne[o]rg toggle [c]oncealer" })
		vim.keymap.set("n", "<leader>ot", ":Neorg toc<CR>", { desc = "Ne[o]rg open [t]able of contents" })
	end,
}
