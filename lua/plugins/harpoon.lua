return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	event = { "BufReadPost", "BufWritePost", "BufNewFile" },
	config = function()
		local harpoon = require("harpoon")

		harpoon:setup()

        -- stylua: ignore start
		vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end,{desc ="Harpoon add file"})
		vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
		vim.keymap.set("n", "<C-S-h>", function() harpoon:list():select(1) end)
		vim.keymap.set("n", "<C-S-t>", function() harpoon:list():select(2) end)
		vim.keymap.set("n", "<C-S-n>", function() harpoon:list():select(3) end)
		vim.keymap.set("n", "<C-S-s>", function() harpoon:list():select(4) end)

        vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
        vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
		-- stylua: ignore end
	end,
}
