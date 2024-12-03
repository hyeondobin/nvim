return {
	"notjedi/nvim-rooter.lua",
	event = { "BufReadPost", "BufWritePost", "BufNewFile", "VeryLazy" },
	opts = {
		rooter_patterns = { ".git", ".hg", ".svn" },
		cd_scope = "global",
	},
}
