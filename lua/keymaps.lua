local keyset = vim.keymap.set
local silentOpt = { silent = true }

-- Shift-tab outdent
keyset("i", "<S-Tab>", "<C-d>")

-- Switch buffers & tabs more easily
keyset("n", "[t", ":tabprevious<Cr>", silentOpt)
keyset("n", "]t", ":tabnext<Cr>", silentOpt)
keyset("n", "<C-h>", ":bprevious<Cr>", silentOpt)
keyset("n", "<C-l>", ":bnext<Cr>", silentOpt)

-- Buffer close bindings (via vim-bbye)
keyset("n", "<leader>qq", ":Bwipeout!<Cr>", silentOpt)
keyset("n", "<leader>qa", ":bufdo :Bwipeout!<Cr>", silentOpt)

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
    au FileType typescript nmap <leader>b :!npm run build:dev<Cr>
]])
