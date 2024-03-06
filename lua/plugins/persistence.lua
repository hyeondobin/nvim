return {
	"folke/persistence.nvim",
	event = "BufReadPre",
	opts = { options = vim.opt.sessionoptions:get() },
	keys = {
		{
			"<leader>rs",
			function()
				require("persistence").load()
			end,
			desc = "[R]estore [S]ession",
		},
	},
}
