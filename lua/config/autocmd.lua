-- Highlight when yank.
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("config-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Set <Esc> f
vim.api.nvim_create_autocmd("FileType", {
	desc = "Oil buffer Keymap",
	pattern = "oil",
	callback = function()
		vim.keymap.set("n", "<Esc>", require("oil").close, { desc = "Close oil", buffer = true })
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	desc = "Markdown conceallevel",
	pattern = "md",
	callback = function()
		vim.bo.conceallevel = 2
	end,
})

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
	callback = function()
		vim.cmd([[Trouble qflist open]])
	end,
})

-- vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "TextChanged", "InsertLeave" }, {
--  group = vim.api.nvim_create_augroup("nvim_lint", { clear = true }),
--  callback = function(e)
--		local lint = require("lint")
--		if e.buf and vim.bo[e.buf].filetype == "markdown" and vim.api.nvim_win_get_config(0).zindex then
--			return
--		end
--
--		vim.defer_fn(function()
--			lint.try_lint(nil, { ignore_errors = true })
--		end, 1)
--	end,
-- })
