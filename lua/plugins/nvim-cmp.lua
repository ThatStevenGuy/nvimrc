-- Resources:
-- https://github.com/hrsh7th/nvim-cmp?tab=readme-ov-file#setup
-- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip

return {
    'hrsh7th/nvim-cmp', -- Autocomplete for LSP, commands and more
    dependencies = {
        'neovim/nvim-lspconfig',
        'hrsh7th/cmp-nvim-lsp',
        -- 'hrsh7th/cmp-buffer', -- Suggests words from the current buffer. Annoying when typing comments or variable names.
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        -- 'hrsh7th/cmp-nvim-lsp-signature-help',

        -- Snippets
        "L3MON4D3/LuaSnip",
        'saadparwaiz1/cmp_luasnip',
        -- "rafamadriz/friendly-snippets" -- Not really using snippets much. They just get in the way of autocompletion.
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        -- Prepend the Copilot comparator to the default comparators
        local default_config = require("cmp.config.default")()
        local comparators = default_config.sorting.comparators
        table.insert(comparators, 1, require("scripts/nvim-cmp-copilot"))

        cmp.setup({
            sorting = {
                priority_weight = 2,
                comparators = comparators,
            },
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            window = {
                -- completion = cmp.config.window.bordered(),
                -- documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.confirm({ select = true })
                    elseif luasnip.jumpable() then
                        luasnip.jump()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                -- { name = 'nvim_lsp_signature_help' } -- Disabled in favor of lsp_signature.nvim
            }, {
                { name = 'buffer' },
            })
        })

        -- Set configuration for specific filetype.
        cmp.setup.filetype('gitcommit', {
            sources = cmp.config.sources({
                { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
            }, {
                { name = 'buffer' },
            })
        })

        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' }
            }
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' }
            }, {
                { name = 'cmdline' }
            })
        })

        require('cmp_nvim_lsp').default_capabilities()
    end
}
