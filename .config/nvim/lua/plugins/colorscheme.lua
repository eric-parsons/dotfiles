return {
    {
        "eric-parsons/cybercrime.nvim",
        priority = 1000,
        dependencies = {
            "rktjmp/lush.nvim",
        },
        config = function()
            vim.cmd.colorscheme("cybercrime")
            -- Make background transparent.
            --
            -- TODO: Figure out how to expose a `transparent = true` setting in
            -- the color scheme itself, like some other popular schemes. Also,
            -- it would be nice to have a keymap for turning transparency
            -- on/off.
            vim.cmd([[
                highlight Normal guibg=none
                highlight NonText guibg=none
                highlight Normal ctermbg=none
                highlight NonText ctermbg=none
            ]])
        end,
    },
    -- {
    --     "eric-parsons/arctic.nvim",
    --     dependencies = {
    --         "rktjmp/lush.nvim",
    --     },
    -- },
    -- {
    --     "eric-parsons/mid-century.nvim",
    --     dependencies = {
    --         "rktjmp/lush.nvim",
    --     },
    -- },
    -- {
    --     "ellisonleao/gruvbox.nvim",
    --     opts = {
    --         italic = {
    --             strings = false,
    --         },
    --     },
    -- },
    -- {
    --     "catppuccin/nvim",
    --     name = "catppuccin",
    -- },
}
