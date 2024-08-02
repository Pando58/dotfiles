local function map(keys, action, desc)
	vim.keymap.set("n", keys, action, { desc = desc, silent = true })
end

return {
	keys = function ()
		map("<leader>mp", ":MarkdownPreview<CR>", "[m]arkdown [p]review")
		map("<leader>ms", ":MarkdownPreviewStop<CR>", "[m]arkdown preview [s]top")
	end,
}
