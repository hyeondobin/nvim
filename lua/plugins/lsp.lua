return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup({
                ensuere_installed = {
                    "selene"
                },
            })
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
        opts = {
            automatic_installation = true,
        },
	},
	{
		"neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        event = { "BufReadPre", "BufNewFile" },
		config = function()
            -- variables
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- lua_ls config
            lspconfig.lua_ls.setup ({
                capabilities = capabilities,
                settings = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT',
                        },
                        diagnostics = {
                            globals = {
                                'vim',
                            },
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("",true),
                        },
                        telemetry = {
                            enable = false,
                        },
                    },
                },
            })
            lspconfig.tsserver.setup({
                capabilities = capabilities,
            })

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
			vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
