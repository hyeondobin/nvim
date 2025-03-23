-- ref: https://cmp.saghen.dev/configuration/general.html
return {
	{
		"saghen/blink.cmp",
		enabled = vim.g.completor == "blink",
		dependencies = {
			"rafamadriz/friendly-snippets",
			"saghen/blink.compat",
		},
		lazy = false,
		event = "InsertEnter",
		version = "*",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			-- cmdline = {
			-- 	enabled = true,
			-- 	completion = {
			-- 		list = { selection = { preselect = true } },
			-- 		menu = {
			-- 			auto_show = true,
			-- 			-- draw = {
			-- 			-- 	columns = {
			-- 			-- 		{ "kind_icon", "kind", gap = 1 },
			-- 			-- 		{ "label", "label_description", gap = 1 },
			-- 			-- 		{ "source_name" },
			-- 			-- 	},
			-- 			-- },
			-- 		},
			-- 	},
			-- },
			keymap = {
				preset = "default",
				["<C-Tab>"] = { "accept", "fallback" },
				["<c-j>"] = {
					function(cmp)
						if not cmp.snippet_active() then
							return cmp.accept()
						end
					end,
					"snippet_forward",
				},
				["<c-k>"] = {
					function(cmp)
						if not cmp.snippet_active() then
							return cmp.show_signature()
						end
					end,
					"snippet_backward",
				},
				-- ["<C-y>"] = {
				-- 	"accept",
				-- 	"fallback",
				-- },
				["<C-,>"] = {
					"show_signature",
					"fallback",
				},
			},
			appearance = {
				use_nvim_cmp_as_default = false,
				nerd_font_variant = "mono",
			},
			completion = {
				trigger = {
					show_on_trigger_character = true,
				},
				keyword = { range = "full" },
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 100,
					window = { border = vim.g.borderStyle },
				},
				ghost_text = {
					enabled = true --[[ ghost is full trans so cannot recognize whether it's
                    ghost so set to false]],
				},
				list = {
					selection = {
						preselect = true,
					},
				},
				menu = {
					border = "rounded",
					scrollbar = false,
					draw = {
						align_to = "cursor",
						columns = {
							{ "kind_icon", "kind", gap = 1 },
							{ "label", "label_description", gap = 1 },
							{ "source_name" },
						},
					},
				},
			},
			signature = {
				enabled = true,
				window = { border = vim.g.borderStyle },
			},
			sources = {
				min_keyword_length = function()
					return vim.bo.filetype == "markdown" and 2 or 0
				end,
				default = {
					"lazydev",
					"lsp",
					"path",
					"snippets",
					"buffer",
					"markdown",
				},
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
					buffer = {},
					markdown = {
						name = "RenderMarkdown",
						module = "render-markdown.integ.blink",
						fallbacks = { "lsp" },
					},
				},
			},
			snippets = {
				preset = "default",
			},
		},
		-- opts_extend = { "sources.default" },
	},
}
