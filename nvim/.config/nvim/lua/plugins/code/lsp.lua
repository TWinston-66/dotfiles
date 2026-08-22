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
                "lua_ls",
            },
        })

        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(event)
                local opts = { buffer = event.buf }
                local keymap = vim.keymap

                keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                keymap.set("n", "gr", vim.lsp.buf.references, opts)
                keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                keymap.set("n", "K", vim.lsp.buf.hover, opts)
                keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
            end,
        })
    end,
}
