return {
	"folke/which-key.nvim",
	event = "VimEnter",
	---@class wk.Opts
	opts = {
		preset = "helix",
		plugins = { spelling = true },
		spec = {
			{
				mode = "n",
				{ "<leader>", group = "" },
				{ "<leader>b", group = "Buffer" },
				{ "<leader>c", group = "Config | Code" },
				{ "<leader>d", group = "DAP(Debug Adapter Protocol)" },
				{ "<leader>f", group = "Find" },
				{ "<leader>ff", group = "Find files" },
				{ "<leader>fw", group = "Write and ..." },
				{ "<leader>g", group = "Git" },
				{ "<leader>gh", group = "Hunk" },
				{ "<leader>p", group = "Preview" },
				{ "<leader>pm", group = "Markdown" },
				{ "<leader>r", group = "Restore | Rust" },
				{ "<leader>rr", "<cmd>RustRun<CR>", group = "Rust Run" },
				{ "<leader>s", group = "Surround" },
				{ "<leader>t", group = "Terminal | Treesj" },
				{ "<leader>x", group = "Troube" },
				{ "<leader>n", group = "Neovide | Notify" },
				{ "<leader>i", group = "Info" },
			},
			{
				mode = "v",
				{ "<leader>c", group = "Code" },
			},
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
