return {
    "ellisonleao/gruvbox.nvim", -- Retro theme
    priority = 1000,
    config = function ()
        vim.o.background = "dark" -- or "light" for light mode

        -- Lightly brighten the background for highlighted words rather than making them bold yellow (the default)
        local gruvbox = require("gruvbox")
        local illuminateGroup = { bg = gruvbox.palette.dark3 }

        gruvbox.setup({
          terminal_colors = true, -- add neovim terminal colors
          undercurl = true,
          underline = true,
          bold = true,
          italic = {
            strings = true,
            emphasis = true,
            comments = true,
            operators = false,
            folds = true,
          },
          strikethrough = true,
          invert_selection = false,
          invert_signs = false,
          invert_tabline = false,
          invert_intend_guides = false,
          inverse = true, -- invert background for search, diffs, statuslines and errors
          contrast = "", -- can be "hard", "soft" or empty string
          palette_overrides = {},
          overrides = {},
          dim_inactive = false,
          transparent_mode = false,
          overrides = {
            NvimTreeExecFile = { fg = gruvbox.palette.light2 }, -- Much nicer than green for file names
            IlluminatedWordText = illuminateGroup,
            IlluminatedWordRead = illuminateGroup,
            IlluminatedWordWrite = illuminateGroup,
          }
        })

        vim.cmd("colorscheme gruvbox")
    end
}
