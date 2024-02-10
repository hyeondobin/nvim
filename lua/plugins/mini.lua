return {
	{
		"echasnovski/mini.files",
		version = false,
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("mini.files").setup({
				mappings = {
					go_in = "<CR>",
					go_out = "-",
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
		"echasnovski/mini.starter",
		version = false,
		config = function()
			require("mini.starter").setup({
                
            })
		end,
	},
    {
        "echasnovski/mini.sessions",
        version = false,
        config = true,
    },
}
