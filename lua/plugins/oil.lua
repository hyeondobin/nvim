vim.api.nvim_create_autocmd("FileType", {
	pattern = "oil",
	callback = function()
		vim.opt_local.colorcolumn = ""
	end,
})

return {
	{
		"stevearc/oil.nvim",
		opts = {},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false,
		config = function()
			require("oil").setup({
				keymaps = {
					["g?"] = "actions.show_help",
					["<CR>"] = "actions.select",
					["<C-\\>"] = "actions.select_vsplit",
					["<C-Enter>"] = "actions.select_split",
					["<C-t>"] = "actions.select_tab",
					["<C-p>"] = "actions.preview",
					["<C-c>"] = "actions.close",
					["<C-r>"] = "actions.refresh",
					["-"] = "actions.parent",
					["_"] = "actions.open_cwd",
					["`"] = "actions.cd",
					["~"] = "actions.tcd",
					["gs"] = "actions.change_sort",
					["gx"] = "actions.open_external",
					["g."] = "actions.toggle_hidden",
				},
				use_default_keymaps = false,
				columns = {
					"icon",
					"permissions",
					"size",
					"mtime",
				},
				view_options = {
					show_hidden = true,

					is_hidden_file = function(name, bufnr)
						return vim.startswith(name, ".")
					end,
				},
                float = {
                    padding = 8,
                    max_width = 0,
                    max_height = 0,
                    border = "rounded",
                    win_options = {
                        winblend = 0,
                    },
                    ovrride = function(conf)
                        return conf
                    end,
                },
			})
		end,
	},
}
