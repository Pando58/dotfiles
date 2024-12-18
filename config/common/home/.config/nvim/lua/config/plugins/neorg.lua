require("neorg").setup({
	load = {
		["core.defaults"] = {},
		["core.completion"] = {
			config = {
				engine = "nvim-cmp",
			},
		},
		["core.concealer"] = {},
	},
})
