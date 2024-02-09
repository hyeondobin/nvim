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
keymap.set("n", "S", function ()
    local cmd = ":%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>"
    local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
    vim.api.nvim_feedkeys(keys, "n", false)
end, opts)

local ts = require('telescope')
wk.register(
    {
        f = {
            name = "Files",
            f = { "<cmd>Telescope find_files<CR>", "Find File" },
            g = { require('telescope.builtin').live_grep, "Grep File" },
            c = { function() require('telescope.builtin').find_files({ cwd = '~/Appdata/Local/nvim', prompt_title = 'Neovim Config' }) end, "Config Files" },
            r = { "<cmd>Telescope oldfiles<CR>", "Find Recent" },
        },
        c = {
            name = "config",
            e = { "<cmd>e ~/Appdata/Local/nvim/init.lua<CR>", "Config Edit" },
            s = { "<cmd>w<CR><CMD>so<CR>", "save and Source" },
            m = { "<CMD>Mason<CR>", "Mason" },
            d = { "<CMD>cd %:h<CR>", "Cd to current file" },
        },
        ["<space>"] = { require'telescope.builtin'.find_files , "Find File" },
        s = {
            name = "Search",
            d = { "<CMD>Telescope diagnostics<CR>", "Search Diagnostics" },
            h = { "<CMD>Telescope help_tags<CR>", "Search Help" },
            k = { "<CMD>Telescope keymaps<CR>", "Search Keymaps" },
        },
        -- d = {
        -- name = "Drive",
        --     c = { "<cmd>Oil --float C:\\<CR>", "Drive C:\\" },
        --     d = { "<cmd>Oil --float D:\\<CR>", "Drive D:\\" },
        --     f = { "<cmd>Oil --float F:\\<CR>", "Drive F:\\" },
        -- },
    }, { prefix = "<leader>" }
)

wk.register(
    {
        K = { vim.lsp.buf.hover, "LSP Hover" },
        ["<leader>rs"] = {  "<CMD>lua require'persistence'.load({ last = true })<CR>", "Restore Session" }
    }
)

keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = "Enter Normal mode with Esc" })
