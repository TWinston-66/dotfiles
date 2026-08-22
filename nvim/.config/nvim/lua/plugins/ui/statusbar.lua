return {
    "SmiteshP/nvim-navic",
    dependencies = {
        "neovim/nvim-lspconfig",
    },
    opts = {
        lsp = {
            auto_attach = true,
            preference = nil,
        },
        highlight = true,
        click = true,
    },
    config = function(_, opts)
        local navic = require("nvim-navic")
        navic.setup(opts)

        vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
    end,
}
