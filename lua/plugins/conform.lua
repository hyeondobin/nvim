return {
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					javascript = { { "prettierd", "prettier" } },
					rust = { "rustfmt" },
					markdown = { " markdownlint" },
				},
				format_on_save = {
					timeout_ms = 500,
					async = false,
					lsp_format = "fallback",
				},
			})
		end,
	},
}
