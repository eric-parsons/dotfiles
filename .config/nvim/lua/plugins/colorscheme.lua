return {
    {
        "eric-parsons/mid-century.nvim",
        dependencies = {
            "rktjmp/lush.nvim",
        },
        config = function()
            vim.cmd.colorscheme("mid-century")
        end,
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
