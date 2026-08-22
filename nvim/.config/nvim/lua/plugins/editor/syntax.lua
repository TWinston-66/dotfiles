return {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
        local parser_by_filetype = {
            help = 'vimdoc',
            sh = 'bash',
            javascriptreact = 'javascript',
            typescriptreact = 'tsx',
        }
        local filetypes = {
            'lua', 'vim', 'help', 'go', 'c', 'cpp', 'rust', 'sh',
            'javascript', 'javascriptreact', 'typescript', 'typescriptreact',
        }

        local parsers = {}
        for _, ft in ipairs(filetypes) do
            parsers[parser_by_filetype[ft] or ft] = true
        end
        local langs = vim.tbl_keys(parsers)
        require('nvim-treesitter').install(langs)

        vim.api.nvim_create_autocmd('FileType', {
            pattern = filetypes,
            callback = function() vim.treesitter.start() end,
        })
    end,
}
