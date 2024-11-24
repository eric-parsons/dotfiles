return {
    {
        -- Highlight, edit, and navigate code
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            lazy = true,
        },
        build = ":TSUpdate",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            ensure_installed = {
                "bash",
                "c",
                "cpp",
                "css",
                "haskell",
                "html",
                "javascript",
                "jsdoc",
                "json",
                "jsonc",
                "lua",
                "markdown",
                "regex",
                "toml",
                "tsx",
                "typescript",
                "vimdoc",
                "vim",
            },
            auto_install = false,
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<CR>",
                    scope_incremental = false,
                    node_incremental = "<CR>",
                    node_decremental = "<BS>",
                },
            },
            textobjects = {
                select = {
                    enable = true,

                    -- Automatically jump forward to textobj, similar to targets.vim
                    lookahead = true,
                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
                        ["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
                        ["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
                        ["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },

                        -- Works for JS/TS/JSON files (custom capture I created
                        -- in after/queries/ecma/textobjects.scm)
                        ["a:"] = { query = "@property.outer", desc = "Select outer part of an object property" },
                        ["i:"] = { query = "@property.inner", desc = "Select inner part of an object property" },
                        ["l:"] = { query = "@property.lhs", desc = "Select left part of an object property" },
                        ["r:"] = { query = "@property.rhs", desc = "Select right part of an object property" },

                        ["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
                        ["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },

                        ["af"] = { query = "@call.outer", desc = "Select outer part of a function call" },
                        ["if"] = { query = "@call.inner", desc = "Select inner part of a function call" },

                        ["am"] = { query = "@function.outer", desc = "Select outer part of a method/function definition" },
                        ["im"] = { query = "@function.inner", desc = "Select inner part of a method/function definition" },

                        ["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
                        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                        ["]f"] = "@call.outer",
                        ["[m"] = "@function.outer",
                        ["]t"] = "@class.outer",
                        ["]:"] = "@property.outer",
                    },
                    goto_next_end = {
                        ["]F"] = "@call.outer",
                        ["[M"] = "@function.outer",
                        ["]T"] = "@class.outer",
                    },
                    goto_previous_start = {
                        ["[f"] = "@call.outer",
                        ["[m"] = "@function.outer",
                        ["[t"] = "@class.outer",
                        ["[:"] = "@property.outer",
                    },
                    goto_previous_end = {
                        ["[F"] = "@call.outer",
                        ["[M"] = "@function.outer",
                        ["[T"] = "@class.outer",
                    },
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ["<leader>xa"] = "@parameter.inner", -- swap parameters/argument with next
                        ["<leader>x:"] = "@property.outer", -- swap object property with next
                        ["<leader>xm"] = "@function.outer", -- swap function with next
                    },
                    swap_previous = {
                        ["<leader>Xa"] = "@parameter.inner", -- swap parameters/argument with prev
                        ["<leader>X:"] = "@property.outer", -- swap object property with prev
                        ["<leader>Xm"] = "@function.outer", -- swap function with previous
                    },
                },
            },
        },
        config = function (_, opts)
            require("nvim-treesitter.configs").setup(opts)
            local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

            -- Make TS text objects repeatable with the usual shortcuts.
            vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
            vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

            -- Necessary to avoid losing repeatabilty for built in motions.
            vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
            vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
            vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
            vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
        end,
    },
}
