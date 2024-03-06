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
					lsp_fallback = true,
				},
			})
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"joechrisellis/lsp-format-modifications.nvim",
		},
		event = { "BufReadPost", "BufWritePost", "BufNewFile", "VeryLazy" },
		config = function()
			local null_ls = require("null-ls")
			-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

			null_ls.setup({
				sources = {
					-- formatting
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.prettierd.with({
						env = {
							PRETTIERD_DEFAULT_CONFIG = vim.fn.stdpath("config") .. "/linter-config/.prettierrc.json",
						},
					}),
					null_ls.builtins.formatting.gdformat,
					null_ls.builtins.formatting.markdownlint,
					null_ls.builtins.formatting.shfmt,

					-- linting
					null_ls.builtins.diagnostics.selene,
					null_ls.builtins.diagnostics.gdlint,
					null_ls.builtins.diagnostics.markdownlint.with({}),
				},
				debug = true,
			})

			vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
		end,
	},
}
