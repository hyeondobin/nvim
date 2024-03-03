return {
	{
		"habamax/vim-godot",
		event = "BufEnter *.gd",
		config = function()
			vim.opt_local.foldmethod = "expr"
			vim.opt_local.indentexpr = ""
			vim.opt_local.tabstop = 4
			vim.opt_local.shiftwidth = 4
			vim.opt_local.expandtab = false
		end,
	},
}
