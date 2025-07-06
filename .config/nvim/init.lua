-- https://learnxinyminutes.com/docs/lua/
-- https://neovim.io/doc/user/lua-guide.html
-- also search through `:help lua-guide`

require("options")
require("keymap")

-- Install `lazy.nvim` plugin manager if not installed.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
    change_detection = {
        notify = false,
    },
})
