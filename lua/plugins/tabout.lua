return {
	"abecodes/tabout.nvim",
	event = { "InsertCharPre" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		-- "L3MON4D3/LuaSnip",
	},
	config = function()
		require("tabout").setup({})
	end,
}
