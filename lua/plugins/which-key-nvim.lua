return {
    "folke/which-key.nvim", -- Shows key binding hint popups
    priority = 900,
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    opts = {}
}
