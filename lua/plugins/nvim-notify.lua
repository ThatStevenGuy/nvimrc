return {
    'rcarriga/nvim-notify',
    config = function()
        vim.opt.termguicolors = true

        local notify = require("notify")
        notify.setup({
            level = vim.log.levels.DEBUG
        })

        vim.notify = notify
    end,
}
