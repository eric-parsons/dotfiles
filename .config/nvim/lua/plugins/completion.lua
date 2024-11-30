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
                    -- TODO: I can't get this to work. It seems like it's
                    -- supposed to manually open the completion popup, but it
                    -- doesn't do anything?
                    ["<c-space>"] = cmp.mapping.complete(),
                    ["<c-e>"] = cmp.mapping.abort(),
                    -- Make Enter or Space confirm the completion, but only if
                    -- an item was explicitly selected.
                    ["<cr>"] = cmp.mapping.confirm({ select = false }),
                    ["<space>"] = cmp.mapping.confirm({ select = false }),
                    ["<tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    -- Allow Tab and Shift+Tab as an alternate way to select
                    -- items in completion menu.
                    ["<s-tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    -- Move between placeholders in snippet.
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
                        cmp.config.compare.offset,
                        cmp.config.compare.exact,
                        cmp.config.compare.score,
                        cmp.config.compare.recently_used,
                        cmp.config.compare.kind,
                    },
                },
            })
        end,
    },
}
