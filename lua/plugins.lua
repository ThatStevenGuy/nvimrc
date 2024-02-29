-- Documentation:
-- https://github.com/folke/lazy.nvim?tab=readme-ov-file#-installation

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin config files. These will load after lazy.nvim is set up (see below).
local pluginConfigs = {
    'gruvbox',
    'nvim-lspconfig',
    'typescript-tools',
    'nvim-cmp',
    'nvim-tree',
    'lualine',
    'telescope',
    'easymotion',
    'copilot',
    'gitsigns',
    'trouble',
    'luasnip',
    'vim-illuminate',
    'oil-nvim'
}

require("lazy").setup({
    -- Git
    'tpope/vim-fugitive', -- Git support
    'lewis6991/gitsigns.nvim', -- Git hunk operations and gutter signs
    'sindrets/diffview.nvim',

    -- Editing
    'github/copilot.vim', -- LLM magic
    'tpope/vim-surround', -- Easily change character pairs (replace quotes with double quotes etc.)
    'tpope/vim-commentary', -- Comment lines with gc and gcc
    'jiangmiao/auto-pairs', -- Auto-match character pairs (brackets, quotes etc.) and jump over closing characters

    -- Searching & navigiation
    'easymotion/vim-easymotion', -- Faster navigation
    'nvim-telescope/telescope-ui-select.nvim',
    {
        'nvim-telescope/telescope.nvim', -- Fuzzy finding, git & LSP operations and more
        tag = '0.1.5',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        "folke/trouble.nvim", -- Search results & diagnostics window
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = { }
    },

    -- Visuals
    'mhinz/vim-startify', -- Start screen. Also lists sessions which is particularly helpful with vim-obsession.
    'RRethy/vim-illuminate', -- Highlights words under the cursor
    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} }, -- Adds indentation guides
    { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true, opts = {} }, -- Retro theme
    {
        'nvim-lualine/lualine.nvim', -- Status line
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    {
        "folke/which-key.nvim", -- Shows key binding hint popups
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {}
    },

    -- Files & Buffers
    'moll/vim-bbye', -- Close buffers without closing windows
    'nvim-tree/nvim-tree.lua', -- File explorer
    'nvim-tree/nvim-web-devicons', -- Add dev icons (language icons and more). Nice for nvim-tree and Airline.
    'tpope/vim-obsession', -- Easier session management
    {
      'stevearc/oil.nvim',
      opts = {},
      dependencies = { "nvim-tree/nvim-web-devicons" },
    },

    -- LSP support
    {
        "pmizio/typescript-tools.nvim", -- TypeScript language server
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        opts = {},
    },
    {
        'hrsh7th/nvim-cmp', -- Autocomplete for LSP, commands and more
        dependencies = {
            'neovim/nvim-lspconfig',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            -- 'hrsh7th/cmp-nvim-lsp-signature-help',

            -- Snippets
            "L3MON4D3/LuaSnip",
            'saadparwaiz1/cmp_luasnip',
            "rafamadriz/friendly-snippets"
        }
    },
    {
        "ray-x/lsp_signature.nvim",
        event = "VeryLazy",
        opts = { },
        config = function(_, opts) require'lsp_signature'.setup(opts) end
    }
})

-- Load plugin configs
for _, plugin in ipairs(pluginConfigs) do
    require('plugin-configs/' .. plugin)
end
