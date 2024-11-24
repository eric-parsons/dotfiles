-- NOTE: See also the config for LSP, file tree, and Telescope which also add
-- keymaps.

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- ((( Leader Key )))

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable space key since we are using it as the leader.
keymap.set({ "n", "v" }, "<space>", "<Nop>", opts)

-- ((( General )))

-- Make common commands a bit faster. Saving one or two characters doesn't seem
-- like a big deal, but these are used a LOT. Also, about 10% of the time that
-- I try to quickly type e.g. ":w", it comes out as ":W" because the shift key
-- wasn't released quickly enough after typing ":". This avoids timing issues.
opts.desc = "Write current buffer"
keymap.set("n", "<leader>w", "<cmd>w<cr>", opts)

opts.desc = "Write all buffers"
keymap.set("n", "<leader>W", "<cmd>wa<cr>", opts)

opts.desc = "Close window"
keymap.set("n", "<leader>q", "<cmd>q<cr>", opts)

opts.desc = "Write all bufeers and close all windows"
keymap.set("n", "<leader>Q", "<cmd>wqa<cr>", opts)

-- Move highlighted lines up/down.
opts.desc = "Move selection down one line"
keymap.set("v", "<s-down>", ":m '>+1<cr>gv=gv", opts)
keymap.set("v", "J", ":m '>+1<cr>gv=gv", opts)

opts.desc = "Move selection up one line"
keymap.set("v", "K", ":m '<-2<cr>gv=gv", opts)
keymap.set("v", "<s-up>", ":m '<-2<cr>gv=gv", opts)

-- When deleting a single character, don't overwrite whatever was last yanked.
opts.desc = "Delete character"
keymap.set("n", "x", '"_x')

-- Allow inserting blank line before/after without leaving normal mode or
-- moving the cursor.
opts.desc = "Add blank line below"
keymap.set("n", "<leader>o", [[:<C-u>call append(line("."),   repeat([""], v:count1))<cr>]], opts)

opts.desc = "Add blank line above"
keymap.set("n", "<leader>O", [[:<C-u>call append(line(".")-1, repeat([""], v:count1))<cr>]], opts)

-- Whole file search and replace. These allow you to simply type "old/new"
-- after.
opts.desc = "Replace all in current buffer"
keymap.set("n", "<leader>ra", ":%s//g<left><left>", opts)
opts.desc = "Replace with confirmation in current buffer"
keymap.set("n", "<leader>rc", ":%s//gc<left><left>", opts)

-- Remap for dealing with word wrap.
keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- ((( Windows )))

-- Make it easier to move around windows.
opts.desc = "Go one window left"
keymap.set("n", "<s-left>", "<c-w>h", opts)
keymap.set("n", "<c-h>", "<c-w>h", opts)

opts.desc = "Go one window down"
keymap.set("n", "<s-down>", "<c-w>j", opts)
keymap.set("n", "<c-j>", "<c-w>j", opts)

opts.desc = "Go one window up"
keymap.set("n", "<s-up>", "<c-w>k", opts)
keymap.set("n", "<c-k>", "<c-w>k", opts)

opts.desc = "Go one window right"
keymap.set("n", "<s-right>", "<c-w>l", opts)
keymap.set("n", "<c-l>", "<c-w>l", opts)

-- ((( Buffers )))

--NOTE: <leader>l is mapped in the Telescope settings to view the buffer list.

opts.desc = "Next buffer"
keymap.set("n", "<tab>", "<cmd>bn<cr>", opts)

opts.desc = "Previous buffer"
keymap.set("n", "<s-tab>", "<cmd>bp<cr>", opts)

-- Close current buffer without closing its window/tab. Not 100% perfect, but
-- still better than normal ":bd".
opts.desc = "Close current buffer"
keymap.set("n", "<leader>bd", "<cmd>bp|bd#<cr>", opts)

-- ((( Folds )))

opts.desc = "Enable folds (indent)"
keymap.set("n", "<leader>zi", function()
    vim.o.foldmethod = "indent"
end, opts)

opts.desc = "Remove folds"
keymap.set("n", "<leader>zq", function()
    vim.o.foldmethod = "manual"
    vim.cmd.normal("zE")
end, opts)
