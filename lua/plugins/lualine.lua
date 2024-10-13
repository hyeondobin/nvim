return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = {},
		config = function()
			local Job = require("plenary.job")
			local function update_gstatus()
				Job:new({
					command = "git",
					args = { "rev-list", "--left-right", "--count", "HEAD...@{upstream}" },
					on_exit = function(job, _)
						local res = job:result()[1]
						if type(res) ~= "string" then
							gstatus = { ahead = 0, behind = 0 }
							return
						end
						local ok, ahead, behind = pcall(string.match, res, "(%d+)%s*(%d+)")
						if not ok then
							ahead, behind = 0, 0
						end
						gstatus = { ahead = ahead, behind = behind }
					end,
				}):start()
			end

			if _G.Gstatus_timer == nil then
				_G.Gstatus_timer = vim.uv.new_timer()
			else
				_G.Gstatus_timer:stop()
			end
			_G.Gstatus_timer:start(0, 2000, vim.schedule_wrap(update_gstatus))

			require("lualine").setup({
				options = {
					theme = "auto",
					globalstatus = true,
				},
				sections = {
					lualine_b = {
						function()
							return gstatus.ahead .. " " .. gstatus.behind .. ""
						end,
						"diff",
						"diagnostics",
					},
					lualine_c = {
						{ "filename", path = 1 },
					},
					lualine_x = {
						{ "filetype" },
					},
				},
			})
		end,
	},
}
