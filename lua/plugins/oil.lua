return {
	{
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {},
		keys = {
			{ "-", "<cmd>Oil --float<CR>", desc = "Open Oil" },
		},
		config = function()
			require("oil").setup({
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
			})
			-- vim.keymap.set("n", "-", "<cmd>Oil --float<CR>", { desc = "Open Oil" })
		end,
		dependencies = {
			{
				"nvim-tree/nvim-web-devicons",
				"oil-vcs-status",
				-- "oil-git-status.nvim",
			},
		},
		event = { "BufReadPre", "VimEnter" },
	},
	-- {
	-- 	"refractalize/oil-git-status.nvim",
	-- 	enabled = false,
	-- 	lazy = false,
	-- 	dependencies = {
	-- 		"stevearc/oil.nvim",
	-- 	},
	--
	-- 	config = function()
	-- 		require("oil-git-status").setup({})
	-- 		for _, hl_group in pairs(require("oil-git-status").highlight_groups) do
	-- 			if hl_group.index then
	-- 				vim.api.nvim_set_hl(0, hl_group.hl_group, { fg = "#ff0000" })
	-- 			else
	-- 				vim.api.nvim_set_hl(0, hl_group.hl_group, { fg = "#00ff00" })
	-- 			end
	-- 		end
	-- 	end,
	-- },
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
			-- set highlight_groups
			local color = require("catppuccin.palettes").get_palette("mocha")

			-- Added
			vim.api.nvim_set_hl(0, "OilVcsStatusAdded", { fg = color.green })
			vim.api.nvim_set_hl(0, "OilVcsStatusUpstreamAdded", { fg = color.green })

			-- Copied
			vim.api.nvim_set_hl(0, "OilVcsStatusCopied", { fg = color.pink })
			vim.api.nvim_set_hl(0, "OilVcsStatusUpstreamCopied", { fg = color.pink })

			-- Untracked
			vim.api.nvim_set_hl(0, "OilVcsStatusUntracked", { fg = color.sky, background = "none" })
			vim.api.nvim_set_hl(0, "OilVcsStatusUpstreamUntracked", { fg = color.sky, background = "none" })

			-- Modified
			vim.api.nvim_set_hl(0, "OilVcsStatusModified", { fg = color.yellow })
			vim.api.nvim_set_hl(0, "OilVcsStatusUpstreamModified", { fg = color.yellow })

			-- Deleted
			vim.api.nvim_set_hl(0, "OilVcsStatusDeleted", { fg = color.maroon })
			vim.api.nvim_set_hl(0, "OilVcsStatusUpstreamDeleted", { fg = color.maroon })

			-- Ignored
			vim.api.nvim_set_hl(0, "OilVcsStatusIgnored", { fg = color.overlay0 })
			vim.api.nvim_set_hl(0, "OilVcsStatusUpstreamIgnored", { fg = color.overlay0 })

			-- Renamed
			vim.api.nvim_set_hl(0, "OilVcsStatusRenamed", { fg = color.mauve })
			vim.api.nvim_set_hl(0, "OilVcsStatusUpstreamRenamed", { fg = color.mauve })
		end,
	},
}
