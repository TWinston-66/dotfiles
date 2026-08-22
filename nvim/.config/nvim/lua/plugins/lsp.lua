return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        require("mason").setup()

        require("mason-lspconfig").setup({
            ensure_installed = {
                "gopls",
                "clangd",
                "rust_analyzer",
                "ts_ls",
                "bashls",
            },
        })
    end,
}
