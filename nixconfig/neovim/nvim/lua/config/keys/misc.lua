local function map(mode, keys, action, opts)
	vim.keymap.set(mode, keys, action, opts)
end

return {
	keys = function ()
		map({ "n", "x" }, "<Space>", "<Nop>", { silent = true })

		-- Quit all with :Q
		vim.api.nvim_create_user_command("Q", ":qa", {})

		-- Keep the cursor in the middle when jumping
		-- map("n", "<C-d>", "<C-d>M")
		-- map("n", "<C-u>", "<C-u>M")
		-- map("n", "<C-f>", "<C-f>M")
		-- map("n", "<C-b>", "<C-b>M")

		-- Move by 25% of the window height
		map({ "n", "x" }, "D", function () vim.api.nvim_input(math.floor(vim.api.nvim_win_get_height(0) / 4) .. "<C-e>") end)
		map({ "n", "x" }, "U", function () vim.api.nvim_input(math.floor(vim.api.nvim_win_get_height(0) / 4) .. "<C-y>") end)

		-- Move with ctrl + hjkl in insert mode
		map("i", "<C-h>", "<Left>")
		map("i", "<C-j>", "<Down>")
		map("i", "<C-k>", "<Up>")
		map("i", "<C-l>", "<Right>")

		-- Delete, change and paste without replacing the default register
		map({ "n", "x" }, "<leader>D", "\"_d", { desc = "Delete without replacing the default register" })
		map({ "n", "x" }, "<leader>c", "\"_c", { desc = "Change without replacing the default register" })
		map("x", "<leader>p", "\"_dP", { desc = "Paste without replacing the default register" })

		-- Copy to the system clipboard
		vim.keymap.set({ "n", "x" }, "<leader>y", "\"+y", { desc = "Yank to the system clipboard" })

		-- Split line at the cursor
		map("n", "<C-j>", "i<CR><Esc>")

		-- Toggle wrap
		map({ "n", "x" }, "<leader>ww", ":set wrap!<CR>", { desc = "Toggle line wrap", silent = true })

		-- Toggle cursor
		map({ "n", "x" }, "<leader>C", ":set cursorcolumn!<CR>:set cursorline!<CR>", { desc = "Toggle cursor display", silent = true })

		-- Terminal
		map("n", "<leader>t", ":terminal<CR>i", { desc = "Open a new terminal window", silent = true })
		map("t", "<C-[>", "<C-\\><C-n>")

		-- Window split
		map("n", "<leader>wh", ":vsplit<CR>", { silent = true })
		map("n", "<leader>wj", ":split<CR><C-w>j", { silent = true })
		map("n", "<leader>wk", ":split<CR>", { silent = true })
		map("n", "<leader>wl", ":vsplit<CR><C-w>l", { silent = true })

		-- Tabs
		map("n", "<leader><tab>n", ":tabnew<CR>", { desc = "New tab", silent = true })
		map("n", "<leader><tab>q", ":tabclose<CR>", { desc = "Close tab", silent = true })
		map("n", "<leader><tab>h", ":tabprev<CR>", { desc = "Go to previous tab", silent = true })
		map("n", "<leader><tab>l", ":tabnext<CR>", { desc = "Go to next tab", silent = true })

		-- Buffers
		map("n", "<A-,>", ":BufferPrevious<CR>", { silent = true })
		map("n", "<A-.>", ":BufferNext<CR>", { silent = true })
		map("n", "<A-<>", ":BufferMovePrevious<CR>", { silent = true })
		map("n", "<A->>", ":BufferMoveNext<CR>", { silent = true })
		map("n", "<A-q>", ":BufferClose<CR>", { desc = "Close current buffer", silent = true })
		map("n", "<A-Q>", ":BufferClose!<CR>", { desc = "Close current buffer forced", silent = true })
		map("n", "<leader>n", ":enew<CR>", { desc = "[n]ew buffer", silent = true })
	end,
}
