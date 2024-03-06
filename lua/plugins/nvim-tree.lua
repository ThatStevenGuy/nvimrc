return {
    'nvim-tree/nvim-tree.lua', -- File explorer
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local wk = require('which-key')
        local g = vim.g
        local keyset = vim.keymap.set

        -- netrw must be disabled
        g.loaded_netrw = 1
        g.loaded_netrwPlugin = 1
        require("nvim-tree").setup()

        -- Key mapping
        local silentOpt = {silent = true}
        keyset("n", "<leader>to", ":NvimTreeOpen<Cr>", silentOpt)
        keyset("n", "<leader>tt", ":NvimTreeToggle<Cr>", silentOpt)
        keyset("n", "<leader>tc", ":NvimTreeClose<Cr>", silentOpt)
        -- keyset("n", "<leader>tf", ":NvimTreeFocus<Cr>", silentOpt)
        keyset("n", "<leader>tf", ":NvimTreeFindFile<Cr>", silentOpt)
        keyset("n", "<leader>tr", ":NvimTreeRefresh<Cr>", silentOpt)

        wk.register({
            name = "Tree",
            o = "Open",
            t = "Toggle",
            c = "Close",
            f = "File",
            r = "Refresh"
        }, { prefix = '<leader>t' })
    end
}
