return {
	"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	event = { "BufReadPre" },
	opts = {},
	config = function()
		vim.diagnostic.config({ virtual_text = false })
		require("lsp_lines").setup()
	end,
}
