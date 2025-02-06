return {
	{
		"saghen/blink.cmp",
		enabled = true,
		dependencies = {
			"rafamadriz/friendly-snippets",
			"saghen/blink.compat",
		},
		event = "InsertEnter",
		version = "*",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = {
				preset = "default",
				["<c-Tab>"] = { "accept", "fallback" },
				["<C-j>"] = {
					function(cmp)
						if not cmp.snippet_active() then
							return cmp.accept()
						end
					end,
					"snippet_forward",
				},
				["<C-k>"] = {
					function(cmp)
						if not cmp.snippet_active() then
							return cmp.show_signature()
						end
					end,
					"snippet_backward",
				},
				["<C-l>"] = {
					"accept",
					"fallback",
				},
			},
			appearance = {
				use_nvim_cmp_as_default = false,
				nerd_font_variant = "mono",
			},
			completion = {
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 50,
					window = { border = "rounded" },
				},
				ghost_text = {
					enabled = false --[[ ghost is full trans so cannot recognize whether it's 
                    ghost so set to false]],
				},
				list = {
					selection = {
						preselect = true,
					},
				},
				menu = {
					border = "rounded",
					draw = {
						columns = {
							{ "kind_icon", "kind", gap = 1 },
							{ "label", "label_description", gap = 1 },
							{ "source_name" },
						},
					},
				},
			},
			signature = {
				enabled = false,
				window = { border = "rounded" },
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
		},
		opts_extend = { "sources.default" },
	},
}
