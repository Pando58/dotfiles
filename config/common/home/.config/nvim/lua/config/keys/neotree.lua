local function map(keys, action, desc)
	vim.keymap.set("n", keys, action, { desc = desc, silent = true })
end

return {
	keys = function ()
		-- Open file explorer plugin
		map("<leader>eo", ":Neotree focus reveal<CR>", "[e]xplorer [o]pen")
		map("<leader>ef", ":Neotree focus<CR>", "[e]xplorer [f]ocus")
		map("<leader>es", ":Neotree show reveal<CR>", "[e]xplorer [s]how")
		map("<leader>ec", ":Neotree close<CR>", "[e]xplorer [c]lose")
		map("<leader>eb", ":Neotree float buffers reveal<CR>", "[e]xplorer [b]uffers")
		map("<leader>eg", ":Neotree float git_status reveal<CR>", "[e]xplorer [g]it status")
	end,
}
