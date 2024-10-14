local M = {
	"j-morano/buffer_manager.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	keys = {
		{
			"<M-b>",
			function()
				require("buffer_manager.ui").toggle_quick_menu()
			end,
			desc = "Open Buffer Manager",
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
			end,
		})
	end,
}

return M
