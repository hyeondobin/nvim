return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"joechrisellis/lsp-format-modifications.nvim",
	},
	lazy = false,
	config = function()
		local null_ls = require("null-ls")
		-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

		null_ls.setup({
			sources = {
				-- formatting
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.formatting.gdformat,
				null_ls.builtins.formatting.markdownlint,

				-- linting
				null_ls.builtins.diagnostics.selene,
				null_ls.builtins.diagnostics.eslint_d,
				null_ls.builtins.diagnostics.gdlint,
				null_ls.builtins.diagnostics.markdownlint,
			},

			on_attach = function(client, bufnr)
				-- local augroup_id =
				-- 	vim.api.nvim_create_augroup("FormatModificationsDocumentFormattingGroup", { clear = false })
				-- vim.api.nvim_clear_autocmds({ group = augroup_id, buffer = bufnr })
				-- vim.api.nvim_create_autocmd({ "BufWritePre" }, {
				-- 	group = augroup_id,
				-- 	buffer = bufnr,
				-- 	callback = function()
				-- 		local lsp_format_modifications = require("lsp-format-modifications")
				-- 		lsp_format_modifications.format_modifications(client, bufnr)
				-- 	end,
				-- })

				-- if client.supports_method("textDocument/formatting") then
				--     vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				--     vim.api.nvim_create_autocmd("BufWritePre", {
				--         group = augroup,
				--         buffer = bufnr,
				--         callback = function()
				--             vim.lsp.buf.format()
				--         end,
				--     })
				-- end
			end,
		})

		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
