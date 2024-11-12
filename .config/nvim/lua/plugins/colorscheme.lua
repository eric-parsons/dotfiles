return {
    {
        "eric-parsons/arctic.nvim",
        priority = 1000,
        dependencies = {
            "rktjmp/lush.nvim",
        },
        config = function()
            vim.cmd.colorscheme("arctic")
        end,
    },
    {
        "eric-parsons/mid-century.nvim",
        priority = 1000,
        dependencies = {
            "rktjmp/lush.nvim",
        },
    },
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        opts = {
            italic = {
                strings = false,
            },
        },
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
    },
}
