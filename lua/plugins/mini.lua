return {
	{
		"echasnovski/mini.files",
		version = false,
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("mini.files").setup({
				mappings = {},
				windows = {
					preview = true,
					width_preview = 100,
				},
			})
		end,
	},
	{
		"echasnovski/mini.pairs",
		version = false,
		event = { "InsertEnter" },
		config = true,
	},
	{
		"echasnovski/mini.surround",
		version = false,
		config = true,
		event = { "InsertEnter" },
	},
	{
		"echasnovski/mini.animate",
		version = false,
		config = function()
			require("mini.animate").setup({
				cursor = {
					enable = true,
				},
				scroll = {
					enable = true,
				},
				open = {
					enable = true,
				},
				close = {
					enable = true,
				},
			})
		end,
	},
}
