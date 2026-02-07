return function (params)
	vim.defer_fn(function () -- Defer Treesitter setup after first render to improve startup time of "nvim {filename}"
		require("nvim-treesitter.configs").setup({
			ensure_installed = params.using_nix and {} or {
				"lua",
				"javascript",
				"typescript",
				"tsx",
				"svelte",
				"json",
				"yaml",
				"html",
				"css",
				"scss",
				"rust",
				"toml",
				"nix",
				"gdscript",
				"godot_resource",
				"dockerfile",
				"c",
				"cpp",
				"python",
				"vim",
				"vimdoc",
				"bash",
				"qmljs",
			},
			auto_install = false,
			highlight = { enable = true },
			indent = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<c-space>",
					node_incremental = "<c-space>",
					scope_incremental = "<c-s>",
					node_decremental = "<M-space>",
				},
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_start = {
						["]f"] = "@function.outer",
						["]c"] = "@class.outer",
					},
					goto_next_end = {
						["]F"] = "@function.outer",
						["]C"] = "@class.outer",
					},
					goto_previous_start = {
						["[f"] = "@function.outer",
						["[c"] = "@class.outer",
					},
					goto_previous_end = {
						["[F"] = "@function.outer",
						["[c"] = "@class.outer",
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>a"] = "@parameter.inner",
					},
					swap_previous = {
						["<leader>A"] = "@parameter.inner",
					},
				},
			},
			autotag = { -- nvim-ts-autotag plugin
				enable = true,
			},
		})
	end, 0)
end
