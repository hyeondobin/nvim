return {
    {
        "nvim-telescope/telescope.nvim",
        lazy = false,
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                -- enabled = false,
                build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
            },
        },
        config = function()
            local actions = require("telescope.actions")

            require("telescope").setup({
                defaults = {
                    mappings = {
                        i = {
                            ["<C-p>"] = actions.move_selection_previous,
                            ["<C-n>"] = actions.move_selection_next,
                            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                            ["<C-x>"] = actions.delete_buffer,
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
                },
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    }
                }
            })

            require("telescope").load_extension('fzf')

            -- Enable telescope fzf native, if installed
            pcall(require("telescope").load_extension, "fzf")
        end,
    },
    {
        'nvim-telescope/telescope-ui-select.nvim',
        lazy = false,
        config = function()
            require('telescope').setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {}
                    }
                }
            })
            require('telescope').load_extension('ui-select')
        end,
    },
}
