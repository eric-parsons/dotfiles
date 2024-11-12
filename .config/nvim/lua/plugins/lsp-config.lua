return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local lspconfig = require("lspconfig")

        local keymap = vim.keymap -- for conciseness

        local opts = { noremap = true, silent = true }
        local on_attach = function(_, bufnr)
            opts.buffer = bufnr

            -- set keybinds
            opts.desc = "Go to references"
            keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)

            opts.desc = "Go to definition"
            keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

            opts.desc = "Go to type definition"
            keymap.set("n", "gy", "<cmd>Telescope lsp_type_definitions<CR>", opts)

            opts.desc = "Go to symbol"
            keymap.set("n", "<leader>s", "<cmd>Telescope lsp_document_symbols<CR>", opts)

            opts.desc = "Go to workspace symbol"
            keymap.set("n", "<leader>S", "<cmd>Telescope lsp_workspace_symbols<CR>", opts)

            opts.desc = "Show code actions"
            keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

            opts.desc = "Smart rename"
            keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

            opts.desc = "Show buffer diagnostics"
            keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

            opts.desc = "Show line diagnostics"
            keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

            opts.desc = "Go to previous diagnostic"
            keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

            opts.desc = "Go to next diagnostic"
            keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

            opts.desc = "Show documentation for what is under cursor"
            keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

            opts.desc = "Restart LSP"
            keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

            -- See https://vi.stackexchange.com/questions/39200/wrapping-comment-in-visual-mode-not-working-with-gq
            vim.opt.formatexpr = nil
        end

        lspconfig.cssls.setup({
            on_attach = on_attach,
        })
        lspconfig.html.setup({
            on_attach = on_attach,
        })
        lspconfig.lua_ls.setup({
            on_attach = on_attach,

            settings = { -- custom settings for lua
                Lua = {
                    -- make the language server recognize "vim" global
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        -- make language server aware of runtime files
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.stdpath("config") .. "/lua"] = true,
                        },
                    },
                },
            },
        })

        lspconfig.ts_ls.setup({
            on_attach = on_attach,
        })
    end,
}
