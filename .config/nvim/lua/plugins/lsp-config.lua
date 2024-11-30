return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local lspconfig = require("lspconfig")
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        local keymap = vim.keymap
        local opts = { noremap = true, silent = true }
        local on_attach = function(_, bufnr)
            opts.buffer = bufnr

            -- Set keybinds.
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
            keymap.set({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, opts)

            opts.desc = "Smart rename"
            keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

            opts.desc = "Show buffer diagnostics"
            keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

            opts.desc = "Show line diagnostics"
            keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

            opts.desc = "Go to previous diagnostic"
            keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

            opts.desc = "Go to next diagnostic"
            keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

            opts.desc = "Show documentation for what is under cursor"
            keymap.set("n", "K", vim.lsp.buf.hover, opts)

            -- See https://vi.stackexchange.com/questions/39200/wrapping-comment-in-visual-mode-not-working-with-gq
            vim.opt.formatexpr = nil
        end

        lspconfig.cssls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })
        lspconfig.html.setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })
        lspconfig.lua_ls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                Lua = {
                    -- Make the language server recognize "vim" global.
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        -- Make language server aware of runtime files.
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
            capabilities = capabilities,
        })
    end,
}
