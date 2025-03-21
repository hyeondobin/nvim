return {
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			{
				"nvim-cmp",
				dependencies = {
					"saadparwaiz1/cmp_luasnip",
				},
			},
			{
				"rafamadriz/friendly-snippets",
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
				end,
			},
		},
		opts = {
			history = true,
			delete_check_events = "TextChanged",
		},
		keys = {},
	},
	{
		"hrsh7th/nvim-cmp",
		enabled = true,
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"petertriho/cmp-git",
			-- snippet
			"saadparwaiz1/cmp_luasnip",
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",

			-- icon
			"onsails/lspkind.nvim",
		},
		opts = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")

			require("luasnip.loaders.from_vscode").lazy_load()

			---@type cmp.ConfigSchema
			return {
				view = {
					docs = { auto_open = true },
				},
				preselect = "item",
				completion = {
					completeopt = "menu,menuone,fuzzy,popup",
					keyword_length = 0,
					autocomplete = { "InsertEnter", "TextChanged" },
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					-- completion = {
					-- 	winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
					-- 	col_offset = -3,
					-- 	side_padding = 0,
					-- },
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = {
					["<C-n>"] = cmp.mapping(function()
						if cmp.visible() then
							cmp.select_next_item()
						else
							cmp.complete()
						end
					end),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-u>"] = cmp.mapping.scroll_docs(4),
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-e>"] = cmp.mapping.abort(),
					["<C-h>"] = cmp.mapping(function()
						luasnip.jump(-1)
					end),
					["<C-l>"] = cmp.mapping(function()
						luasnip.jump(1)
					end),
					["<CR>"] = cmp.mapping(function(fallback)
						fallback()
					end),
					["<C-y>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace })
						else
							fallback()
						end
					end),
					["<C-Space>"] = cmp.mapping(cmp.mapping.complete()),
				},
				sources = cmp.config.sources({
					{ name = "path" },
					{ name = "nvim_lua" },
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "nvim_lsp_signature_help" },
				}, {
					{ name = "buffer", keyword_length = 3 },
				}),

				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(entry, vim_item)
						local kind = lspkind.cmp_format({
							mode = "symbol_text",
							maxwidth = 50,
						})(entry, vim_item)
						local strings = vim.split(kind.kind, "%s", { trimempty = true })
						kind.kind = " " .. (strings[1] or "") .. " "
						kind.menu = "    (" .. (strings[2] or "") .. ")"

						return kind
					end,
					-- format = lspkind.cmp_format({
					-- 	mode = "symbol_text",
					-- 	menu = {
					-- 		buffer = "[Buffer]",
					-- 		nvim_lsp = "[LSP]",
					-- 		luasnip = "[LuaSnip]",
					-- 		nvim_lua = "[Lua]",
					-- 		latex_symbols = "[Latex]",
					-- 	},
					-- }),
				},
			}
		end,
		config = function(_, opts)
			for _, source in ipairs(opts.sources) do
				source.group_index = source.group_index or 1
			end

			require("cmp").setup(opts)
			local cmp = require("cmp")
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")

			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

			cmp.setup.filetype("gitcommit", {
				sources = cmp.config.sources({
					{ name = "git" },
				}, {
					{ name = "buffer" },
				}),
			})
			require("cmp_git").setup({})

			cmp.setup.cmdline({ "/", "?" }, {
				view = {
					-- entries = { name = "wildmenu", separator = " | " },
				},
				mapping = {
					["<C-y>"] = cmp.mapping(function()
						cmp.confirm({ select = true })
					end, { "i", "c" }),
					["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
					["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
				},
				sources = {
					{ name = "buffer" },
				},
			})

			cmp.setup.cmdline(":", {
				mapping = {
					["<C-y>"] = cmp.mapping(function()
						cmp.confirm({ select = true })
					end, { "i", "c" }),
					["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
					["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
				},
				sources = cmp.config.sources({
					{ name = "cmdline" },
					{ name = "path" },
				}),
			})
		end,
	},
}
