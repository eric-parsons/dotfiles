-- NOTE: See also the config for LSP, file tree, completion, and Telescope,
-- which also add keymaps.

-- NOTE: I use a programmable keyboard that lets me use actual arrow keys, Pg
-- Up/Down, etc. without moving my hand from home row. I also use Colemak
-- rather than QWERTY layout. Thus these bindings are biased in favor of using
-- navigation keys over HJKL. There are still some bindings for the latter in
-- case I am stuck without my keyboard but they are there more as an
-- afterthought. If you ase using HJKL, you will likely need to adjust some of
-- these.

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- ((( Leader Key )))

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable space key since we are using it as the leader.
keymap.set({ "n", "v" }, "<space>", "<Nop>", opts)

-- ((( General )))

-- Make the Home key behave like "^", i.e. move to the first nonblank character
-- on a line. The default behavior is the equivalent of "0" where it ignores
-- indentation and moves to the very beginning of the line, which is less
-- useful in the vast majority of cases.
keymap.set({ "n", "v" }, "<home>", "^", opts)

-- Make page up/down work like Ctrl+U and Ctrl+D instead of Ctrl+B and Ctrl+F.
-- The former work better with the "always centered" strategy (see
-- options.lua).
keymap.set({ "n", "v" }, "<pageup>", "<c-u>", opts)
keymap.set({ "n", "v" }, "<pagedown>", "<c-d>", opts)

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

opts.desc = "Write all buffers and quit Neovim"
keymap.set("n", "<leader>Q", "<cmd>xa<cr>", opts)

-- Move highlighted lines up/down.
opts.desc = "Move selection down one line"
keymap.set("v", "<s-down>", ":m '>+1<cr>gv=gv", opts)
keymap.set("v", "J", ":m '>+1<cr>gv=gv", opts)

opts.desc = "Move selection up one line"
keymap.set("v", "K", ":m '<-2<cr>gv=gv", opts)
keymap.set("v", "<s-up>", ":m '<-2<cr>gv=gv", opts)

-- Allow inserting blank line before/after without leaving normal mode or
-- moving the cursor.
opts.desc = "Add blank line below"
keymap.set("n", "<leader>o", [[:<C-u>call append(line("."),   repeat([""], v:count1))<cr>]], opts)
opts.desc = "Add blank line above"
keymap.set("n", "<leader>O", [[:<C-u>call append(line(".")-1, repeat([""], v:count1))<cr>]], opts)

-- Whole file search and replace. These allow you to simply type "old/new"
-- after. The "\v" part is "very magic" mode, which gives special symbols like
-- "|" , "{", etc. their normal regex syntax meaning rather than being
-- literals. See :h magic.
opts.desc = "Replace all in current buffer"
keymap.set("n", "<leader>ra", ":%s/\\v/g<left><left>", opts)
opts.desc = "Replace with confirmation in current buffer"
keymap.set("n", "<leader>rc", ":%s/\\v/gc<left><left>", opts)

-- Wrap comments. NOTE: The first form does not work (nothing happens), while
-- the second one does. Huh?
opts.desc = "Wrap comment block."
-- keymap.set("n", "<leader>c", "gwgc", opts)
keymap.set("n", "<leader>c", function()
    vim.cmd.normal("gwgc")
end, opts)

-- Remap for dealing with word wrap. Moving up and down will now move within a
-- wrapped line that spans several visible lines, rather that jumping out of it
-- to the next/previous actual line.
keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap.set("n", "<up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap.set("n", "<down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

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

opts.desc = "Go to top left window"
keymap.set("n", "<s-home>", "<c-w>t", opts)

opts.desc = "Go to bottom right window"
keymap.set("n", "<s-end>", "<c-w>b", opts)

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

-- Closes any open window whose current buffer matches a substring.
local closeWindowWithBufferMatching = function(substring)
    for _, winId in ipairs(vim.api.nvim_list_wins()) do
        local bufName = vim.fn.bufname(vim.fn.winbufnr(winId))
        if string.find(bufName, substring, 0, true) then
            vim.api.nvim_win_close(winId, true)
        end
    end
end

-- S(y)nc files. These commands open a matching file associated with the
-- current buffer in a new vertical split beside it. A matching file has the
-- same root path as the current buffer, but with a different extension. Here I
-- am using it to open a CSS file matching e.g. a .html/.jsx/.tsx file, or a
-- matching unit test file. You could also use this for .c + .h files, or an
-- aspx file and its "codebehind" file, and so on.
opts.desc = "Open matching CSS file"
keymap.set("n", "<leader>yc", function()
    closeWindowWithBufferMatching(".css")
    closeWindowWithBufferMatching(".test.")
    vim.cmd("vs %:r.css")
end, opts)

opts.desc = "Open matching test file"
keymap.set("n", "<leader>yt", function()
    closeWindowWithBufferMatching(".css")
    closeWindowWithBufferMatching(".test.")
    vim.cmd("vs %:r.test.%:e")
end, opts)

-- ((( Folds )))

opts.desc = "Enable folds (indent)"
keymap.set("n", "<leader>zi", function()
    vim.o.foldmethod = "indent"
    vim.cmd.normal("zz")
end, opts)

opts.desc = "Remove folds"
keymap.set("n", "<leader>zx", function()
    vim.o.foldmethod = "manual"
    vim.cmd.normal("zE")
    vim.cmd.normal("zz")
end, opts)

-- Recenter after opening/closing folds. Not every command is covered here,
-- just commonly used ones.
local foldCommands = { "zo", "zO", "zc", "zC", "za", "zA", "zX", "zM" }
for _, fc in ipairs(foldCommands) do
    keymap.set("n", fc, fc .. "zz")
end
