return {
	{
		"habamax/vim-godot",
		event = "BufEnter *.gd",
		config = function()
			vim.opt_local.foldmethod = "expr"
			vim.opt_local.indentexpr = ""
		end,
	},
}
