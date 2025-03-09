---@param idx number|"last"
local function openNotif(idx)
	-- CONFIG
	local maxWidth = 0.85
	local maxHeight = 0.85

	-- get Notification
	if idx == "last" then
		idx = 1
	end
	local history = require("snacks").notifier.get_history({
		filter = function(notif)
			return notif.level ~= "trace"
		end,
		reverse = true,
	})
	local notif = history[idx]
	if not notif then
		local msg = "No notifications."
		vim.notify(msg, vim.log.levels.TRACE, { title = "Last notification", icon = "=" })
		return
	end
	require("snacks").notifier.hide(notif.id)

	--win properties
	local bufnr = vim.api.nvim_create_buf(false, true)
	local lines = vim.split(notif.msg, "\n")
	vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
	local title = vim.trim((notif.icon or "") .. " " .. (notif.title or ""))
	local height = math.min(#lines + 2, math.ceil(vim.o.lines * maxHeight))
	local longestLine = vim.iter(lines):fold(0, function(acc, line)
		return math.max(acc, #line)
	end)
	longestLine = math.max(longestLine, #title)
	local width = math.min(longestLine + 3, math.ceil(vim.o.columns * maxWidth))

	local overflow = #lines + 2 - height -- +2 for border
	local moreLines = overflow > 0 and ("V %d lines"):format(overflow) or ""
	local indexStr = ("(%d/%d)"):format(idx, #history)
	local footer = vim.trim(indexStr .. "    " .. moreLines)

	local levelCapitalizd = notif.level:sub(1, 1):upper() .. notif.level:sub(2)
	local highlights = {
		"Normal:SnacksNormal",
		"NormalNC:SnacksNormalNC",
		"FloatBorder:SnacksNotifierBorder" .. levelCapitalizd,
		"FloatTitle:SnacksNotifierTitle" .. levelCapitalizd,
		"FloatFooter:SnacksNotifierFooter" .. levelCapitalizd,
	}

	-- create window with snacks api
	require("snacks").win({
		relative = "editor",
		position = "float",
		ft = notif.ft or "markdown",
		buf = bufnr,
		height = height,
		width = width,
		title = vim.trim(title) ~= "" and " " .. title .. " " or nil,
		footer = footer and " " .. footer .. " " or nil,
		footer_pos = footer and "right" or nil,
		wo = {
			winhighlight = table.concat(highlights, ","),
			wrap = true,
			statuscolumn = " ", -- adds padding
			cursorline = true,
			colorcolumn = "",
			winfixbuf = true,
		},
		bo = {
			ft = "snacks_notif",
			modifiable = false,
		},
		keys = {
			["<Esc>"] = "close",
			["<Tab>"] = function()
				if idx == #history then
					return
				end
				vim.cmd.close()
				openNotif(idx + 1)
			end,
			["<S-Tab>"] = function()
				if idx == 1 then
					return
				end
				vim.cmd.close()
				openNotif(idx - 1)
			end,
		},
	})
end

---@diagnostic disable: assign-type-mismatch
return {
	{
		"folke/snacks.nvim",
		enabled = true,
		priority = 1000,
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			--stylua: ignore start
			{ "<leader>fd", function() Snacks.picker.diagnostics() end, desc = "document diagnostics" },
			{ "<leader>ffc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "find files; config" },
			{ "<leader>ffg", function() require('nvim-rooter').rooter_default() Snacks.picker.grep() end, desc = "find file; grep" },
			{ "<leader>ffr", function() Snacks.picker.recent() end, desc = "find file; recent" },
			{ "<leader>fh", function() Snacks.picker.help() end, desc = "find help" },
			{ "<leader>fk", function() Snacks.picker.keymaps() end, desc = "find keymaps" },
			{ "<leader>fs", function() Snacks.picker.lsp_symbols() end, desc = "find lsp symbols" },
			{ "<leader>f;", function() Snacks.picker.command_history() end, desc = "find command history" },
			{ "<leader>f:", function() Snacks.picker.commands() end, desc = "find commands" },
			{ "<leader>fo", function() Snacks.picker.current() end, desc = "find commands" },
            { "<leader>gb", function() Snacks.picker.git_diff() end, desc = "git blame line"},
			{ "<leader>gl", function() require('nvim-rooter').rooter_default() Snacks.lazygit() end, desc = "Open lazygit" },
			{ "<leader>gs", function() Snacks.picker.git_status() end, desc = "find git status" },
			{ "<leader>nh", function() Snacks.notifier.show_history() end, desc = "Notification history" },
			{ "<leader>nl", function() openNotif("last") end, mode = {"n","v"}, desc = "Notification last" },
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
				only_scope = true,
				---@class snacks.indent.Scope.Config: snacks.scope.Config
			},
			scope = {
				enabled = true,
				priority = 200,
				only_current = true,
				underline = true,
			},
			chunk = {
				enabled = true,
			},
			---@class snacks.input.Config
			input = {
				enabled = true,
				icon = "",
			},
			lazygit = { enabled = true, configure = false },
			---@class snacks.notifier.Config
			notifier = {
				timeout = 7500,
				sort = { "added" },
				width = { min = 12, max = 0.45 },
				height = { min = 1, max = 0.45 },
				icons = { error = "󰅚", warn = "", info = "󰋽", debug = "󰃤", trace = "󰓗" },
				style = "fancy",
				topdown = false,
			},
			notify = { enabled = true },
			picker = { enabled = true },
			---@type table<string, snacks.win.Config>
			styles = {
				input = {
					backdrop = true,
					border = vim.g.borderStyle,
					title_pos = "left",
					width = 50,
					row = math.ceil(vim.o.lines / 2) - 3,
					wo = { colorcolumn = "" },
					keys = {
						CR = { "<CR>", "confirm", mode = "n" },
					},
				},
				notification = {
					border = vim.g.borderStyle,
					focusable = false,
					wo = { winblend = 0, wrap = true },
				},
				blame_line = {
					backdrop = true,
					width = 0.6,
					height = 0.6,
					border = vim.g.borderStyle,
					title = "Git Blame",
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
