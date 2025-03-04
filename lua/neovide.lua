if vim.g.neovide then
	-- cursor trail
	vim.g.neovide_cursor_animation_length = 0.1
	vim.g.neovide_cursor_trail_size = 0.8

	-- cursor effect
	vim.g.neovide_cursor_animate_in_insert_mode = true
	vim.g.neovide_cursor_vfx_mode = "railgun"
	vim.g.neovide_cursor_vfx_particle_lifetime = 1
	vim.g.neovide_cursor_vfx_particle_density = 20
	vim.g.neovide_cursor_vfx_particle_speed = 1
	vim.g.neovide_cursor_vfx_particle_phase = 10
	vim.g.neovide_cursor_vfx_particle_curl = 50
	vim.g.neovide_cursor_unfocused_outline_width = 0.5
	vim.g.neovide_cursor_smooth_blink = true

	-- color management
	vim.g.neovide_transparency = 0.7
	vim.cmd.TransparentEnable()
	vim.g.neovide_normal_opacity = 1
	-- vim.cmd.TransparentDisable()
	-- vim.g.neovide_theme = "auto"

	-- padding
	vim.g.neovide_padding_top = 10
	vim.g.neovide_padding_left = 10
	vim.g.neovide_padding_right = 10

	-- scroll animation
	vim.g.neovide_scroll_animation_length = 0.3
	vim.g.neovide_scroll_animation_far_lines = 1

	-- mouse
	vim.g.neovide_hide_mouse_when_typing = true

	local opt = vim.opt
	opt.winblend = 0
	opt.pumblend = 0

	-- toggle transparency
	vim.keymap.set("n", "<leader>nt", function()
		local is_transparent = vim.g.neovide_transparency
		if is_transparent ~= 1 then
			vim.g.neovide_transparency = 1
			vim.cmd.TransparentDisable()
		else
			vim.g.neovide_transparency = 0.7
			-- vim.g.winblend = 30
			vim.cmd.TransparentEnable()
		end
	end, { desc = "Toggle transparency" })
	-- zoom in/out
	vim.keymap.set("n", "<C-+>", function()
		vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1
	end, { desc = "Neovide Zoom in" })
	vim.keymap.set("n", "<C-_>", function()
		vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1
	end, { desc = "Neovide Zoom out" })
	vim.keymap.set("n", "<C-=>", function()
		vim.g.neovide_scale_factor = 1
	end, { desc = "Neovide Reset Zoom" })
end
