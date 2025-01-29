return {
	"Wansmer/treesj",
	keys = {
		{
			"<leader>tm",
			function()
				require("treesj").toggle()
			end,
			desc = "treesj Toggle",
		},
		{
			"<leader>tj",
			function()
				require("treesj").join()
			end,
			desc = "treesj Join",
		},
		{
			"<leader>ts",
			function()
				require("treesj").split()
			end,
			desc = "treesj Split",
		},
	},
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	opts = {},
}
