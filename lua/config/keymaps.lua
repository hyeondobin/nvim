local keymap = vim.keymap
local opts = { noremap = true, silent = false }

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

-- leader mapping
keymap.set("n", "<leader>e", "<cmd>Oil --float<CR>", { desc = "Oil" })
keymap.set("n", "-", "<cmd>Oil --float<CR>", { desc = "Oil" })

keymap.set("n", "<leader>b", "", { desc = "Buffer" })

keymap.set("n", "<leader>c", "", { desc = "Config | Code" })
keymap.set("n", "<leader>cd", "<cmd>cd %:h<CR>", { desc = "CD to current file's directory" })
keymap.set("n", "<leader>cs", "<cmd>w<CR><CMD>so<CR>", { desc = "Save and Source current file" })

keymap.set("n", "<leader>d", "", { desc = "DAP(Debug Adapter Protocol)" })
keymap.set("n", "<leader>db", "<cmd>DapToggleBreakpoint<CR>", { desc = "Toggle breakpoint" })
keymap.set("n", "<leader>dc", "<cmd>DapContinue<CR>", { desc = "DAP Continue" })
keymap.set("n", "<leader>df", function()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.frames)
end, { desc = "DAP Float" })
keymap.set("n", "<leader>dh", function()
	require("dap.ui.widgets").hover()
end, { desc = "DAP Hover" })
keymap.set("n", "<leader>do", "<cmd>DapStepOver<CR>", { desc = "DAP Step over" })
keymap.set("n", "<leader>dp", function()
	require("dap.ui.widgets").preview()
end, { desc = "DAP Preview" })
keymap.set("n", "<leader>dr", function()
	require("dap").repl.open()
end, { desc = "DAP open repl" })
keymap.set("n", "<leader>ds", function()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.scopes)
end, { desc = "DAP Scope" })

keymap.set("n", "<leader>f", "", { desc = "Find" })
keymap.set("n", "<leader>fc", function()
	require("telescope.builtin").find_files({
		cwd = vim.fn.stdpath("config"),
		promp_title = "Neovim Config",
	})
end, { desc = "Config Files" })
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find File" })
keymap.set("n", "<leader>fg", function()
	require("telescope.builtin").live_grep()
end, { desc = "Grep File" })
keymap.set("n", "<leader>fr", function()
	require("telescope.builtin").oldfiles()
end, { desc = "Find Recent" })

keymap.set("n", "<leader>g", "", { desc = "Git" })
keymap.set("n", "<leader>gh", "", { desc = "Hunk" })

keymap.set("n", "<leader>n", "", { desc = "Neovide" })
keymap.set("n", "<leader>nt", function()
	local is_transparent = vim.g.neovide_transparency
	if is_transparent ~= 1 then
		vim.g.neovide_transparency = 1
	else
		vim.g.neovide_transparency = 0.5
	end
end, { desc = "Toggle transparency" })

keymap.set("n", "<leader>p", "", { desc = "Preview" })
keymap.set("n", "<leader>pm", "", { desc = "Markdown" })

keymap.set("n", "<leader>r", "", { desc = "Restore" })

keymap.set("n", "<leader>s", "", { desc = "Search" })
keymap.set("n", "<leader>sb", "<cmd>Telescope buffers<CR>", { desc = "Search Buffers" })
keymap.set("n", "<leader>sd", "<cmd>Telescope diagnostics<CR>", { desc = "Search diagnostics" })
keymap.set("n", "<leader>sh", "<cmd>Telescope help_tags<CR>", { desc = "Search help" })
keymap.set("n", "<leader>sk", "<cmd>Telescope keymaps<CR>", { desc = "Search keymaps" })
keymap.set("n", "<leader>so", "<cmd>Telescope vim_options<CR>", { desc = "Search options" })

keymap.set("n", "<leader>t", "", { desc = "Terminal" })

-- terminal keymaps
keymap.set({ "n", "t" }, "<Esc>", "<C-\\><C-n>", { desc = "Enter Normal mode with Esc" })
