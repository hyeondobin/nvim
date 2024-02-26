return {
	{
		"echasnovski/mini.files",
		version = false,
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("mini.files").setup({
				mappings = {},
				windows = {
					preview = true,
					width_preview = 100,
				},
			})
		end,
	},
	{
		"echasnovski/mini.pairs",
		version = false,
		event = { "InsertEnter" },
		config = true,
	},
	{
		"echasnovski/mini.surround",
		version = false,
		config = true,
		event = { "InsertEnter" },
	},
	{
		"echasnovski/mini.animate",
		version = false,
		config = function()
			require("mini.animate").setup({
				cursor = {
					enable = true,
				},
				scroll = {
					enable = true,
				},
				open = {
					enable = true,
				},
				close = {
					enable = true,
				},
			})
		end,
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
