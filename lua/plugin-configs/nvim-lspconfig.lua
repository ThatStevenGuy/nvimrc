local keyset = vim.keymap.set

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
keyset("n", "<space>e", vim.diagnostic.open_float)
keyset("n", "[d", vim.diagnostic.goto_prev)
keyset("n", "]d", vim.diagnostic.goto_next)
keyset("n", "<space>q", vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        keyset('n', 'gD', vim.lsp.buf.declaration, opts)
        -- keyset('n', 'gd', vim.lsp.buf.definition, opts) -- Overriden in telescope.lua
        keyset('n', 'K', vim.lsp.buf.hover, opts)
        -- keyset('n', 'gi', vim.lsp.buf.implementation, opts) -- Overriden in telescope.lua
        keyset('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        keyset('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        keyset('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        keyset('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        -- keyset('n', '<space>D', vim.lsp.buf.type_definition, opts) -- Overriden in telescope.lua
        keyset('n', '<space>rn', vim.lsp.buf.rename, opts)
        keyset({ 'n', 'v' }, '<space>a', vim.lsp.buf.code_action, opts)
        -- keyset('n', 'gr', vim.lsp.buf.references, opts) -- Overriden in telescope.lua
        keyset('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end
})
