vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("config-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	desc = "Oil buffer Keymap",
	pattern = "oil",
	callback = function()
		vim.keymap.set("n", "<Esc>", require("oil").close, { desc = "Close oil" })
	end,
})
