return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            -- Fuzzy Finder Algorithm which requires local dependencies to be built.
            -- Only load if `make` is available. Make sure you have the system
            -- requirements installed.
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                cond = function()
                    return vim.fn.executable "make" == 1
                end,
            },
        },
        config = function()
            local telescope = require("telescope")
            local actions = require("telescope.actions")
            local builtin = require("telescope.builtin")

            telescope.setup({
                defaults = {
                    path_display = { "truncate " },
                    mappings = {
                        i = {
                            -- Avoids having to press Esc twice to exit a
                            -- Telescope window, at the expense of not being
                            -- able to switch to normal mode, which I never use
                            -- anyway.
                            ["<esc>"] = actions.close,
                            -- Handy when using normal QWERTY keyboard, but
                            -- arrow up/down and pg up/down work better on
                            -- custom keyboards.
                            ["<C-k>"] = actions.move_selection_previous,
                            ["<C-j>"] = actions.move_selection_next,
                        },
                    },
                },
            })

            telescope.load_extension("fzf")

            -- Set keymaps.
            local keymap = vim.keymap
            local opts = { noremap = true, silent = true }

            opts.desc = "Find files in cwd"
            keymap.set("n", "<leader><space>", builtin.find_files, opts)

            opts.desc = "Find recent files"
            keymap.set("n", "<leader>fr", builtin.oldfiles, opts)

            opts.desc = "Find string in cwd"
            keymap.set("n", "<leader>fs", builtin.live_grep, opts)

            opts.desc = "List buffers"
            keymap.set("n", "<leader>l", builtin.buffers, opts)

            opts.desc = "Fuzzy search in current buffer"
            keymap.set("n", "<leader>/", function()
                builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
                    winblend = 10,
                    previewer = false,
                })
            end, opts)

            opts.desc = "Find in help"
            keymap.set("n", "<leader>fh", builtin.help_tags, opts)

            opts.desc = "Resume previous search"
            keymap.set("n", "<leader>fp", builtin.resume, opts)
        end
    },
}
