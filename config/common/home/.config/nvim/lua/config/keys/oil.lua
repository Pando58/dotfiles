local function map(keys, action, desc)
	vim.keymap.set("n", keys, action, { desc = desc, silent = true })
end

return {
	keys = function ()
		map("<leader>os", ":Oil<CR>", "[o]il [s]how")
	end,
}
