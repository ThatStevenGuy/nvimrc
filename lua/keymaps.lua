local keyset = vim.keymap.set
local silentOpt = { silent = true }

-- Shift-tab outdent
keyset("i", "<S-Tab>", "<C-d>")

-- Switch tabs more easily
keyset("n", "[t", ":tabprevious<Cr>", silentOpt)
keyset("n", "]t", ":tabnext<Cr>", silentOpt)

-- Use HJKL to move around in insert mode
keyset("i", "<C-h>", "<Left>")
keyset("i", "<C-j>", "<Down>")
keyset("i", "<C-k>", "<Up>")
keyset("i", "<C-l>", "<Right>")

-- Terminal - Exit out of insert mode via escape
keyset("t", "<Esc>", "<C-\\><C-n>")

-- Disable C-z from job-controlling Neovim
keyset("n", "<C-z>", "<nop>")

-- Language-specific keymaps
vim.cmd([[
    au FileType typescript nmap <leader>rb :!npm run build:dev<Cr>
]])
