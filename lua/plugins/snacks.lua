return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{
				"<leader>gl",
				function()
					require("snacks").lazygit.open()
				end,
				desc = "Open lazygit",
			},
			{
				"<leader>nh",
				function()
					Snacks.notifier.show_history()
				end,
				desc = "Notification history",
			},
		},
		---@type snacks.Config
		opts = {
			indent = { enabled = true },
			---@class snacks.input.Config
			input = {
				enabled = true,
				icon = "",
			},
			lazygit = { enabled = true },
			---@class snacks.notifier.Config
			notifier = {
				enabled = true,
				timeout = 2500,
				style = "fancy",
			},
			notify = { enabled = true },
			---@type table<string, snacks.win.Config>
			styles = {
				notification = {
					wo = { wrap = true },
				},
			},
		},
		init = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				callback = function()
					_G.dd = function(...)
						Snacks.debug.inspect(...)
					end
					_G.bt = function()
						Snacks.debug.backtrace()
					end
					vim.print = _G.dd
				end,
			})
		end,
	},
}
