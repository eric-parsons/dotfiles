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
            }
        })
        require("mason-tool-installer").setup({
            ensure_installed = {
                "prettier",
                "stylua",
                "eslint_d",
            },
        })
    end
}
