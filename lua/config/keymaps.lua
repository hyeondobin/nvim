local keymap = vim.keymap
local opts = { noremap = true, silent = false }
local wk = require("which-key")

-- unmap space as it's leader key in normal mode
keymap.set("n", "<Space>", "<nop>", opts)

-- navigating wrapped lines
keymap.set("n", "j", "gj", opts)
keymap.set("n", "k", "gk", opts)

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
keymap.set("n", "gg", "ggzz", opts)
keymap.set("n", "G", "Gzz", opts)
keymap.set("n", "%", "%zzzv", opts)
keymap.set("n", "*", "*zzzv", opts)
keymap.set("n", "#", "#zzzv", opts)
keymap.set("n", "S", function()
	local cmd = ":%s/<C-r><C-w>//gI<Left><Left><Left>"
	local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
	vim.api.nvim_feedkeys(keys, "n", false)
end, { noremap = true, desc = "Rename word under cursor" })
keymap.set("v", "S", function()
	local cmd = ":s//gI<Left><Left><Left>"
	local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
	vim.api.nvim_feedkeys(keys, "n", false)
end, { noremap = true, desc = "Rename word under cursor" })

keymap.set("v", ">", ">gv", opts)
keymap.set("v", "<", "<gv", opts)

-- Utils
vim.keymap.set("i", "<C-=>", "<C-O>VY<C-O>$=<C-R>=<C-R>*<CR><C-O>yiw<C-O>$", { desc = "Calculate current line" })
vim.keymap.set("i", "<C-]>", "<C-O>VY<C-O>$=<C-R>=<C-R>*<CR><C-o>yiw<C-O>$", { desc = "Calculate current line" })

-- DAP

-- leader mapping with which key

-- lazygit terminal locals
wk.register({
	b = {
		name = "Buffer",
	},
	c = {
		name = "config",
		d = { "<CMD>cd %:h<CR>", "Cd to current file" },
		e = { "<cmd>e ~/Appdata/Local/nvim/init.lua<CR>", "Config Edit" },
		l = { "<cmd>LspInfo<CR>", "Lsp Info" },
		m = { "<CMD>Mason<CR>", "Mason" },
		s = { "<cmd>w<CR><CMD>so<CR>", "save and Source" },
	},
	d = {
		name = "Debug Adapter Protocol",
		b = { "<CMD>DapToggleBreakpoint<CR>", "Toggle breakpoint" },
		c = { "<CMD>DapContinue<CR>", "DapContinue" },
		f = {
			function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.frames)
			end,
			"Float",
		},
		h = {
			function()
				require("dap.ui.widgets").hover()
			end,
			"Hover",
		},
		o = { "<CMD>DapStepOver<CR>", "DapStepOver" },
		p = {
			function()
				require("dap.ui.widgets").preview()
			end,
			"Preview",
		},
		r = {
			function()
				require("dap").repl.open()
			end,
			"open Repl",
		},
		s = {
			function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.scopes)
			end,
			"Scope",
		},
	},
	e = {
		function()
			require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
		end,
		"Open mini.files - current file",
	},
	f = {
		name = "Files",
		c = {
			function()
				if vim.loop.os_uname().sysname == "Windows_NT" then
					require("telescope.builtin").find_files({
						cwd = "~/Appdata/Local/nvim",
						prompt_title = "Neovim Config",
					})
				else
					require("telescope.builtin").find_files({
						cwd = "~/.config/nvim",
						prompt_title = "Neovim Config",
					})
				end
			end,
			"Config Files",
		},
		f = { "<cmd>Telescope find_files<CR>", "Find File" },
		g = { require("telescope.builtin").live_grep, "Grep File" },
		r = { require("telescope.builtin").oldfiles, "Find Recent" },
	},
	g = {
		name = "Git",
		h = {
			name = "Hunk",
		},
	},
	n = {
		name = "[N]eovide",
		t = {
			function()
				local is_transparent = vim.g.neovide_transparency
				if is_transparent ~= 1 then
					vim.g.neovide_transparency = 1
				else
					vim.g.neovide_transparency = 0.5
				end
			end,
			"toggle [T]ransparency",
		},
	},
	p = {
		name = "[P]review",
		m = {
			name = "[M]arkdown",
		},
	},
	r = {
		name = "[R]estore",
	},
	s = {
		name = "[S]earch",
		b = { "<CMD>Telescope buffers<CR>", "[S]earch [B]uffers" },
		d = { "<CMD>Telescope diagnostics<CR>", "[S]earch [D]iagnostics" },
		h = { "<CMD>Telescope help_tags<CR>", "[S]earch [H]elp" },
		k = { "<CMD>Telescope keymaps<CR>", "[S]earch [K]eymaps" },
		o = { "<CMD>Telescope vim_options<CR>", "[S]earch [O]ptions" },
	},
	t = { name = "Terminal" },
}, { prefix = "<leader>" })

-- terminal keymaps
keymap.set({ "n", "t" }, "<Esc>", "<C-\\><C-n>", { desc = "Enter Normal mode with Esc" })
