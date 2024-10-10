return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				-- enabled = false,
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			},
		},
		cmd = "Telescope",
		config = function()
			local actions = require("telescope.actions")
			local function flash(prompt_bufnr)
				require("flash").jump({
					pattern = "^",
					label = { after = { 0, 0 } },
					search = {
						mode = "search",
						exclude = {
							function(win)
								return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
							end,
						},
					},
					action = function(match)
						local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
						picker:set_selection(match.pos[1] - 1)
					end,
				})
			end

			require("telescope").setup({
				defaults = {
					mappings = {
						i = {
							["<C-p>"] = actions.move_selection_previous,
							["<C-n>"] = actions.move_selection_next,
							["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
							["<C-x>"] = actions.delete_buffer,
							["<C-s>"] = flash,
						},
						n = {
							s = flash,
						},
					},
					file_ignore_patterns = {
						"node_modules",
						"yarn.lock",
						".git",
						".sl",
						"_build",
						".next",
					},
					hidden = true,
					layout_config = {
						vertical = { width = 0.8 },
					},
				},
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
				},
			})

			-- Enable telescope fzf native, if installed
			pcall(require("telescope").load_extension, "fzf")
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
