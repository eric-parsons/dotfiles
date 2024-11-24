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
