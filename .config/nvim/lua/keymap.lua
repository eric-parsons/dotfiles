vim.g.mapleader = " "

vim.keymap.set("i", "kj", "<Esc>")
vim.keymap.set("i", "jk", "<Esc>")

-- Move highlighted lines up/down.
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- This apparently turns on line numbers in netrw, but it might also summon a
-- demon so be careful!
vim.cmd([[let g:netrw_bufsettings = "noma nomod nu nobl nowrap ro"]])

-- Keymaps for better default experience.
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap.
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Make it easier to move around windows. The key <c-l> has existing
-- functionality, but is a bit obscure (redraws and clears search
-- highlights).
vim.keymap.set("n", "<c-h>", "<c-w>h")
vim.keymap.set("n", "<c-j>", "<c-w>j")
vim.keymap.set("n", "<c-k>", "<c-w>k")
vim.keymap.set("n", "<c-l>", "<c-w>l")

-- Diagnostic keymaps.
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set(
    "n",
    "<leader>e",
    vim.diagnostic.open_float,
    { desc = "Open floating diagnostic message" }
)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Allow inserting blank line before/after without leaving normal mode or
-- moving the cursor.
vim.keymap.set("n", "<leader>o", [[:<C-u>call append(line("."),   repeat([""], v:count1))<CR>]])
vim.keymap.set("n", "<leader>O", [[:<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>]])
