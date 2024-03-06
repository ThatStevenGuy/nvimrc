return {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        vim.opt.termguicolors = true

        local bufferline = require("bufferline")
        bufferline.setup({
            options = {
                separator_style = "slope",
                numbers = "ordinal",
                show_buffer_close_icons = true,
                show_close_icon = true,
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "Project",
                        highlight = "Directory",
                        separator = true
                    }
                },
                diagnostics = "nvim_lsp",
                diagnostics_indicator = function(count, level, diagnostics_dict, context)
                    local icon = level:match("error") and " " or " "
                    return " " .. icon .. count
                end,
            }
        })

        local keyset = vim.keymap.set
        keyset("n", "<leader>bb", ":BufferLinePick<CR>")
        keyset("n", "<leader>bp", ":BufferLineTogglePin<CR>")
        keyset("n", "<leader>bcc", ":bd<CR>")
        keyset("n", "<leader>bcl", ":BufferLineCloseLeft<CR>")
        keyset("n", "<leader>bcr", ":BufferLineCloseRight<CR>")
        keyset("n", "<leader>bco", ":BufferLineCloseOthers<CR>")
        keyset("n", "<leader>bcp", ":BufferLinePickClose<CR>")
        keyset("n", "<C-h>", ":BufferLineCyclePrev<Cr>", silentOpt)
        keyset("n", "<C-l>", ":BufferLineCycleNext<Cr>", silentOpt)

        for i = 1, 9 do
            keyset("n", "<leader>" .. i, function() bufferline.go_to(i, false) end)
        end

        local wk = require("which-key")
        wk.register({
            b = {
                name = "Buffer",
                b = "Pick",
                p = "Pin",
                c = {
                    name = "Close",
                    c = "Close",
                    l = "Close left",
                    r = "Close right",
                    o = "Close others",
                    p = "Pick and close"
                }
            }
        }, { prefix = "<leader>" })
    end
}
