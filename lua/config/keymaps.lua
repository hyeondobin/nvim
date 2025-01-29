local map = vim.keymap.set
local opts = { noremap = true, silent = false }

-- unmap space as it's leader key in normal mode -- leader key is now ","
-- map("n", "<Space>", "<nop>", opts)

map("n", "<M-w>", "<cmd>:xa<CR>", opts)
map("c", "<M-w>", "xa<CR>", opts)

-- navigating wrapped lines
map("n", "j", "gj", opts)
map("n", "k", "gk", opts)

-- center buffer while navigating wrapped lines
-- map("n", "j", "gjzz", opts)
-- map("n", "k", "gkzz", opts)

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
map("n", "%", "%zzzv", opts)
map("n", "*", "*zzzv", opts)
map("n", "#", "#zzzv", opts)
-- map("n", "G", "Gzz", opts)

-- rename word under cursor
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

-- leader mapping
map("n", "<leader>cs", "<cmd>w<CR><CMD>so<CR>", { desc = "Save and Source current file" })

-- DAP
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

if vim.g.neovide then
	map("n", "<leader>n", "", { desc = "Neovide | Notify" })
	map("n", "<leader>nt", function()
		local is_transparent = vim.g.neovide_transparency
		if is_transparent ~= 1 then
			vim.g.neovide_transparency = 1
		else
			vim.g.neovide_transparency = 0.7
		end
	end, { desc = "Toggle transparency" })
end
-- categorize
map("n", "<leader>b", "", { desc = "Buffer" })
map("n", "<leader>c", "", { desc = "Config | Code" })
map("n", "<leader>d", "", { desc = "DAP(Debug Adapter Protocol)" })
map("n", "<leader>f", "", { desc = "Find" })
map("n", "<leader>g", "", { desc = "Git" })
map("n", "<leader>gh", "", { desc = "Hunk" })
map("n", "<leader>p", "", { desc = "Preview" })
map("n", "<leader>pm", "", { desc = "Markdown" })
map("n", "<leader>r", "", { desc = "Rust" })
map("n", "<leader>rr", "<cmd>RustRun<CR>", { desc = "Rust Run" })
map("n", "<leader>s", "", { desc = "Surround" })
map("n", "<leader>t", "", { desc = "Terminal | Treesj" })
map("n", "<leader>x", "", { desc = "Troube" })
if not vim.g.neovide then
	map("n", "<leader>n", "", { desc = "Notify" })
end

-- terminal keymaps
map({ "t" }, "<Esc>", "<C-\\><C-n>", { desc = "Enter Normal mode with Esc" })
map({ "t" }, "<C-x>", "<C-\\><C-n>", { desc = "Enter Normal mode with <C-x>" })
