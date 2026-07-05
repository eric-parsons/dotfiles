-- Indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Open new splits in a sane direction.
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Show relative line numbers except for the current line which is absolute.
vim.opt.number = true
vim.opt.relativenumber = true

-- Disable search highlights.
vim.opt.hlsearch = false

-- This apparently turns on line numbers in netrw, but it might also summon a
-- demon so be careful!
vim.cmd([[let g:netrw_bufsettings = "noma nomod nu nobl nowrap ro"]])

-- Disable mouse mode.
vim.opt.mouse = ""

-- Sync clipboard between OS and Neovim.
vim.opt.clipboard = "unnamedplus"

-- Indent wrapped text the same as the start of the line.
vim.opt.breakindent = true

-- Case-insensitive searching UNLESS \C or capital in search.
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default (used by LSP).
vim.wo.signcolumn = "yes"

-- Set completeopt to have a better completion experience.
vim.opt.completeopt = "menuone,noselect"

-- Folding
vim.opt.foldnestmax = 3
vim.opt.foldcolumn = "auto"

-- Keep the cursor vertically centered within the screen when possible (i.e.
-- for all but the first half screen of text in the buffer).
vim.api.nvim_create_autocmd("CursorMoved", {
    callback = function()
        vim.cmd.normal("zz")
    end,
})
-- Recenter after opening/closing folds. Not every command is covered here,
-- just commonly used ones.
local foldCommands = { "zo", "zO", "zc", "zC", "za", "zA", "zX", "zM" }
for _, fc in ipairs(foldCommands) do
    vim.keymap.set("n", fc, fc .. "zz")
end

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})
