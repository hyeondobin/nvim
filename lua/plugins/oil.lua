return {
	{
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {
			columns = {
				"icon",
				"mtime",
			},
			skip_confirm_for_simple_edits = true,
			watch_for_changes = true,
			keymaps = {
				["<Esc>"] = "actions.close",
			},
			view_options = {
				show_hidden = true,
				is_always_hidden = function(name, _)
					if name == ".." then
						return true
					else
						return false
					end
				end,
			},
			win_options = {
				signcolumn = "yes:2",
			},
		},
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
		},
		event = { "BufReadPre" },
	},
	{
		"SirZenith/oil-vcs-status",
		dependencies = {
			"stevearc/oil.nvim",
		},
		config = true,
	},
}
