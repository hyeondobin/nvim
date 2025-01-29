return {
	{
		"saghen/blink.cmp",
		dependencies = "rafamadriz/friendly-snippets",
		version = "*",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = { preset = "default" },
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},
			completion = {
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 100,
					window = { border = "rounded" },
				},
				ghost_text = { enabled = true },
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
						},
					},
				},
			},
			signature = { window = { border = "rounded" } },
		},
		opts_extend = { "sources.default" },
	},
}
