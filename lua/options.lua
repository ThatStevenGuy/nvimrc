local g = vim.g
g.mapleader = ","

local o = vim.o
o.number = true -- Show line numbers
o.relativenumber = true -- Show relative line numbers
o.encoding = 'UTF-8' -- Required for vim-devicons
o.wrap = false -- Don't wrap lines
o.updatetime = 100  -- Faster VIM updates
o.mouse = 'a' -- Enable the mouse
o.colorcolumn = '120' -- Show a ruler for 120 chars
o.signcolumn = 'yes' -- Avoid view shifting by always enabling the gutter
o.splitright = true -- Open new splits to the right of the current one
o.splitbelow = true -- Open new splits below the current one
o.fixeol = false -- Don't add an EOL at the end of files to stay in line with VS Code and IntelliJ
o.cursorline = true -- Highlight the current line
o.showmode = false -- Don't show the mode in the command line (lualine.nvim already shows it)

-- Configure scrolling
o.scrolloff = 8 -- Keep 8 lines above and below the cursor
o.sidescroll = 1 -- Scroll one line at a time
o.sidescrolloff = 2 -- Keep some distance to the left and right of the cursor

-- Configure tabbing
o.shiftwidth = 4 -- Number of spaces to use for indenting
o.tabstop = 4 -- Number of spaces a tab counts for
o.softtabstop = 4 -- Number of spaces to insert when tab is pressed
o.expandtab = true -- Tabs are spaces

-- Configure formatting
-- Seems there is a longstanding issue with Neovim where formatoptions are overwritten by FileType implementations (for
-- instance, TypeScript has its own default formatoptions that are applied during startup). To ensure our formatoptions
-- take effect, we'll locally apply them whenever a file (of any FileType) is opened.
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        local opt = vim.opt_local;
        opt.formatoptions:remove("r") -- Don't automatically insert a comment leader when hitting <CR> in a one-line comment
        opt.formatoptions:append("t") -- Wrap text according to textwidth
    end
})

-- Highlighted yanking
vim.cmd[[
    augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=250})
    augroup END
]]
