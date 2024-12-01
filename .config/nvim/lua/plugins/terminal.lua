return {
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = function()
            local toggleterm = require("toggleterm")
            local Terminal = require("toggleterm.terminal").Terminal

            toggleterm.setup({
                open_mapping = "<c-\\>",
                direction = "vertical",
                size = 60,
                float_opts = {
                    border = "curved"
                }
            })

            function _G.set_terminal_keymaps()
                local opts = { buffer = 0 }
                vim.keymap.set("t", "<s-left>", "<cmd>wincmd h<cr>", opts)
                vim.keymap.set("t", "<s-down>", "<cmd>wincmd j<cr>", opts)
                vim.keymap.set("t", "<s-up>", "<cmd>wincmd k<cr>", opts)
                vim.keymap.set("t", "<s-right>", "<cmd>wincmd l<cr>", opts)
                vim.keymap.set("t", "<c-w>", "<c-\\><c-n><c-w>", opts)
            end

            vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

            local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
            local scratch = Terminal:new({ hidden = true, direction = "float" })

            vim.keymap.set("n", "<leader>tg", function()
                lazygit:toggle()
            end, { noremap = true, silent = true })
            vim.keymap.set("n", "<leader>ts", function()
                scratch:toggle()
            end, { noremap = true, silent = true })
        end,
    },
}
