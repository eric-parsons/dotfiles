return {
    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter", "CmdlineEnter" },
        dependencies = {
            "onsails/lspkind.nvim",
            "hrsh7th/cmp-nvim-lsp",
            -- TODO: Find a way to enable this only in buffers that don't have
            -- a configured LSP. Otherwise, it adds a ton of noise.
            -- "hrsh7th/cmp-buffer",
            "saadparwaiz1/cmp_luasnip",
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets",
        },
        config = function()
            vim.opt.completeopt = { "menu", "menuone", "noselect" }
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            require("luasnip.loaders.from_vscode").lazy_load()
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ["<c-e>"] = cmp.mapping.abort(),
                    -- Make Enter confirm the completion, but only if an item
                    -- was explicitly selected. Or else Ctrl+Y will auto-select
                    -- the first item and complete.
                    ["<cr>"] = cmp.mapping.confirm({ select = false }),
                    ["<c-y>"] = cmp.mapping.confirm({ select = true }),
                    -- Allow Tab and Shift+Tab as an alternate way to select
                    -- items in completion menu.
                    ["<tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<s-tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    -- Move between placeholders in snippet. Some people also
                    -- overload the tab key for this purpose as well, but that
                    -- can get annoying if the completion menu happens to be
                    -- open when you want to jump, which forces you to use
                    -- Ctrl+e to close it first. Having dedicated keys for this
                    -- purpose avoids that issue.
                    ["<s-right>"] = cmp.mapping(function()
                        if luasnip.locally_jumpable(1) then
                            luasnip.jump(1)
                        end
                    end, { "i", "s" }),
                    ["<s-left>"] = cmp.mapping(function()
                        if luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        end
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    { name = "luasnip" },
                    { name = "nvim_lsp" },
                    -- See comment in dependencies.
                    -- { name = "buffer" },
                }),
                formatting = {
                    format = require("lspkind").cmp_format({
                        mode = "symbol_text",
                    }),
                },
                sorting = {
                    comparators = {
                        cmp.config.compare.locality,
                        cmp.config.compare.recently_used,
                        cmp.config.compare.kind,
                        cmp.config.compare.score,
                    },
                },
                enabled = function()
                    -- Disable completion in comments.
                    local context = require("cmp.config.context")
                    -- Keep command mode completion enabled when cursor is in a comment.
                    if vim.api.nvim_get_mode().mode == "c" then
                        return true
                    else
                        return not context.in_treesitter_capture("comment")
                            and not context.in_syntax_group("Comment")
                    end
                end,
            })
        end,
    },
}
