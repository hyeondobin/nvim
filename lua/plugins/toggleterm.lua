return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		config = function()
			local powershell_options = {
				shell = vim.fn.executable("pwsh") and "pwsh" or "powershell",
				shellcmdflag = "-Nologo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
				shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
				shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
				shellquote = "",
				shellxquote = "",
			}

			if vim.uv.os_uname().sysname == "Windows_NT" then
				for option, value in pairs(powershell_options) do
					vim.opt[option] = value
				end
			end

			require("toggleterm").setup({})

			local Terminal = require("toggleterm.terminal").Terminal
			local openTerm = Terminal:new({
				on_open = function(term)
					vim.cmd("startinsert!")
					vim.api.nvim_buf_set_keymap(
						term.bufnr,
						"n",
						"<leader>q",
						"<cmd>close<CR>",
						{ noremap = true, silent = true }
					)
				end,

				on_close = function()
					vim.cmd("startinsert!")
				end,
			})
			local git_term = Terminal:new({
				-- cmd = function()
				-- 	-- if vim.uv.os_uname().sysname == "Windows NT" then
				-- 	-- 	return "lazygit"
				-- 	-- else
				-- 	-- 	return "lazygit"
				-- 	-- end
				-- end,
				cmd = "lazygit",
				dir = "git_dir",
				hidden = true,
				count = 7,
				direction = "float",
				float_opts = {
					border = "double",
				},
				on_open = function(term)
					vim.cmd("startinsert!")
					vim.api.nvim_buf_set_keymap(
						term.bufnr,
						"n",
						"<leader>q",
						"<cmd>close<CR>",
						{ noremap = true, silent = true }
					)
				end,

				on_close = function()
					vim.cmd("startinsert!")
				end,
			})
            -- stylua: ignore start
            vim.keymap.set("n", "<leader>to", "<cmd>ToggleTerm<CR>", { desc = "Open Terminal" })
            vim.keymap.set("n", "<leader>tg", function() git_term:toggle() end, { desc = "Open Git" })
		end,
	},
}
