-- Documentation:
-- https://github.com/easymotion/vim-easymotion?tab=readme-ov-file
local g = vim.g
local keyset = vim.keymap.set

-- Settings
g.EasyMotion_smartcase = 1

-- Within line motions
keyset("n", "<leader><leader>l", "<Plug>(easymotion-lineforward)", {silent = true})
keyset("n", "<leader><leader>h", "<Plug>(easymotion-linebackward)", {silent = true})

-- 2 character searching
keyset("n", "s", "<Plug>(easymotion-s2)", {silent = true})
keyset("n", "t", "<Plug>(easymotion-t2)", {silent = true})

-- n character searching
keyset("n", "/", "<Plug>(easymotion-sn)", {silent = true})
keyset("o", "/", "<Plug>(easymotion-tn)", {silent = true})
keyset("n", "n", "<Plug>(easymotion-next)", {silent = true})
keyset("n", "N", "<Plug>(easymotion-prev)", {silent = true})
