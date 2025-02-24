-- highlighting of filepaths and error codes
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "noice", "snacks_notif" },
	callback = function(ctx)
		vim.defer_fn(function()
			if not vim.api.nvim_buf_is_valid(ctx.buf) then
				return
			end
			vim.api.nvim_buf_call(ctx.buf, function()
				vim.fn.matchadd("WarningMsg", [[[^/]\+\.lua:\d\+\ze:]])
				vim.fn.matchadd("WarningMsg", [[E\d\+]])
			end)
		end, 1)
	end,
})

return {
	"folke/noice.nvim",
	enabled = true,
	event = "BufReadPre",
	keys = {
		{ "<Esc>", vim.cmd.NoiceDismiss, desc = "Clear notifications" },
	},
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	opts = {
		routes = {
			{
				filter = {
					event = "msg_show",
					any = {
						{ find = "%d+L, %d+B" },
						{ find = "; after #%d+" },
						{ find = "; before #%d+" },
						{ find = "written" },
					},
				},
				view = "notify",
			},
		},
		presets = {
			bottom_search = false,
			command_palette = true,
			long_message_to_split = true,
			lsp_doc_border = false,
		},
		views = {
			cmdline_popup = {
				border = { style = vim.g.borderStyle },
			},
			mini = {
				timeout = 3000,
				zindex = 45,
				format = { "{title} ", "{message}" },
			},
			split = {
				enter = true,
				size = "70%",
				win_options = { scrolloff = 6 },
				close = { keys = { "q", "<C-c>", "<Esc>" } },
			},
			popupmenu = {
				border = { style = vim.g.borderStyle },
				size = {
					width = "80%",
					height = "50%",
				},
			},
		},
		commands = {
			-- history = {
			-- 	filter_opts = { reverse = true },
			-- 	opts = {
			-- 		format = {
			-- 			"{event}",
			-- 			{ "{kind}", before = { ".", hl_group = "NoiceFormatKind" } },
			-- 			" ",
			-- 			"{title} ",
			-- 			"{cmdline} ",
			-- 			"{message}",
			-- 		},
			-- 	},
			-- 	filter = {
			-- 		["not"] = {
			-- 			any = {
			-- 				{ find = "^/" },
			-- 				{
			-- 					event = "notify",
			-- 					cond = function(msg)
			-- 						return msg.level and msg.level == "trace"
			-- 					end,
			-- 				},
			-- 			},
			-- 		},
			-- 	},
			-- },
		},
		lsp = {
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
			},
			view = "mini",
		},
		popupmenu = {
			enabled = true,
			backend = "nui",
		},
	},
	config = function(_, opts)
		if vim.o.filetype == "lazy" then
			vim.cmd([[messages clear]])
		end
		require("noice").setup(opts)
	end,
}
