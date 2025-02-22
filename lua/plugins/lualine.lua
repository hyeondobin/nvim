return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			-- source : https://www.reddit.com/r/neovim/comments/t48x5i/git_branch_aheadbehind_info_status_line_component/
			local Job = require("plenary.job")
			local gstatus
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
						"branch",
						function()
							return gstatus.ahead .. " " .. gstatus.behind .. ""
						end,
						"diff",
						"diagnostics",
					},
					lualine_c = {
						{ "filename", path = 1 },
						"selectioncount",
					},
					lualine_x = { "encoding", "filetype" },
					lualine_y = {
						{
							"macro",
							fmt = function()
								local reg = vim.fn.reg_recording()
								if reg ~= "" then
									return "Recording @" .. reg
								end
								return nil
							end,
							draw_emprty = false,
						},
						{
							"time",
							fmt = function()
								return os.date("%T")
							end,
						},
					},
				},
			})
		end,
	},
}
