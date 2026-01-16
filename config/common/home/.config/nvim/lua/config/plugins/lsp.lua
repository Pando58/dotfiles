local servers = {
	lua_ls = {
		config = {
			Lua = {
				workspace = { checkThirdParty = false },
				telemetry = { enable = false },
			},
		},
		load = function ()
			require("lazydev").setup()
		end
	},
	ts_ls = {
		-- Ignored, doesn't work
		-- javascript = { format = { enable = false, }, },
		-- typescript = { format = { enable = false, }, },
	},
	svelte = {
		config = {
			svelte = {
				plugin = {
					svelte = {
						format = {
							enable = false,
						},
					},
				},
			},
		},
	},
	eslint = {
		format = {
			enable = true,
		},
	},
	jsonls = {},
	html = {},
	cssls = {},
	tailwindcss = {},
	emmet_ls = {},
	rust_analyzer = {
		config = {
			diagnostics = {
				enable = true,
			},
		},
	},
	clangd = {},
	gdscript = {},
	nixd = {},
}

local on_attach = function (_client, buffer_number)
	require("config.keys.lsp").keys_lsp(buffer_number)
	vim.lsp.inlay_hint.enable()
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

return {
	setup_mason = function ()
		require("mason").setup()

		require("mason-lspconfig").setup({
			ensure_installed = vim.tbl_keys(servers),
		})

		require("mason-lspconfig").setup_handlers({
			function (server_name)
				require("lspconfig")[server_name].setup({
					on_attach = on_attach,
					capabilities = capabilities,
					server_config = servers[server_name].config or {},
				})

				local load = servers[server_name].load

				if load then
					load()
				end
			end,
		})
	end,
	setup_nix = function ()
		for server_name, server_config in pairs(servers) do
			vim.lsp.config(server_name, {
				on_attach = on_attach,
				capabilities = capabilities,
				server_config = server_config.config or {},
			})

			vim.lsp.enable(server_name)

			local load = server_config.load

			if load then
				load()
			end
		end
	end,
}
