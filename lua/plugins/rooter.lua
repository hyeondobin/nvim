return {
	"notjedi/nvim-rooter.lua",
	event = { "BufReadPost", "BufWritePost", "BufNewFile", "VeryLazy" },
	config = function()
		require("nvim-rooter").setup({})
	end,
}
