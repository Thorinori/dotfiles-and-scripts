return {
    {
        'oil.nvim',
        dependencies = {"nvim-tree/nvim-web-devicons"},
        opts = {
            mappings = {
                ["<Leader>O"] = {"<Cmd>Oil<CR>", desc = "Open folder in Oil"},
            },
        },
    }
}
