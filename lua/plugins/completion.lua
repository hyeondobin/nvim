return {
	{
		"saghen/blink.cmp",
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
				["<Tab>"] = {},
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
						if cmp.snippet_active({ direction = -1 }) then
							return cmp.snippet_backward()
						end
					end,
				},
			},
			appearance = {
				use_nvim_cmp_as_default = true,
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
				enabled = true,
				window = { border = "rounded" },
			},
		},
		opts_extend = { "sources.default" },
	},
}
