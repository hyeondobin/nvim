return {
	-- "iamcco/markdown-preview.nvim",
	-- cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	-- ft = { "markdown" },
	-- keys = {
	-- 	{ "<leader>pms", "<cmd>MarkdownPreview<CR>", desc = "[P]review - [M]arkdown : [S]tart" },
	-- 	{ "<leader>pmc", "<cmd>MarkdownPreview<CR>", desc = "[P]review - [M]arkdown : [C]ancel" },
	-- },
	-- build = function()
	-- 	vim.fn["mkdp#util#install"]()
	-- end,
	{
		"MeanderingProgrammer/render-markdown.nvim",
		enabled = true,
		ft = { "markdown" },
		cmd = { "RenderMarkdown" },
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {
			heading = {
				enabled = true,
			},
		},
		keys = {
			{
				"<leader>pmt",
				function()
					require("render-markdown").toggle()
				end,
				desc = "Render Markdown Toggle",
			},
			{
				"<leader>pmy",
				function()
					require("render-markdown").enable()
				end,
				desc = "Render Markdown Enable",
			},
			{
				"<leader>pmn",
				function()
					require("render-markdown").disable()
				end,
				desc = "Render Markdown Disable",
			},
		},
	},
}
