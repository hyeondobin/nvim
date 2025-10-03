return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },
        dependencies = {
            "saghen/blink.cmp",
            "williamboman/mason-lspconfig.nvim",
            -- "hrsh7th/cmp-nvim-lsp",
            "folke/neoconf.nvim",
        },
        config = function()
            require("neoconf").setup({})

            vim.lsp.enable({ "lua_ls" })

            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "LSP actions",
                callback = function(event)
                    local opts = { buffer = event.buf }

                    -- stylua: ignore start
                    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
                    vim.keymap.set("n", "gd", function() Snacks.picker.lsp_definitions() end,
                        { buffer = event.buf, desc = "Get Definition" })
                    vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end,
                        { buffer = event.buf, desc = "Get Declaration" })
                    vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end,
                        { buffer = event.buf, desc = "Get implementations" })
                    vim.keymap.set("n", "go", function() vim.lsp.buf.type_definition() end,
                        { buffer = event.buf, desc = "Get type definition" })
                    vim.keymap.set("n", "gr", function() Snacks.picker.lsp_references() end,
                        { buffer = event.buf, desc = "Get References" })
                    vim.keymap.set("n", "gh", function() vim.lsp.buf.signature_help() end,
                        { buffer = event.buf, desc = "Get signature Help" })
                    vim.keymap.set("n", "<leader>cr", function() vim.lsp.buf.rename() end,
                        { buffer = event.buf, desc = "LSP Rename" })
                    vim.keymap.set({ "n", "x" }, "<leader>cf", function() vim.lsp.buf.format({ async = true }) end,
                        { buffer = event.buf, desc = "LSP Format" })
                    vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end,
                        { buffer = event.buf, desc = "LSP Code Action" })
                    -- stylua: ignore end
                end,
            })
        end,
    },
}
