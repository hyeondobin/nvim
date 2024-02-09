return {
	"nvimtools/none-ls.nvim",
	lazy = false,
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				-- formatting
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier,

				-- linting
				null_ls.builtins.diagnostics.selene,
				null_ls.builtins.diagnostics.eslint_d,
			},
		})

		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
