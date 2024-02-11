return {
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = function()
            local powershell_options = {
                shell = vim.fn.executable("pwsh") and "pwsh" or "powershell",
                shellcmdflag =
                "-Nologo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
                shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
                shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
                shellquote = "",
                shellxquote = "",
            }

            if vim.loop.os_uname().sysname == "Windows_NT" then
                for option, value in pairs(powershell_options) do
                    vim.opt[option] = value
                end
            end

            require("toggleterm").setup({})
        end,
    },
}
