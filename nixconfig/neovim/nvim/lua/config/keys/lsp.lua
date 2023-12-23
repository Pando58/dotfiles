local telescope_builtin = require("telescope.builtin")

local function map(keys, func, bufnr, desc)
if desc then
		desc = "LSP: " .. desc
	end

	vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
end

return {
	keys_lsp = function (buffer_number)
		map("<leader>lr", vim.lsp.buf.rename, buffer_number, "[r]ename")
		map("<leader>la", vim.lsp.buf.code_action, buffer_number, "Code [a]ction")
		map("<leader>ld", vim.lsp.buf.definition, buffer_number, "Go to [d]efinition")
		map("<leader>lt", vim.lsp.buf.type_definition, buffer_number, "Go to [t]ype definition")
		map("<leader>li", vim.lsp.buf.implementation, buffer_number, "Goto [i]mplementation")
		map("<leader>lk", vim.lsp.buf.hover, buffer_number, "Hover Documentation")
		map("<leader>lK", vim.lsp.buf.signature_help, buffer_number, "Signature Documentation")

		map("<leader>lr", telescope_builtin.lsp_references, buffer_number, "Go to [r]eferences")
		map("<leader>ls", telescope_builtin.lsp_document_symbols, buffer_number, "Document [s]ymbols")
		map("<leader>lS", telescope_builtin.lsp_dynamic_workspace_symbols, buffer_number, "Workspace [S]ymbols")

		vim.keymap.set("n", "<leader>d,", vim.diagnostic.goto_prev, { desc = "Go to previous [d]iagnostic message" })
		vim.keymap.set("n", "<leader>d.", vim.diagnostic.goto_next, { desc = "Go to next [d]iagnostic message" })
		vim.keymap.set("n", "<leader>dm", vim.diagnostic.open_float, { desc = "Open floating [d]iagnostic [m]essage" })
		vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Open [d]iagnostics [l]ist" })

		-- Format current buffer with LSP
		vim.api.nvim_buf_create_user_command(buffer_number, "F", function ()
			for _, c in pairs(vim.lsp.get_active_clients()) do
				if c.name == "eslint" then
					vim.cmd("EslintFixAll")
					break
				end
			end

			vim.lsp.buf.format({ filter = function (client) return client.name ~= "tsserver" end })
		end, {})

		-- Format and save current buffer
		vim.api.nvim_buf_create_user_command(buffer_number, "W", function ()
			vim.cmd("F")
			vim.cmd.write()
		end, {})

		-- Format, save and quit all
		vim.api.nvim_buf_create_user_command(buffer_number, "WQ", function ()
			vim.cmd("F")
			vim.cmd.write()
			vim.cmd.quitall()
		end, {})
	end,
}
