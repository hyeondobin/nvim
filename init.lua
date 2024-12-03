require("config.globals")

require("config.lazy")
require("config.options")
require("config.autocmd")
require("config.keymaps")
if vim.g.neovide then
	require("neovide")
end
