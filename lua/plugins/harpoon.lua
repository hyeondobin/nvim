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
		vim.keymap.set("n", "<M-n>", function() harpoon:list():select(1) end)
		vim.keymap.set("n", "<M-e>", function() harpoon:list():select(2) end)
		vim.keymap.set("n", "<M-i>", function() harpoon:list():select(3) end)
		vim.keymap.set("n", "<M-o>", function() harpoon:list():select(4) end)

        vim.keymap.set("n", "<M-S-P>", function() harpoon:list():prev() end)
        vim.keymap.set("n", "<M-S-N>", function() harpoon:list():next() end)
		-- stylua: ignore end
	end,
}
