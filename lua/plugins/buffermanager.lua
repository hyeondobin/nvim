local M = {
	"j-morano/buffer_manager.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	event = { "VeryLazy" },
	opts = {
		order_buffers = "lastused",
		select_menu_item_commands = {
			v = {
				key = "<C-v>",
				command = "vspilt",
			},
			h = {
				key = "<C-h>",
				command = "split",
			},
			edit = {
				key = "<CR>",
				command = "",
			},
		},
	},
	keys = {
		{
			"<S-t>",
			function()
				require("buffer_manager.ui").toggle_quick_menu()
			end,
			desc = "Open Buffer Manager",
		},
		{
			"<M-m>",
			function()
				require("buffer_manager.ui").toggle_quick_menu()
				vim.defer_fn(function()
					vim.fn.feedkeys("/")
				end, 50)
			end,
			desc = "Open Buffer Manager and search",
		},
	},
	config = function(_, opts)
		local bmui = require("buffer_manager.ui")
		require("buffer_manager").setup(opts)
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "buffer_manager",
			callback = function()
				vim.keymap.set("n", "<C-c>", function()
					bmui.toggle_quick_menu()
				end, { noremap = true, buffer = true })
				vim.keymap.set("n", "<CR>", function()
					bmui.toggle_quick_menu()
				end, { noremap = true, buffer = true })
			end,
		})
		local keys = "1234567890"
		local opt = { noremap = true }
		for i = 1, #keys do
			local key = keys:sub(i, i)
			vim.keymap.set("n", string.format("<M-%s>", key), function()
				bmui.nav_file(i)
			end, opt)
		end

		vim.api.nvim_set_hl(0, "BufferManagerModified", { fg = "#0000af" })
	end,
}

return M
