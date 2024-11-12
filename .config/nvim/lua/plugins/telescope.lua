return {
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
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
                            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
                            ["<C-j>"] = actions.move_selection_next, -- move to next result
                        },
                    },
                },
            })

            telescope.load_extension("fzf")

            -- set keymaps
            local keymap = vim.keymap -- for conciseness

            keymap.set("n", "<leader><space>", builtin.find_files, { desc = "Fuzzy find files in cwd" })
            keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Fuzzy find recent files" })
            keymap.set("n", "<leader>fs", builtin.live_grep, { desc = "Fuzzy find string in cwd" })
            keymap.set("n", "<leader>b", builtin.buffers, { desc = "List buffers" })
            keymap.set("n", "<leader>/", function()
                builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
                    winblend = 10,
                    previewer = false,
                })
            end, { desc = "[/] Fuzzily search in current buffer" })
            keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Fuzzy find help" })
            keymap.set("n", "<leader>fp", builtin.resume, { desc = "Resume previous find" })
        end
    },
}
