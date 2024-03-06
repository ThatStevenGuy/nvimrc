return {
    'github/copilot.vim', -- LLM magic
    config = function()
        local g = vim.g
        g.copilot_assume_mapped = true
        --g.copilot_no_tab_map = true

        local keyset = vim.keymap.set
        local silentOpt = {silent = true}
        keyset("n", "<leader>cd", "<Plug>(copilot-dismiss)", silentOpt)
        keyset("n", "<leader>cn", "<Plug>(copilot-next)", silentOpt)
        keyset("n", "<leader>cp", "<Plug>(copilot-previous)", silentOpt)
        -- keyset("n", "<leader>cs", "<Plug>(copilot-suggest)", silentOpt)
        keyset("n", "<leader>cs", ":Copilot panel<Cr>", silentOpt)
        keyset("n", "<leader>caw", "<Plug>(copilot-accept-word)", silentOpt)
        keyset("n", "<leader>cal", "<Plug>(copilot-accept-line)", silentOpt)

        local wk = require('which-key')
        wk.register({
            name = "Copilot",
            d = "Dismiss suggestion",
            n = "Next suggestion",
            p = "Previous suggestion",
            s = "Suggest",
            aw = "Accept word",
            al = "Accept line"
        }, { prefix = '<leader>c' })
    end
}
