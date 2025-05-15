require("lazydev").setup({
	library = {
		path = "${3rd}/luv/library",
		words = { "vim%.uv" },
	},
})

require("luasnip.loaders.from_vscode").lazy_load()

require("blink.cmp").setup({
	keymap = {
		preset = "default",

		["<C-space>"] = {},
		["<C-e>"] = { "show_and_insert", "hide" },
	},

	appearance = {
		nerd_font_variant = "mono"
	},

	signature = {
		enabled = true,
		window = {
			show_documentation = true,
		},
	},

	completion = {
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 0,
		},

		menu = {
			draw = {
				columns = {
					{
						"label",
						"label_description",
						gap = 1,
					},
					{ "kind_icon" },
					{ "kind" },
					{ "source_name" },
				},
			},
		},

		ghost_text = {
			enabled = true,
		},
	},

	sources = {
		default = { "lsp", "path", "snippets", "buffer" },

		providers = {
			lazydev = {
				name = "LazyDev",
				module = "lazydev.integrations.blink",
				-- make lazydev completions top priority (see `:h blink.cmp`)
				score_offset = 100,
			},
		},

		per_filetype = {
			lua = {
				inherit_defaults = true,
				"lazydev"
			}
		},
	},

	snippets = {
		preset = "luasnip",
	},

	fuzzy = { implementation = "prefer_rust_with_warning" },
})
