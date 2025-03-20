local obsidianDir = ""
local JLPath = ""
if vim.uv.os_uname().sysname == "Windows_NT" then
	obsidianDir = "F:/Users/Dobin/Obsidian"
	JLPath = "F:/Users/Dobin/Obsidian/JL"
else
	obsidianDir = vim.fn.expand("~") .. "/Obsidian"
	JLPath = vim.fn.expand("~") .. "/Obsidian/JL"
end
return {
	"epwalsh/obsidian.nvim",
	version = "*",
	event = {
		"BufReadPre " .. JLPath .. "/*.md",
		"BufNewFile " .. JLPath .. "/*.md",
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		workspaces = {
			{ name = "JL", path = JLPath },
		},
	},
}
