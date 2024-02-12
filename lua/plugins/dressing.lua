return {
    {
        "stevearc/dressing.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim"
        },
        lazy = false,
        config = function()
            require("dressing").setup({
                select = {
                    get_config = function(opts)
		if opts.kind == "codeaction" then
			return {
				backend = "nui",
				nui = {
					relative = "cursor",
					max_width = 40,
				},
			}
		end
                    end,
                },
            })
        end,
    },
}
