return {
	"notjedi/nvim-rooter.lua",
	event = { "BufReadPost", "BufWritePost", "BufNewFile", "VeryLazy" },
	opts = {
		rooter_patterns = { ".git", ".hg", ".svn" },
		cd_scope = "global",
		manual = true,
		fallback_to_parent = true,
	},
	keys = {
		{
			"<leader>cd",
			function()
				require("nvim-rooter").rooter_default()
			end,
			desc = "Change root directory",
		},
	},
}
