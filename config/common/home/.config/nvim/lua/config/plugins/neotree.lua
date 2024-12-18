require("neo-tree").setup({
	close_if_last_window = true,
	popup_border_style = "rounded",
	filesystem = {
		filtered_items = {
			visible = true,
			hide_dotfiles = false,
			hide_gitignored = true,
		},
	},
})
