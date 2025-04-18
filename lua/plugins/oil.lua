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
		keys = {
			{ "-", "<cmd>Oil --float<CR>", desc = "Open Oil" },
		},
		dependencies = {
			{
				"nvim-tree/nvim-web-devicons",
				"oil-vcs-status",
			},
		},
		lazy = false,
	},
	{
		"SirZenith/oil-vcs-status",
		enabled = true,
		dependencies = {
			"stevearc/oil.nvim",
		},
		opts = {},
		config = function()
			local status_const = require("oil-vcs-status.constant.status")
			local StatusType = status_const.StatusType

			---@type table<oil-vcs-status.StatusType, string>
			require("oil-vcs-status").setup({
				status_symbol = {
					[StatusType.Added] = "",
					[StatusType.Copied] = "󰆏",
					[StatusType.Deleted] = "",
					[StatusType.Ignored] = "",
					[StatusType.Modified] = "",
					[StatusType.Renamed] = "",
					[StatusType.TypeChanged] = "󰉺",
					[StatusType.Unmodified] = " ",
					[StatusType.Unmerged] = "",
					[StatusType.Untracked] = "",
					[StatusType.External] = "",

					[StatusType.UpstreamAdded] = "󰈞",
					[StatusType.UpstreamCopied] = "󰈢",
					[StatusType.UpstreamDeleted] = "",
					[StatusType.UpstreamIgnored] = " ",
					[StatusType.UpstreamModified] = "󰏫",
					[StatusType.UpstreamRenamed] = "",
					[StatusType.UpstreamTypeChanged] = "󱧶",
					[StatusType.UpstreamUnmodified] = " ",
					[StatusType.UpstreamUnmerged] = "",
					[StatusType.UpstreamUntracked] = " ",
					[StatusType.UpstreamExternal] = "",
				},
			})
		end,
	},
}
