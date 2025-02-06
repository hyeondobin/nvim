return {
	"notjedi/nvim-rooter.lua",
	event = { "BufReadPost", "BufWritePost", "BufNewFile", "VeryLazy" },
	opts = {
		rooter_patterns = { ".git", ".hg", ".svn" },
		cd_scope = "global",
		manual = true,
	},
	keys = {
		{
			"<leader>cd",
			function()
				require("nvim-rooter").rooter_toggle()
			end,
			desc = "Change root directory",
		},
	},
}
