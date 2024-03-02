return {
	{
		"stevearc/dressing.nvim",
		event = { "BufReadPost", "BufWritePost", "BufNewFile", "VeryLazy" },
		config = function()
			require("dressing").setup({})
		end,
	},
}
