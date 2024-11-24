return {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
        -- Disable netrw.
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
        require("nvim-tree").setup({
            view = {
                relativenumber = true,
            },
        })

        local keymap = vim.keymap
        local opts = { noremap = true, silent = true }

        opts.desc = "Open file explorer"
        keymap.set("n", "<leader>ee", "<cmd>NvimTreeFocus<cr>", opts)

        opts.desc = "Close file explorer"
        keymap.set("n", "<leader>eq", "<cmd>NvimTreeClose<cr>", opts)

        opts.desc = "Open file explorer at current buffer"
        keymap.set("n", "<leader>eb", "<cmd>NvimTreeFindFile<cr>", opts)

        opts.desc = "Refresh file explorer"
        keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<cr>", opts)

        opts.desc = "Collapse file explorer"
        keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<cr>", opts)
    end,
}
