if vim.uv.os_uname().sysname == "Windows_NT" then
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
				-- "saghen/blink.cmp",
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
					vim.keymap.set("n", "K", function () vim.lsp.buf.hover() end, opts)
					vim.keymap.set("n", "gd", function () Snacks.picker.lsp_definitions() end, {buffer = event.buf, desc = "Get Definition"})
					vim.keymap.set("n", "gD", function () vim.lsp.buf.declaration() end, {buffer = event.buf, desc = "Get Declaration"})
					vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, {buffer = event.buf, desc = "Get implementations"})
					vim.keymap.set("n", "go", function() vim.lsp.buf.type_definition() end, {buffer = event.buf, desc = "Get type definition"})
					vim.keymap.set("n", "gr", function () Snacks.picker.lsp_references() end, {buffer = event.buf, desc = "Get References"})
					vim.keymap.set("n", "gh", function() vim.lsp.buf.signature_help() end, {buffer = event.buf, desc = "Get signature Help"})
                    vim.keymap.set("n", "<leader>cr", function() vim.lsp.buf.rename() end, { buffer = event.buf, desc = "LSP Rename" })
					vim.keymap.set({ "n", "x" }, "<leader>cf", function() vim.lsp.buf.format({async = true}) end, {buffer = event.buf, desc = "LSP Format"})
					vim.keymap.set( "n", "<leader>ca", function() vim.lsp.buf.code_action() end, { buffer = event.buf, desc = "LSP Code Action" })
						-- stylua: ignore end
					end,
				})

				-- capabilities
				local lsp_capabilities
				if vim.g.completor == "cmp" then
					lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
				elseif vim.g.completor == "blink" then
					lsp_capabilities = require("blink-cmp").get_lsp_capabilities()
				end

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
						"ts_ls",
					},
					automatic_installation = true,
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
		{
			"seblj/roslyn.nvim",
			ft = "cs",
			opts = {},
		},
	}
else
	return {
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		opts = {},
		dependencies = {
			-- "saghen/blink.cmp",
			"hrsh7th/cmp-nvim-lsp",
			"folke/neoconf.nvim",
			"nvim-lua/lsp-status.nvim",
		},
		config = function()
			require("neoconf").setup({})
			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(event)
					local opts = { buffer = event.buf }

					vim.keymap.set("n", "K", function()
						vim.lsp.buf.hover()
					end, opts)
					vim.keymap.set("n", "gd", function()
						Snacks.picker.lsp_definitions()
					end, { buffer = event.buf, desc = "Get Definition" })
					vim.keymap.set("n", "gD", function()
						vim.lsp.buf.declaration()
					end, { buffer = event.buf, desc = "Get Declaration" })
					vim.keymap.set("n", "gi", function()
						vim.lsp.buf.implementation()
					end, { buffer = event.buf, desc = "Get implementations" })
					vim.keymap.set("n", "go", function()
						vim.lsp.buf.type_definition()
					end, { buffer = event.buf, desc = "Get type definition" })
					vim.keymap.set("n", "gr", function()
						Snacks.picker.lsp_references()
					end, { buffer = event.buf, desc = "Get References" })
					vim.keymap.set("n", "gh", function()
						vim.lsp.buf.signature_help()
					end, { buffer = event.buf, desc = "Get signature Help" })
					vim.keymap.set("n", "<leader>cr", function()
						vim.lsp.buf.rename()
					end, { buffer = event.buf, desc = "LSP Rename" })
					vim.keymap.set({ "n", "x" }, "<leader>cf", function()
						vim.lsp.buf.format({ async = true })
					end, { buffer = event.buf, desc = "LSP Format" })
					vim.keymap.set("n", "<leader>ca", function()
						vim.lsp.buf.code_action()
					end, { buffer = event.buf, desc = "LSP Code Action" })
				end,
			})

			local lsp = require("lspconfig")
			-- capabilities
			local lsp_capabilities
			if vim.g.completor == "cmp" then
				lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
			elseif vim.g.completor == "blink" then
				lsp_capabilities = require("blink-cmp").get_lsp_capabilities()
			end
			-- lsp_capabilities.textDocument.foldingRange = {
			-- 	dynamicRegistration = false,
			-- 	lineFoldingOnly = true,
			-- }

			vim.diagnostic.config({
				virtual_lines = true,
				signs = true,
				underline = true,
				update_in_insert = true,
				severity_sort = false,
			})

			local hostname = vim.fn.hostname() -- get hostname
			-- local on_attach = function(bufnr)
			-- 	vim.api.nvim_create_autocmd("CursorHold", {
			-- 		buffer = bufnr,
			-- 		callback = function()
			-- 			local opts = {
			-- 				focusable = false,
			-- 				close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
			-- 				border = "rounded",
			-- 				source = "always",
			-- 				prefix = " ",
			-- 				scope = "line",
			-- 			}
			-- 			vim.diagnostic.open_float(nil, opts)
			-- 		end,
			-- 	})
			-- end
			lsp.nixd.setup({
				cmd = { "nixd" },
				-- on_attach = on_attach(),
				capabilities = lsp_capabilities,
				settings = {
					nixd = {
						nixpkgs = {
							expr = "import <nixpkgs> { }",
							-- expr = "import (builtins.getFlake '/etc/nixos').inputs.nixpkgs { }",
						},
						formatting = {
							command = { "alejandra" },
						},
						options = {
							nixos = {
								expr = '(builtins.getFlake "/etc/nixos").nixosConfigurations.'
									.. hostname
									.. ".options",
							},
							home_manager = {
								expr = '(builtins.getFlake "/etc/nixos").homeConfigurations.hyeondobin.options',
							},
						},
						diagnostics = {
							suppress = {
								"sema-extra-with",
							},
						},
					},
				},
			})
			-- installed from nixpkgs
			lsp.lua_ls.setup({
				-- on_attach = my_attach,
				on_init = function(client)
					local path = client.workspace_folders[1].name
					if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
						return
					end

					client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
						runtime = {
							-- Tell the language server which version of Lua you're using
							-- (most likely LuaJIT in the case of Neovim)
							version = "LuaJIT",
						},
						-- Make the server aware of Neovim runtime files
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME,
								-- Depending on the usage, you might want to add additional paths here.
								-- "${3rd}/luv/library"
								-- "${3rd}/busted/library",
							},
							-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
							-- library = vim.api.nvim_get_runtime_file("", true)
						},
					})
				end,
				-- capabilities = my_lsp_capabilities,
				settings = {
					Lua = {},
				},
			})
			lsp.taplo.setup({
				root_dir = require("lspconfig.util").root_pattern("*.toml", ".git"),
			})
			-- hyprlang lsp
			lsp.hyprls.setup({})

			-- fish lsp
			lsp.fish_lsp.setup({})
		end,
	}
end
