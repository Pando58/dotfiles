local telescope = require("telescope")

telescope.setup({
	defaults = {
		layout_strategy = 'horizontal',
		layout_config = {
			prompt_position = "top",
		},
		sorting_strategy = "ascending",
		pickers = {
			find_files = {
				hidden = true,
			},
		},
		mappings = require("config.keys.telescope").keys_telescope(),
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
		undo = {
			side_by_side = true,
			layout_strategy = "vertical",
			layout_config = {
				preview_height = 0.8,
			},
		},
	},
})

pcall(telescope.load_extension, "fzf") -- Enable if installed
telescope.load_extension("undo")
