return {
    {
        "Thorinori/harp-nvim",
        lazy = false,
        dependencies = {
            "AstroNvim/astrocore",
            opts = {
                mappings = {
                    n = {
                        ["<Leader>i"] = {function() require("harp").harp_get() end,desc = ":edit file in given register"},
                        ["<Leader>I"] = {function() require("harp").harp_set() end,desc = "Store current buffer path in given register"},
                        ["<Leader>x"] = {function() require("harp").harp_percwd_get() end,desc = ":edit file in given register, specific to this project"},
                        ["<Leader>X"] = {function() require("harp").harp_percwd_set() end,desc = "Store current buffer path in given register, specific to this project"},
                        ["'"] = {function() require("harp").harp_perbuffer_mark_get() end,desc = "Show local marks"},
                        ["m"] = {function() require("harp").harp_perbuffer_mark_set() end,desc = "Set local mark"},
                        ["<Leader>'"] = {function() require("harp").harp_global_mark_get() end,desc = "Show global marks"},
                        ["<Leader>m"] = {function() require("harp").harp_global_mark_set() end,desc = "Set global mark"},
                        ["<Leader>z"] = {function() require("harp").harp_cd_get() end,desc = "CD to path stored in register"},
                        ["<Leader>Z"] = {function() require("harp").harp_cd_set() end,desc = "Set CWD in register"},
                    }
                },
            },
        },
    }
}
