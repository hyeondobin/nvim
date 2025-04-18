return {
	{
		"nvim-treesitter/nvim-treesitter",
		version = false,
		enabled = true,
		event = { "BufReadPost", "BufWritePost", "BufNewFile", "VeryLazy" },
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
		dependencies = {
			-- Additional text objects for treesitter
			"nvim-treesitter/nvim-treesitter-textobjects",
			"ikatyang/tree-sitter-yaml",
		},
		config = function()
			-- require("nvim-treesitter.install").compilers = { "zig", "clang" }
			---@diagnostic disable: missing-fields
			require("nvim-treesitter.configs").setup({
				auto_install = true,
				ignore_install = { "yaml" },
				sync_install = false,
				highlight = {
					enable = true,
				},
				indent = {
					enable = true,
				},
				autopairs = {
					enable = true,
				},
				autotag = {
					enable = true,
				},
				--[[ context_commentstring = {
					enable = true,
					enable_autocmd = false,
				}, ]]
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<c-space>",
						node_incremental = "<c-space>",
						scope_incremental = "<c-s>",
						node_decremental = "<c-backspace>",
					},
				},
				textobjects = {
					select = {
						enable = true,
						lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							["aa"] = "@parameter.outer",
							["ia"] = "@parameter.inner",
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
						},
					},
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["]m"] = "@function.outer",
							["]]"] = "@class.outer",
						},
						goto_next_end = {
							["]M"] = "@function.outer",
							["]["] = "@class.outer",
						},
						goto_previous_start = {
							["[m"] = "@function.outer",
							["[["] = "@class.outer",
						},
						goto_previous_end = {
							["[M"] = "@function.outer",
							["[]"] = "@class.outer",
						},
					},
				},
			})
		end,
	},
	{
		"ikatyang/tree-sitter-yaml",
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "VeryLazy",
		opts = {
			trim_scope = "inner",
			separator = "-",
		},
	},
}
