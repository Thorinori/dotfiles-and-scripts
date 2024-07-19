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
            view_options = {
		        show_hidden = true,
		        is_always_hidden = function(name, _) return name == '..' or name == '.git' end,
		        natural_order = true,
	        },
            win_options = {
                signcolumn = "yes:2",
            },
	        experimental_watch_for_changes = true,
        },
    }
}
