return {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            -- Replace "ys", "yss", etc. with just "s", "ss", etc. The default
            -- is a bit odd since y is normally used for yanking, and typing an
            -- extra character is a bit clunky. This overwrites the built-in
            -- "s" and "S" operations, but those are just synonyms for "cl" and
            -- "cc", respectively.
            keymaps = {
                normal = "s",
                normal_cur = "ss",
                normal_line = "S",
                normal_cur_line = "SS",
            }
        })
    end,
}

