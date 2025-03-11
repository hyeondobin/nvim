return {
	"mfussenegger/nvim-lint",
	config = function()
		require("lint").linters_by_ft = {
			lua = { "luacheck" },
		}
		local lint = require("lint")
		local linters = require("lint").linters
		---@diagnostic disable-next-line: param-type-mismatch
		linters.luacheck.args = vim.list_extend(vim.deepcopy(linters.luacheck.args), {
			"--config=" .. vim.env.HOME .. "/.config/.luacheckrc",
		})
		vim.api.nvim_create_user_command("LinterInfo", function()
			local runningLinters = table.concat(lint.get_running(), "\n")
			vim.notify(runningLinters, vim.log.levels.INFO, { title = "nvim-lint" })
		end, {})
	end,
}
