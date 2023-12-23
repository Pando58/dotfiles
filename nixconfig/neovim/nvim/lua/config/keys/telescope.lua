local telescope = require("telescope")
local telescope_builtin = require("telescope.builtin")
local actions_preview = require("actions-preview")

local function map(keys, action, opts)
	vim.keymap.set("n", keys, action, opts)
end

return {
	keys = function ()
		map("<leader>ss", telescope_builtin.builtin, { desc = "[s]earch built-in pickers" })
		map("<leader>sb", telescope_builtin.current_buffer_fuzzy_find, { desc = "[s]earch in current [b]uffer" })
		map("<leader>sB", telescope_builtin.buffers, { desc = "[s]earch [B]uffers" })
		map("<leader>sf", function () telescope_builtin.find_files({ hidden = true }) end, { desc = "[s]earch [f]iles in current directory" })
		map("<leader>sF", telescope_builtin.oldfiles, { desc = "[s]earch old [F]iles" })
		map("<leader>sh", telescope_builtin.help_tags, { desc = "[s]earch [h]elp" })
		map("<leader>sc", telescope_builtin.commands, { desc = "[s]earch [c]ommands" })
		map("<leader>sr", telescope_builtin.registers, { desc = "[s]earch [r]egisters" })
		map("<leader>sw", telescope_builtin.grep_string, { desc = "[s]earch current [w]ord" })
		map("<leader>sG", telescope_builtin.live_grep, { desc = "[s]earch with [G]rep" })
		map("<leader>sd", telescope_builtin.diagnostics, { desc = "[s]earch [d]iagnostics" })
		map("<leader>slsb", telescope_builtin.lsp_document_symbols, { desc = "[s]earch [l]sp [s]ymbols in the current [b]uffer" })
		map("<leader>slsw", telescope_builtin.lsp_workspace_symbols, { desc = "[s]earch [l]sp [s]ymbols in the current [w]orkspace" })
		map("<leader>st", telescope_builtin.treesitter, { desc = "[s]earch stuff from treesitter" })
		map("<leader>sgs", telescope_builtin.git_status, { desc = "[s]earch [g]it [s]tatus" })
		map("<leader>sgS", telescope_builtin.git_stash, { desc = "[s]earch [g]it [s]tash" })
		map("<leader>sgc", telescope_builtin.git_commits, { desc = "[s]earch [g]it [c]ommits" })
		map("<leader>sgb", telescope_builtin.git_branches, { desc = "[s]earch [g]it [b]ranches" })

		map("<leader>su", telescope.extensions.undo.undo, { desc = "[s]earch [u]ndo tree" })

		map("<leader>sa", actions_preview.code_actions, { desc = "[s]earch code [a]ctions" })
	end,
	keys_telescope = function ()
		return {
			i = {
				["<A-h>"] = "which_key",
				["<C-h>"] = "preview_scrolling_left",
				["<C-l>"] = "preview_scrolling_right",
				["<C-f>"] = false, -- Disable preview_scrolling_left
				["<C-k>"] = false, -- Disable preview_scrolling_right
			},
			n = {
				["<C-c>"] = "close",
			},
		}
	end,
}
