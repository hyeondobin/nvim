return {
    {
        "echasnovski/mini.files",
        version = false,
        event = { "BufReadPre", "BufNewFile" },
    },
    {
        "echasnovski/mini.pairs",
        version = false,
        event = { "InsertEnter" },
        config = true,
    },
    {
        "echasnovski/mini.surround",
        version = false,
        config = true,
        event = { "InsertEnter" },
    },
}
