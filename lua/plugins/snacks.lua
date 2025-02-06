---@diagnostic disable: assign-type-mismatch
return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			--stylua: ignore start
			{ "<leader>gl", function() require("snacks").lazygit.open() end, desc = "Open lazygit" },
			{ "<leader>gs", function() Snacks.picker.git_status() end, desc = "find git status" },
			{ "<leader>nh", function() Snacks.notifier.show_history() end, desc = "Notification history" },
            ---@diagnostic disable-next-line: missing-fields
			{ "<leader>ffc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "find files; config" },
			{ "<leader>fd", function() Snacks.picker.diagnostics() end, desc = "document diagnostics" },
			{ "<leader>fs", function() Snacks.picker.lsp_symbols() end, desc = "find lsp symbols" },
			{ "<leader>ffg", function() Snacks.picker.grep() end, desc = "find file; grep" },
			{ "<leader>fh", function() Snacks.picker.help() end, desc = "find help" },
			{ "<leader>fk", function() Snacks.picker.keymaps() end, desc = "find keymaps" },
			{ "<leader>ffr", function() Snacks.picker.recent() end, desc = "find file; recent" },
			{ "<leader>f;", function() Snacks.picker.command_history() end, desc = "find command history" },
			{ "<leader>f:", function() Snacks.picker.commands() end, desc = "find commands" },
			{ "<leader>fo", function() Snacks.picker.current() end, desc = "find commands" },
			{ "<C-p>", function() Snacks.picker.smart() end, desc = "find files" },
			{ "<m-r>", function() Snacks.picker.resume() end, desc = "Resume" },
			--stylua: ignore end
		},
		---@type snacks.Config
		opts = {
			---@class snacks.dashboard.Config
			dashboard = {
				enabled = false,
			},
			indent = {
				enabled = true,
				---@class snacks.indent.Scope.Config: snacks.scope.Config
				scope = {
					enabled = true,
					priority = 200,
					only_current = true,
				},
				chunk = {
					enabled = true,
				},
			},
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
			picker = { enabled = true },
			scope = {
				enabled = true,
			},
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
