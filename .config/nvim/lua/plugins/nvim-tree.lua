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

        vim.keymap.set("n", "<leader>ee", "<cmd>NvimTreeFocus<cr>")
        vim.keymap.set("n", "<leader>eq", "<cmd>NvimTreeClose<cr>")
        vim.keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFile<cr>")
        vim.keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<cr>")
        vim.keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<cr>")
    end,
}
