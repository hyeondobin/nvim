return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	opts = function()
		local logo = [[
            ██████╗  █████╗ ███╗   ██╗██████╗ ██╗   ██╗██╗   ██╗ █████╗ ██╗     
            ██╔══██╗██╔══██╗████╗  ██║██╔══██╗██║   ██║╚██╗ ██╔╝██╔══██╗██║     
            ██████╔╝███████║██╔██╗ ██║██████╔╝██║   ██║ ╚████╔╝ ███████║██║     
            ██╔═══╝ ██╔══██║██║╚██╗██║██╔══██╗██║   ██║  ╚██╔╝  ██╔══██║██║     
            ██║     ██║  ██║██║ ╚████║██║  ██║╚██████╔╝   ██║   ██║  ██║███████╗
            ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝ ╚═════╝    ╚═╝   ╚═╝  ╚═╝╚══════╝
    ]]

		logo = string.rep("\n", 8) .. logo .. "\n\n"

		local opts = {
			theme = "doom",
			hide = {
				-- this is taken care of by lualine
				-- enabling this messes up the actual laststatus setting after loading a file
				statusline = false,
			},
			config = {
				header = vim.split(logo, "\n"),
				center = {
					{
						action = function()
							if vim.uv.os_uname().sysname == "Windows_NT" then
								require("fzf-lua").files({ cwd = "C:/Users/dobin" })
							else
								return "FzfLua files"
							end
						end,
						desc = " Find file",
						icon = " ",
						key = "f",
					},
					{
						action = "ene | startinsert",
						desc = " New file",
						icon = " ",
						key = "n",
					},
					{
						action = function()
							require("fzf-lua").oldfiles()
						end,
						desc = " Recent files",
						icon = " ",
						key = "r",
					},
					{
						action = function()
							require("fzf-lua").live_grep()
						end,
						desc = " Find text",
						icon = " ",
						key = "g",
					},
					-- { action = "lua require'telescope.builtin'.find_files({cwd=" .. configdir() .. ", prompt_title = 'Neovim Config'})", desc = " Config",          icon = " ", key = "c" },
					{
						action = function()
							require("fzf-lua").files({
								cwd = vim.fn.stdpath("config"),
							})
						end,
						desc = " Config",
						icon = " ",
						key = "c",
					},
					{
						action = 'lua require("persistence").load({last=true})',
						desc = " Restore Session",
						icon = " ",
						key = "s",
					},
					{
						action = "Lazy",
						desc = " Lazy",
						icon = "󰒲 ",
						key = "l",
					},
					{
						action = "qa",
						desc = " Quit",
						icon = " ",
						key = "q",
					},
				},
				footer = function()
					local stats = require("lazy").stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
					return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
				end,
			},
		}

		for _, button in ipairs(opts.config.center) do
			button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
			button.key_format = "  %s"
		end

		-- close Lazy and re-open when the dashboard is ready
		if vim.o.filetype == "lazy" then
			vim.cmd.close()
			vim.api.nvim_create_autocmd("User", {
				pattern = "DashboardLoaded",
				callback = function()
					require("lazy").show()
				end,
			})
		end

		return opts
	end,
}
