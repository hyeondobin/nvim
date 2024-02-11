local keymap = vim.keymap
local opts = { noremap = true, silent = false }
local wk = require("which-key")

-- Pane Navigation
keymap.set("n", "<C-h>", "<C-w>h", opts)
keymap.set("n", "<C-j>", "<C-w>j", opts)
keymap.set("n", "<C-k>", "<C-w>k", opts)
keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Window Management
keymap.set("n", "<leader>sv", "<cmd>vsplit<CR>", opts)
keymap.set("n", "<leader>sh", "<cmd>split<CR>", opts)

-- Call Lazy
keymap.set("n", "<leader>l", "<cmd>Lazy<CR>", opts)

-- Center buffer while navigating
keymap.set("n", "{", "{zz", opts)
keymap.set("n", "}", "}zz", opts)
keymap.set("n", "<C-u>", "<C-u>zz", opts)
keymap.set("n", "<C-d>", "<C-d>zz", opts)
keymap.set("n", "<C-i>", "<C-i>zz", opts)
keymap.set("n", "<C-o>", "<C-o>zz", opts)
keymap.set("n", "n", "nzz", opts)
keymap.set("n", "N", "Nzz", opts)
keymap.set("n", "%", "%zz", opts)
keymap.set("n", "*", "*zz", opts)
keymap.set("n", "#", "#zz", opts)
keymap.set("n", "gg", "ggzz", opts)
keymap.set("n", "G", "Gzz", opts)
keymap.set("n", "S", function()
	local cmd = ":%s/<C-r><C-w>//gI<Left><Left><Left>"
	local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
	vim.api.nvim_feedkeys(keys, "n", false)
end, { noremap = true, desc = { "Rename word under cursor" } })

-- Utils
vim.keymap.set("i", "<C-=>", "<C-O>VY<C-O>$=<C-R><C-=><C-R>*<CR>", { desc = "Calculate current line" })

-- leader mapping with which key
local ts = require("telescope")

-- lazygit terminal locals
local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({
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
		vim.api.nvim_buf_set_keymap(term.bufnr, "n", "<leader>q", "<cmd>close<CR>", { noremap = true, silent = true })
	end,

	on_close = function()
		vim.cmd("startinsert!")
	end,
})
local function _lazygit_toggle()
	lazygit:toggle()
end

wk.register({
	f = {
		name = "Files",
		f = { "<cmd>Telescope find_files<CR>", "Find File" },
		g = { require("telescope.builtin").live_grep, "Grep File" },
		c = {
			function()
				require("telescope.builtin").find_files({ cwd = "~/Appdata/Local/nvim", prompt_title = "Neovim Config" })
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
		name = "Drive",
		c = {
			function()
				require("mini.files").open("C:/", false, {})
			end,
			"Drive C:\\",
		},
		f = {
			function()
				require("mini.files").open("F:/", false, {})
			end,
			"Drive D:\\",
		},
		h = { "<CMD>cd %:h<CR>", "cd to current file" },
	},
	t = {
		name = "Terminal",
		g = {
			function()
				_lazygit_toggle()
			end,
			"Terminal: Lazygit",
		},
		o = { "<CMD>ToggleTerm size=40 direction=horizontal<CR>", "Terminal: Open" },
	},
}, { prefix = "<leader>" })

-- terminal keymaps
keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Enter Normal mode with Esc" })

-- mini.files
local show_preview
local MiniFiles = require("mini.files")
local toggle_preview = function()
	show_preview = not show_preview
	MiniFiles.refresh({ windows = { preview = show_preview } })
end

vim.api.nvim_create_autocmd("User", {
	pattern = "MiniFilesBufferCreate",
	callback = function(args)
		local buf_id = args.data.buf_id
		keymap.set("n", "<leader>p", toggle_preview, { buffer = buf_id })
	end,
})
