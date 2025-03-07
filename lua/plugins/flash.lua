return {
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {
			search = {
				mode = "fuzzy",
				incremental = true,
			},
			modes = {
				search = {
					enabled = false,
				},
				char = {
					enabled = false,
					jump_labels = true,
				},
			},
		},
        -- stylua: ignore
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash", },
            { "<m-s>", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter", },
            { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash", },
            { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search", },
            { "<C-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search", },
        },
	},
}
