vim.g.mapleader = ","
vim.g.maplocalleader = ","

if vim.uv.os_uname().sysname == "Windows_NT" then
    vim.g.sqlite_clib_path = "C:\\Users\\dobin\\Appdata\\local\\nvim\\sqlite3.dll"
end

vim.g.rustaceanvim = {
    server = {
        cmd = function()
            local mason_registry = require("mason-registry")
            local ra_binary = mason_registry.is_installed("rust-analyzer")
                -- This may need to be tweaked, depending on the operating system.
                and mason_registry.get_package("rust-analyzer"):get_install_path() .. "/rust-analyzer"
                or "rust-analyzer"
            return { ra_binary } -- You can add args to the list, such as '--log-file'
        end,
    },
}

vim.g.borderStyle = "rounded"

-- should be a string, either "cmp" or "blink"
vim.g.completor = "blink"
