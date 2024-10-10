return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {
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
	},
	dependencies = { { "nvim-tree/nvim-web-devicons" } },
	event = { "BufReadPre" },
}
