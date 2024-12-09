return {
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = function()
            local toggleterm = require("toggleterm")
            local Terminal = require("toggleterm.terminal").Terminal
            local keymap = vim.keymap

            toggleterm.setup({
                open_mapping = "<c-\\>",
                direction = "vertical",
                size = 60,
                float_opts = {
                    border = "curved",
                },
            })

            function _G.set_terminal_keymaps()
                local opts = { buffer = 0 }
                -- These mirror the normal keymaps I use for moving around
                -- windows (see keymap.lua).
                keymap.set("t", "<s-left>", "<cmd>wincmd h<cr>", opts)
                keymap.set("t", "<s-down>", "<cmd>wincmd j<cr>", opts)
                keymap.set("t", "<s-up>", "<cmd>wincmd k<cr>", opts)
                keymap.set("t", "<s-right>", "<cmd>wincmd l<cr>", opts)
                keymap.set("t", "<s-home>", "<cmd>wincmd t<cr>", opts)
                keymap.set("t", "<s-end>", "<cmd>wincmd b<cr>", opts)
                keymap.set("t", "<c-w>", "<c-\\><c-n><c-w>", opts)
            end

            vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

            local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
            local scratch = Terminal:new({ hidden = true, direction = "float" })

            -- These shortcuts open a modal overlay terminal for performing
            -- some specific task and then exiting, as opposed to the normal
            -- toggle keymap which opens/closes a side panel, which I use for
            -- long-running processes like running tests or running a REPL
            -- tool.
            local opts = { noremap = true, silent = true }
            keymap.set("n", "<leader>tg", function()
                lazygit:toggle()
            end, opts)
            keymap.set("n", "<leader>ts", function()
                scratch:toggle()
            end, opts)
        end,
    },
}
