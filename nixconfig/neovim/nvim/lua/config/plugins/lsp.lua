local servers = {
	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
	tsserver = {
		-- Ignored, doesn't work
		-- javascript = { format = { enable = false, }, },
		-- typescript = { format = { enable = false, }, },
	},
	svelte = {
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
	eslint = {
		-- Doesn't work, :EslintFixAll is needed instead
		-- eslint = {
		-- 	format = {
		-- 		enable = true,
		-- 	},
		-- },
	},
	jsonls = {},
	html = {},
	cssls = {},
	tailwindcss = {},
	emmet_ls = {},
	rust_analyzer = {},
	gdscript = {},
}

local on_attach = function (_client, buffer_number)
	require("config.keys.lsp").keys_lsp(buffer_number)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

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
					settings = servers[server_name],
				})
			end,
			lua_ls = function ()
				require("neodev").setup()

				require("lspconfig").lua_ls.setup({
					on_attach = on_attach,
					capabilities = capabilities,
					settings = servers.lua_ls,
				})
			end,
		})
	end,
	setup_nix = function ()
		for server_name, settings in pairs(servers) do
			if (server_name == "lua_ls") then
				require("neodev").setup()
			end

			require("lspconfig")[server_name].setup({
				on_attach = on_attach,
				capabilities = capabilities,
				settings = settings,
			})
		end

		require("lspconfig").nixd.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {},
		})
	end,
}
