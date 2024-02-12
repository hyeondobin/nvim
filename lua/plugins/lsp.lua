return {
	{
		"williamboman/mason.nvim",
	},
	{
		"williamboman/mason-lspconfig.nvim",
	},
	{
		"VonHeikemen/lsp-zero.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		lazy = false,
		branch = "v3.x",
		config = function()
			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_lspconfig()

			lsp_zero.on_attach(function(_, bufnr)
				lsp_zero.default_keymaps({ buffer = bufnr })
				vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, {})
			end)

			lsp_zero.configure("gdscript", {
				force_setup = true,
				single_file_support = false,
				cmd = { "ncat", "127.0.0.1", "6005" },
				root_dir = require("lspconfig.util").root_pattern("project.godot", ".git"),
				filetypes = { "gd", "gdscript", "gdscript3" },
			})

			require("mason").setup({})
			require("mason-lspconfig").setup({
				ensure_installed = {},
				handlers = {
					lsp_zero.default_setup,

					lua_ls = function()
						require("lspconfig").lua_ls.setup({
							settings = {
								Lua = {
									runtime = {
										version = "LuaJIT",
									},
									diagnostics = {
										globals = {
											"vim",
										},
									},
									workspace = {
										library = vim.api.nvim_get_runtime_file("", true),
									},
									telemetry = {
										enable = false,
									},
								},
							},
						})
					end,
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		event = { "BufReadPre", "BufNewFile" },
	},
}
