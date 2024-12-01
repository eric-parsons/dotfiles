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
                    return vim.fn.executable("make") == 1
                end,
            },
        },
        config = function()
            local telescope = require("telescope")
            local actions = require("telescope.actions")
            local builtin = require("telescope.builtin")
            local themes = require("telescope.themes")

            telescope.setup({
                defaults = {
                    path_display = { "truncate " },
                    mappings = {
                        i = {
                            -- Handy when using normal QWERTY keyboard, but
                            -- arrow up/down and pg up/down work better on
                            -- custom keyboards.
                            ["<C-k>"] = actions.move_selection_previous,
                            ["<C-j>"] = actions.move_selection_next,
                            -- The default behaviour of Pg Up/Down in the file
                            -- window tends to produce a weird effect, causing
                            -- the list of files to jump around. Instead, make
                            -- them scroll the preview window.
                            ["<pageup>"] = actions.preview_scrolling_up,
                            ["<pagedown>"] = actions.preview_scrolling_down,
                        },
                    },
                },
                pickers = {
                    buffers = {
                        mappings = {
                            i = {
                                -- Since I use Pg Up/Down to scroll the preview
                                -- (see above), it's fine to override Ctrl-D to
                                -- something else.
                                ["<c-d>"] = actions.delete_buffer,
                            },
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
            keymap.set("n", "<leader>l", function()
                builtin.buffers(themes.get_dropdown({
                    previewer = false,
                }))
            end, opts)

            opts.desc = "Fuzzy search in current buffer"
            keymap.set("n", "<leader>/", function()
                builtin.current_buffer_fuzzy_find(themes.get_dropdown({
                    winblend = 10,
                    previewer = false,
                }))
            end, opts)

            opts.desc = "Find in help"
            keymap.set("n", "<leader>fh", builtin.help_tags, opts)

            opts.desc = "Resume previous search"
            keymap.set("n", "<leader>fp", builtin.resume, opts)
        end,
    },
}
