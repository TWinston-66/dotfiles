return {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
        local langs = { 'lua', 'vim', 'vimdoc', 'go', 'javascript', 'c', 'c++', 'rust', 'bash' }
        require('nvim-treesitter').install(langs)
        vim.api.nvim_create_autocmd('FileType', {
            pattern = langs,
            callback = function() vim.treesitter.start() end,
        })
    end,
}
