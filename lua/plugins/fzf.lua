return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- or if using mini.icons/mini.nvim
	-- dependencies = { "echasnovski/mini.icons" },
	opts = {
		winopts = {
			preview = {
				layout = "horizontal",
			},
		},
		previewers = {
			keymaps = {
				layout = "horizontal",
			},
		},
	},
	keys = {
		{
			"<leader>fc",
			function()
				require("fzf-lua").files({ cwd = vim.fn.stdpath("config") })
			end,
			desc = "config files",
		},
		{
			"<leader>fd",
			function()
				require("fzf-lua").diagnostics_document()
			end,
			desc = "document diagnostics",
		},
		{
			"<leader>fg",
			function()
				require("fzf-lua").live_grep()
			end,
			desc = "live grep files",
		},
		{
			"<leader>fh",
			function()
				require("fzf-lua").helptags()
			end,
		},
		{
			"<leader>fk",
			function()
				require("fzf-lua").keymaps()
			end,
			desc = "find keymaps",
		},
		{
			"<leader>fr",
			function()
				require("fzf-lua").oldfiles()
			end,
		},
		{
			"<C-p>",
			function()
				require("fzf-lua").files()
			end,
			desc = "find files",
		},
		{
			"<m-r>",
			function()
				require("fzf-lua").resume()
			end,
		},
	},
}
