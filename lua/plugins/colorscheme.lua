local flavor = "macchiato"
return {
	{
		"catppuccin/nvim",
		enabled = true,
		name = "catppuccin",
		priority = 1000,
		lazy = false,
		config = function()
			local color = require("catppuccin.palettes").get_palette(flavor)
			require("catppuccin").setup({
				flavour = flavor,
				background = {
					light = "latte",
					dark = "mocha",
				},
				-- transparent_background = not vim.g.neovide,
				transparent_background = false,
				term_colors = true,
				integrations = {
					aerial = true,
					alpha = true,
					blink_cmp = true,
					-- cmp = true,
					dashboard = true,
					flash = true,
					gitsigns = true,
					harpoon = true,
					headlines = true,
					illuminate = true,
					indent_blankline = {
						enabled = true,
						scope_color = "sapphire",
						colored_indent_levels = true,
					},
					mason = true,
					markdown = true,
					mini = true,
					native_lsp = {
						enabled = true,
						virtual_text = {
							errors = {},
							hints = {},
							warnings = {},
							information = {},
						},
						underlines = {
							errors = { "undercurl" },
							hints = { "undercurl" },
							warnings = { "undercurl" },
							information = { "undercurl" },
						},
					},
					neotest = true,
					notify = true,
					noice = true,
					semantic_tokens = true,
					snacks = true,
					symbols_outline = true,
					telescope = true,
					treesitter = true,
					treesitter_context = true,
					which_key = true,
				},
				custom_highlights = {
					BlinkCmpMenuBorder = { fg = color.lavender },
					BlinkCmpDocBorder = { fg = color.lavender },
				},
			})

			vim.cmd.colorscheme("catppuccin")

			-- for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
			-- 	vim.api.nvim_set_hl(0, group, {})
			-- end
		end,
	},
}
