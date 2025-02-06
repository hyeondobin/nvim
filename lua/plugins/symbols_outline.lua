return {
	{
		"simrat39/symbols-outline.nvim",
		cmd = { "SymbolsOutline", "SymbolsOutlineOpen", "SymbolsOutlineClose" },
		config = true,
		keys = {
			{
				"<leader>co",
				function()
					require("symbols-outline").toggle_outline()
				end,
			},
		},
	},
}
