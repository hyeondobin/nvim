return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		keys = {
			{
				"<leader>gl",
				function()
					require("snacks").lazygit.open()
				end,
				desc = "Open lazygit",
			},
		},
		---@type snacks.Config
		opts = {
			indent = {},
			lazygit = {},
		},
	},
}
