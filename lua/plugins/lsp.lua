return {
	{
		"williamboman/mason.nvim",
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		dependencies = "WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	{ "williamboman/mason-lspconfig.nvim" },
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		opts = {},
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"folke/neoconf.nvim",
		},
		config = function()
			require("neoconf").setup({})

			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(event)
					local opts = { buffer = event.buf }

                    -- stylua: ignore start
					vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
					vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", opts)
					vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
					vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
					vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
					vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", opts)
					vim.keymap.set("n", "gh", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
                    vim.keymap.set("n", "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<cr>", { buffer = event.buf, desc = "LSP Rename" })
					vim.keymap.set({ "n", "x" }, "<leader>cf", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", {buffer = event.buf, desc = "LSP Format"})
					vim.keymap.set( "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", { buffer = event.buf, desc = "LSP Code Action" })
					-- stylua: ignore end
				end,
			})

			local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

			local default_setup = function(server)
				require("lspconfig")[server].setup({
					capabilities = lsp_capabilities,
				})
			end
			-- local port = os.getenv("GDScript_Port") or "6005"
			-- if vim.uv.os_uname().sysname == "Windows_NT" then
			-- 	require"lspconfig".gdscript.setup({
			-- 		cmd = { "ncat", "localhost", port },
			-- 	})
			-- else
			-- 	require("lspconfig").gdscript.setup({})
			-- end

			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
			local mason_tool_installer = require("mason-tool-installer")
			mason_tool_installer.setup({
				ensure_installed = {
					"stylua",
					"selene",
					"prettierd",
					"gdtoolkit",
					"markdownlint",
					"shfmt",
					"shellcheck",
				},
			})
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"rust_analyzer",
					"marksman",
					"bashls",
					"powershell_es",
					"eslint",
					"taplo",
				},
				automatic_installaiton = true,
				handlers = {
					default_setup,
					["rust_analyzer"] = function() end,
				},
			})

			require("lspconfig").taplo.setup({
				root_dir = require("lspconfig.util").root_pattern("*.toml", ".git"),
			})
		end,
	},
}
