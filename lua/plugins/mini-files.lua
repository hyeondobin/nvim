return {
    'echasnovski/mini.files',
    version = false,
    keys = {
        { "<leader>e", function ()
            require('mini.files').open()
        end, "Mini.Files"
        },
        {
            "<leader>dc", function ()
                require('mini.files').open("C:/")
            end, "Mini C drive"
        },
        {
            "<leader>df", function ()
                require('mini.files').open("F:/")
            end, "Mini C drive"
        },
    },
}
