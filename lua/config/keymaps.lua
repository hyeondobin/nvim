local keymap = vim.keymap
local opts = { noremap = true, silent = false }
local wk = require("which-key")

keymap.set("n", "<Space>", "<nop>", opts)
-- Pane Navigation
keymap.set("n", "<C-h>", "<C-w>h", opts)
keymap.set("n", "<C-j>", "<C-w>j", opts)
keymap.set("n", "<C-k>", "<C-w>k", opts)
keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Call Lazy
keymap.set("n", "<leader>l", "<cmd>Lazy<CR>", opts)

-- Cancel with <C-c>
keymap.set("i", "<C-c>", "<Esc>", opts)

-- Move line
keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = false, desc = "Move Line Up" })
keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = false, desc = "Move Line Down" })

-- Center buffer while navigating
keymap.set("n", "{", "{zz", opts)
keymap.set("n", "}", "}zz", opts)
keymap.set("n", "<C-u>", "<C-u>zz", opts)
keymap.set("n", "<C-d>", "<C-d>zz", opts)
keymap.set("n", "<C-i>", "<C-i>zz", opts)
keymap.set("n", "<C-o>", "<C-o>zz", opts)
keymap.set("n", "n", "nzzzv", opts)
keymap.set("n", "N", "Nzzzv", opts)
keymap.set("n", "%", "%zzzv", opts)
keymap.set("n", "*", "*zzzv", opts)
keymap.set("n", "#", "#zzzv", opts)
keymap.set("n", "gg", "ggzz", opts)
keymap.set("n", "G", "Gzz", opts)
keymap.set("n", "S", function()
	local cmd = ":%s/<C-r><C-w>//gI<Left><Left><Left>"
	local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
	vim.api.nvim_feedkeys(keys, "n", false)
end, { noremap = true, desc = { "Rename word under cursor" } })
keymap.set("v", "S", function()
	local cmd = ":s//gI<Left><Left><Left>"
	local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
	vim.api.nvim_feedkeys(keys, "n", false)
end, { noremap = true, desc = { "Rename word under cursor" } })

keymap.set("v", ">", ">gv", opts)
keymap.set("v", "<", "<gv", opts)
-- Utils
vim.keymap.set("i", "<C-=>", "<C-O>VY<C-O>$=<C-R><C-=><C-R>*<CR>", { desc = "Calculate current line" })

-- DAP
keymap.set("n", "<F8>", "<CMD>DapToggleBreakpoint<CR>", { desc = "Toggle breakpoint" })
keymap.set("n", "<F9>", "<CMD>DapContinue<CR>", { desc = "DapContinue" })
keymap.set("n", "<F10>", "<CMD>DapStepOver<CR>", { desc = "DapStepOver" })

-- leader mapping with which key

-- lazygit terminal locals
local Terminal = require("toggleterm.terminal").Terminal
local openTerm = Terminal:new({
	on_open = function(term)
		vim.cmd("startinsert!")
		vim.api.nvim_buf_set_keymap(term.bufnr, "n", "<leader>q", "<cmd>close<CR>", { noremap = true, silent = true })
	end,

	on_close = function()
		vim.cmd("startinsert!")
	end,
})
local git_term = Terminal:new({
	cmd = function()
		if vim.loop.os_uname().sysname == "Windows NT" then
			return "pwsh -c 'bash -c tig'"
		else
			return "tig"
		end
	end,
	dir = "git_dir",
	hidden = true,
	count = 7,
	direction = "float",
	float_opts = {
		border = "double",
	},
	on_open = function(term)
		vim.cmd("startinsert!")
		vim.api.nvim_buf_set_keymap(term.bufnr, "n", "<leader>q", "<cmd>close<CR>", { noremap = true, silent = true })
	end,

	on_close = function()
		vim.cmd("startinsert!")
	end,
})
local function git_term_toggle()
	git_term:toggle()
end

wk.register({
	f = {
		name = "Files",
		f = { "<cmd>Telescope find_files<CR>", "Find File" },
		g = { require("telescope.builtin").live_grep, "Grep File" },
		c = {
			function()
				if vim.loop.os_uname().sysname == "Windows_NT" then
					require("telescope.builtin").find_files({
						cwd = "~/Appdata/Local/nvim",
						prompt_title = "Neovim Config",
					})
				else
					require("telescope.builtin").find_files({ cwd = "~/.config/nvim", prompt_title = "Neovim Config" })
				end
			end,
			"Config Files",
		},
		r = { "<cmd>Telescope oldfiles<CR>", "Find Recent" },
	},
	c = {
		name = "config",
		e = { "<cmd>e ~/Appdata/Local/nvim/init.lua<CR>", "Config Edit" },
		s = { "<cmd>w<CR><CMD>so<CR>", "save and Source" },
		m = { "<CMD>Mason<CR>", "Mason" },
		d = { "<CMD>cd %:h<CR>", "Cd to current file" },
	},
	["<space>"] = { require("telescope.builtin").find_files, "Find File" },
	s = {
		name = "Search",
		d = { "<CMD>Telescope diagnostics<CR>", "Search Diagnostics" },
		h = { "<CMD>Telescope help_tags<CR>", "Search Help" },
		k = { "<CMD>Telescope keymaps<CR>", "Search Keymaps" },
		o = { "<CMD>Telescope vim_options<CR>", "Search Options" },
		b = { "<CMD>Telescope buffers<CR>", "Search Buffers" },
	},
	e = {
		function()
			require("mini.files").open()
		end,
		"Open mini.files",
	},
	d = {
		name = "Debug Adapter Protocol",
		r = {
			function()
				require("dap").repl.open()
			end,
			"open Repl",
		},
		h = {
			function()
				require("dap.ui.widgets").hover()
			end,
			"Hover",
		},
		p = {
			function()
				require("dap.ui.widgets").preview()
			end,
			"Preview",
		},
		f = {
			function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.frames)
			end,
			"Float",
		},
		s = {
			function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.scopes)
			end,
			"Scope",
		},
	},
	t = {
		name = "Terminal",
		g = {
			function()
				git_term_toggle()
			end,
			"Terminal: Lazygit",
		},
		o = {
			function()
				openTerm:toggle()
			end,
			"Terminal: Open",
		},
	},
	n = {
		name = "Neovide",
		t = {
			function()
				local is_transparent = vim.g.neovide_transparency
				if is_transparent ~= 1 then
					vim.g.neovide_transparency = 1
				else
					vim.g.neovide_transparency = 0.5
				end
			end,
			"toggle Transparency",
		},
	},
}, { prefix = "<leader>" })

-- terminal keymaps
keymap.set({ "n", "t" }, "<Esc>", "<C-\\><C-n>", { desc = "Enter Normal mode with Esc" })
