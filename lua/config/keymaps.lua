local map = vim.keymap.set
local opts = { noremap = true, silent = false }

-- unmap space as it's leader key in normal mode
map("n", "<Space>", "<nop>", opts)

map("n", "<M-w>", "<cmd>:x<CR>", opts)

-- navigating wrapped lines
map("n", "j", "gj", opts)
map("n", "k", "gk", opts)

-- Pane Navigation
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Call Lazy
map("n", "<leader>l", "<cmd>Lazy<CR>", opts)

-- Cancel with <C-c>
map("i", "<C-c>", "<Esc>", opts)

-- Move line
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = false, desc = "Move Line Up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = false, desc = "Move Line Down" })

-- Center buffer while navigating
map("n", "{", "{zz", opts)
map("n", "}", "}zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-i>", "<C-i>zz", opts)
map("n", "<C-o>", "<C-o>zz", opts)
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)
map("n", "gg", "ggzz", opts)
map("n", "G", "Gzz", opts)
map("n", "%", "%zzzv", opts)
map("n", "*", "*zzzv", opts)
map("n", "#", "#zzzv", opts)
map("n", "S", function()
	local cmd = ":%s/<C-r><C-w>//gI<Left><Left><Left>"
	local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
	vim.api.nvim_feedkeys(keys, "n", false)
end, { noremap = true, desc = "Rename word under cursor" })
map("v", "S", function()
	local cmd = ":s//gI<Left><Left><Left>"
	local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
	vim.api.nvim_feedkeys(keys, "n", false)
end, { noremap = true, desc = "Rename word under cursor" })

map("v", ">", ">gv", opts)
map("v", "<", "<gv", opts)

-- Utils
map("i", "<C-=>", "<C-O>VY<C-O>$=<C-R>=<C-R>*<CR><C-O>yiw<C-O>$", { desc = "Calculate current line" })
map("i", "<C-]>", "<C-O>VY<C-O>$=<C-R>=<C-R>*<CR><C-o>yiw<C-O>$", { desc = "Calculate current line" })

-- DAP

-- leader mapping
map("n", "<leader>e", "<cmd>Oil --float<CR>", { desc = "Oil" })
map("n", "-", "<cmd>Oil --float<CR>", { desc = "Oil" })

map("n", "<leader>b", "", { desc = "Buffer" })

map("n", "<leader>c", "", { desc = "Config | Code" })
map("n", "<leader>cd", "<cmd>cd %:h<CR>", { desc = "CD to current file's directory" })
map("n", "<leader>cs", "<cmd>w<CR><CMD>so<CR>", { desc = "Save and Source current file" })

map("n", "<leader>d", "", { desc = "DAP(Debug Adapter Protocol)" })
map("n", "<leader>db", "<cmd>DapToggleBreakpoint<CR>", { desc = "Toggle breakpoint" })
map("n", "<leader>dc", "<cmd>DapContinue<CR>", { desc = "DAP Continue" })
map("n", "<leader>df", function()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.frames)
end, { desc = "DAP Float" })
map("n", "<leader>dh", function()
	require("dap.ui.widgets").hover()
end, { desc = "DAP Hover" })
map("n", "<leader>do", "<cmd>DapStepOver<CR>", { desc = "DAP Step over" })
map("n", "<leader>dp", function()
	require("dap.ui.widgets").preview()
end, { desc = "DAP Preview" })
map("n", "<leader>dr", function()
	require("dap").repl.open()
end, { desc = "DAP open repl" })
map("n", "<leader>ds", function()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.scopes)
end, { desc = "DAP Scope" })

map("n", "<leader>f", "", { desc = "Find" })
map("n", "<leader>fc", function()
	require("telescope.builtin").find_files({
		cwd = vim.fn.stdpath("config"),
		promp_title = "Neovim Config",
	})
end, { desc = "Config Files" })
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find File" })
map("n", "<leader>fg", function()
	require("telescope.builtin").live_grep()
end, { desc = "Grep File" })
map("n", "<leader>fr", function()
	require("telescope.builtin").oldfiles()
end, { desc = "Find Recent" })
map("n", "<S-t>", "<cmd>Telescope buffers prompt_title=Buffers<CR>", { desc = "Buffers" })

map("n", "<leader>g", "", { desc = "Git" })
map("n", "<leader>gh", "", { desc = "Hunk" })

map("n", "<leader>n", "", { desc = "Neovide" })
map("n", "<leader>nt", function()
	local is_transparent = vim.g.neovide_transparency
	if is_transparent ~= 1 then
		vim.g.neovide_transparency = 1
	else
		vim.g.neovide_transparency = 0.5
	end
end, { desc = "Toggle transparency" })

map("n", "<leader>p", "", { desc = "Preview" })
map("n", "<leader>pm", "", { desc = "Markdown" })

map("n", "<leader>r", "", { desc = "Rust" })
map("n", "<leader>rr", "<cmd>RustRun<CR>", { desc = "Rust Run" })

map("n", "<leader>s", "", { desc = "Search" })
map("n", "<leader>sb", "<cmd>Telescope buffers<CR>", { desc = "Search Buffers" })
map("n", "<leader>sd", "<cmd>Telescope diagnostics<CR>", { desc = "Search diagnostics" })
map("n", "<leader>sh", "<cmd>Telescope help_tags<CR>", { desc = "Search help" })
map("n", "<leader>sk", "<cmd>Telescope keymaps<CR>", { desc = "Search keymaps" })
map("n", "<leader>so", "<cmd>Telescope vim_options<CR>", { desc = "Search options" })

map("n", "<leader>t", "", { desc = "Terminal" })

map("n", "<leader>x", "", { desc = "Troube" })

-- terminal keymaps
map({ "n", "t" }, "<Esc>", "<C-\\><C-n>", { desc = "Enter Normal mode with Esc" })
map({ "n", "t" }, "<Esc>", "<C-x><C-n>", { desc = "Enter Normal mode with Esc" })
