return {
	{
		"echasnovski/mini.ai",
		enabled = true,
		version = false,
		event = { "BufReadPost" },
		opts = {},
	},
	{
		"echasnovski/mini.files",
		enabled = true,
		version = false,
		lazy = false,
		opts = {
			options = {},
			windows = { preview = true },
		},
		keys = {
			{
				"<leader>e",
				function()
					require("mini.files").open()
				end,
				desc = "open mini.files",
			},
		},
	},
	{
		"echasnovski/mini.surround",
		version = false,
		opts = {
			mappings = {
				add = "<leader>sa",
				delete = "<leader>sd",
				find = "<leader>sf", -- Find surrounding (to the right)
				find_left = "<leader>sF", -- Find surrounding (to the left)
				highlight = "<leader>sh", -- Highlight surrounding
				replace = "<leader>sr", -- Replace surrounding
				update_n_lines = "<leader>sn", -- Update `n_lines`

				suffix_last = "l", -- Suffix to search with "prev" method
				suffix_next = "n", -- Suffix to search with "next" method
			},
		},
		config = true,
		event = { "BufReadPost" },
	},
	{
		"echasnovski/mini.bufremove",
		version = false,
		keys = {
			{
				"<leader>bd",
				function()
					local bd = require("mini.bufremove").delete
					if vim.bo.modified then
						local choice =
							vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
						if choice == 1 then -- Yes
							vim.cmd.write()
							bd(0)
						elseif choice == 2 then -- No
							bd(0, true)
						end
					else
						bd(0)
					end
				end,
				desc = "Delete Buffer",
			},
			{
				"<leader>bD",
				function()
					require("mini.bufremove").delete(0, true)
				end,
				desc = "Delete Buffer (Force)",
			},
		},
	},
}
