return {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
    settings = {
        Lua = {
            runtime = {
                version = vim.api.nvim_get_runtime_file("", true),
            },
            diagnostics = {
                globals = { 'vim' },
            },
        }
    }
}
