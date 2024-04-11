return {
    {
        'oil.nvim',
        dependencies = {"nvim-tree/nvim-web-devicons"},
        lazy = false,
        opts= {
            default_file_explorer = true,
            mappings = {
                ["<Leader>O"] = {"<Cmd>Oil<CR>", desc = "Open folder in Oil"},
            },
        },
    }
}
