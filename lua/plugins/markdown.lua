return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	ft = { "markdown" },
	keys = {
		{ "<leader>pms", "<cmd>MarkdownPreview<CR>", desc = "[P]review - [M]arkdown : [S]tart" },
		{ "<leader>pmc", "<cmd>MarkdownPreview<CR>", desc = "[P]review - [M]arkdown : [C]ancel" },
	},
	build = function()
		vim.fn["mkdp#util#install"]()
	end,
}
