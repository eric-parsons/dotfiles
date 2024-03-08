
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.cursorline = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.hlsearch = false

-- Disable mouse mode
vim.opt.mouse = ""

-- Sync clipboard between OS and Neovim.
vim.opt.clipboard = "unnamedplus"

vim.opt.breakindent = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Set completeopt to have a better completion experience
vim.opt.completeopt = "menuone,noselect"

vim.opt.termguicolors = true

-- Folding
vim.opt.foldnestmax = 3

-- Keep the cursor in the center of the screen when possible.
-- The difference between these two approaches is that the auto command will
-- do this even at the end of the file, whereas the scrolloff method won't.
-- vim.opt.scrolloff = 999
vim.cmd([[
augroup KeepCentered
autocmd!
autocmd CursorMoved * normal! zz
augroup END
]])

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
})

