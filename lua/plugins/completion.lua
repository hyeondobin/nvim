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
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
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

			local function has_words_before()
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			require("luasnip.loaders.from_vscode").lazy_load()

			return {
				preselect = "item",
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = {
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-u>"] = cmp.mapping.scroll_docs(4),
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-Space>"] = cmp.mapping.complete(),
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
					-- ["<Tab>"] = cmp.mapping(function(fallback)
					-- 	if cmp.visible() then
					-- 		cmp.confirm({ select = true })
					-- 	elseif has_words_before() then
					-- 		cmp.complete()
					-- 		if #cmp.get_entries() == 1 then
					-- 			cmp.confirm({ select = true })
					-- 		end
					-- 	else
					-- 		fallback()
					-- 	end
					-- end),
					["<C-y>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.confirm({ select = true })
						else
							fallback()
						end
					end),
				},
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "nvim_lsp_signature_help" },
					{ name = "nvim_lua" },
					{ name = "luasnip" },
					{ name = "path" },
				}, {
					{ name = "buffer", keyword_length = 3 },
				}),

				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol_text",
						menu = {
							buffer = "[Buffer]",
							nvim_lsp = "[LSP]",
							luasnip = "[LuaSnip]",
							nvim_lua = "[Lua]",
							latex_symbols = "[Latex]",
						},
					}),
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
					{ name = "buffer" },
				}),
			})

			cmp.setup.cmdline({ "/", "?" }, {
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
