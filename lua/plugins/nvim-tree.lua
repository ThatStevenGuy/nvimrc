return {
    'nvim-tree/nvim-tree.lua', -- File explorer
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        -- netrw must be disabled
        local g = vim.g
        g.loaded_netrw = 1
        g.loaded_netrwPlugin = 1
        require("nvim-tree").setup()
    end
}
