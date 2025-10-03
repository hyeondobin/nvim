local opt = vim.opt
local indent = 4
-- Tab / Indentation
opt.tabstop = indent
opt.shiftwidth = indent
opt.softtabstop = indent
opt.expandtab = true
opt.smartindent = true
opt.wrap = true

-- Search
opt.hlsearch = false
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- Appearance
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.signcolumn = "yes"
opt.colorcolumn = "100"
opt.cmdheight = 1
opt.scrolloff = 15
opt.completeopt = "menu,menuone,popup,fuzzy,preview"
opt.cursorline = true
opt.cursorcolumn = true
opt.winborder = vim.g.borderStyle

-- font
opt.guifont = "JetBrainsMono NF:h15:cDEFAULT,D2CodingLigature Nerd Font:cHANGEUL"

-- Behaviour
opt.hidden = true
opt.errorbells = false
opt.swapfile = false
opt.backup = false
opt.undodir = vim.fn.expand("~/.vim/undodir")
opt.undofile = true
opt.backspace = "indent,eol,start"
opt.splitright = true
opt.splitbelow = true
opt.autochdir = false
opt.iskeyword:append("-")
opt.mouse:append("a")
opt.modifiable = true
opt.encoding = "UTF-8"

opt.isfname:append("@-@")

opt.updatetime = 200
opt.conceallevel = 0
opt.timeoutlen = 400
opt.ttimeoutlen = 400
