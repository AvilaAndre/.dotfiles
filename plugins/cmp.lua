return {
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-cmdline' },
    {
        'hrsh7th/nvim-cmp',
        config = function(_, _opts)
            local cmp = require('cmp')
            cmp.setup({
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'buffer' },
                    { name = 'path' },
                },
                mapping = {
                    ['<Tab>'] = cmp.mapping.confirm({ select = false }),
                    ['<C-y>'] = cmp.mapping.confirm({ select = false }),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = 'select' }),
                    ['<C-j>'] = cmp.mapping.select_next_item({ behavior = 'select' }),
                    ['<C-p>'] = cmp.mapping(function()
                        if cmp.visible() then
                            cmp.select_prev_item({ behavior = 'insert' })
                        else
                            cmp.complete()
                        end
                    end),
                    ['<C-n>'] = cmp.mapping(function()
                        if cmp.visible() then
                            cmp.select_next_item({ behavior = 'insert' })
                        else
                            cmp.complete()
                        end
                    end),
                },
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
            })

            -- `:` cmdline setup.
            -- cmp.setup.cmdline(':', {
            -- mapping = cmp.mapping.preset.cmdline(),
            -- sources = cmp.config.sources({
            -- { name = 'path' }
            -- }, {
            -- {
            -- name = 'cmdline',
            -- option = {
            -- ignore_cmds = { 'Man', '!' }
            -- }
            -- }
            -- })
            -- })

            cmp.setup.filetype({ 'sql' }, {
                sources = {
                    { name = 'vim-dadbod-completion' },
                    { name = 'buffer' },
                },
            })
        end
    },
}
