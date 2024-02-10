local function set_ime(args)
	if args.event:match("Enter$") then
		vim.g.neovide_input_ime = true
	else
		vim.g.neovide_input_ime = false
	end
end
local ime_input = vim.api.nvim_create_augroup("ime_input", { clear = true })

vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
	group = ime_input,
	pattern = "*",
	callback = set_ime,
})

vim.api.nvim_create_autocmd({ "CmdlineEnter", "CmdlineLeave" }, {
	group = ime_input,
	pattern = "[/==?]",
	callback = set_ime,
})

-- cursor trail
vim.g.neovide_cursor_animation_length = 0.05
vim.g.neovide_cursor_trail_size = 0.8

-- cursor effect
vim.g.neovide_cursor_vfx_mode = "railgun"
vim.g.neovide_cursor_animate_in_insert_mode = true
vim.g.neovide_cursor_vfx_particle_lifetime = 3
vim.g.neovide_cursor_vfx_particle_density = 20
vim.g.neovide_cursor_vfx_particle_speed = 1
vim.g.neovide_cursor_vfx_particle_phase = 10
vim.g.neovide_cursor_vfx_particle_curl = 50
vim.g.neovide_cursor_unfocused_outline_width = 0.5

-- color management
vim.g.neovide_transparency = 0.5

-- padding
vim.g.neovide_padding_top = 30

-- scroll animation
vim.g.neovide_scroll_animation_length = 0.7
vim.g.neovide_scroll_animation_far_lines = 3

-- mouse
vim.g.neovide_hide_mouse_when_typing = true

vim.g.neovide_theme = "auto"
