return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "cssls",
                "html",
                "lua_ls",
                "ts_ls",
                -- Haskell language server. NOTE: To get this to work, I had to
                -- first install `ghcup`. You can use homebrew for this and
                -- ghc, but I ran into problems with the versions being
                -- mismatched with what the Mason-bundled version of hls could
                -- handle. It's best to use the shell script at
                -- https://www.haskell.org/ghcup/ to install all the haskell
                -- tooling, using the recommended rather than latest version of
                -- ghc.
                "hls",
            },
        })
        require("mason-tool-installer").setup({
            ensure_installed = {
                -- Lua formatter.
                "stylua",
                -- Web formatter (JS, TS, HTML, CSS, JSON, and others).
                "prettier",
                -- JS/TS linter.
                "eslint_d",
                -- Shell script formatter.
                "beautysh",
                -- Haskell formatter.
                "ormolu",
            },
        })
    end,
}
