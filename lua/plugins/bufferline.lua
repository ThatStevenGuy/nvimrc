return {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        vim.opt.termguicolors = true
        require("bufferline").setup({
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
    end
}
