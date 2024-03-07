local wk = require("which-key")
local bufferline = require("bufferline")
local telescope = require("telescope.builtin")
local trouble = require("trouble")
local nvim_tree = require("nvim-tree")
local gitsigns = require("gitsigns")
local cmp = require("cmp")

local keyset = vim.keymap.set
local silentOpt = { silent = true }

--------------------------------------------------------------------------------
-- Miscellaneous
--------------------------------------------------------------------------------

keyset("i", "<S-Tab>", "<C-d>") -- Outdent
keyset("n", "[t", ":tabprevious<Cr>", silentOpt)
keyset("n", "]t", ":tabnext<Cr>", silentOpt)
keyset("t", "<Esc>", "<C-\\><C-n>") -- Exit out of insert mode in the terminal via escape
keyset("n", "<C-z>", "<nop>") -- Disable C-z from job-controlling Neovim

-- Language-specific keymaps
vim.cmd([[
    au FileType typescript nmap <leader>rb :!npm run build:dev<Cr>
]])

--------------------------------------------------------------------------------
-- Buffers
--------------------------------------------------------------------------------

wk.register({
    name = "Buffer",
    b = { ":BufferLinePick<CR>", "Pick" },
    c = {
        name = "Close",
        c = { ":Bwipeout<CR>", "Current" },
        f = { ":Bwipeout!<CR>", "Current (force)" },
        l = { ":BufferLineCloseLeft<CR>", "Left" },
        o = { ":BufferLineCloseOthers<CR>", "Others" },
        p = { ":BufferLinePickClose<CR>", "Pick" },
        r = { ":BufferLineCloseRight<CR>", "Right" },
    },
    h = { ":DiffviewFileHistory %<CR>", "History" },
    p = { ":BufferLineTogglePin<CR>", "Pin" },
}, { prefix = "<leader>b" })

wk.register({
    ["<C-h>"] = { ":BufferLineCyclePrev<CR>", "Previous" },
    ["<C-l>"] = { ":BufferLineCycleNext<CR>", "Next" },
})

for i = 1, 9 do
    wk.register({
        ["<leader>" .. i] = { function() bufferline.go_to(i, false) end, "Go to buffer " .. i }
    })
end

--------------------------------------------------------------------------------
-- Autocompletion
--------------------------------------------------------------------------------

--[[
We're using the default vim autocompletion bindings:
- <C-n> and <C-p> to navigate the completion menu
- <C-y> to confirm the completion
- <C-e> to abort the completion
]]
wk.register({
    ["<C-b>"] = { cmp.mapping.scroll_docs(-4), "Scroll up" },
    ["<C-f>"] = { cmp.mapping.scroll_docs(4), "Scroll down" },
    ["<C-Space>"] = { cmp.mapping.complete(), "Complete" },
    ["<C-e>"] = { cmp.mapping.abort(), "Abort" },
    ["<C-y>"] = { cmp.mapping.confirm({ select = true }), "Confirm" },
}, { mode = { "i", "s" } })

--------------------------------------------------------------------------------
-- Finding
--------------------------------------------------------------------------------

wk.register({
    name = "Find",
    f = { telescope.find_files, "File" },
    g = { telescope.live_grep, "Grep"},
    b = { telescope.buffers, "Buffer" },
    h = { telescope.help_tags, "Help" },
    c = { telescope.commands, "Command" },
    s = { telescope.lsp_workspace_symbols, "Symbol" },
    o = { telescope.lsp_document_symbols, "Outline" },
}, { prefix = '<leader>f' })

--------------------------------------------------------------------------------
-- Trouble
--------------------------------------------------------------------------------

wk.register({
    name = "Trouble",
    x = { function() trouble.toggle() end, "Toggle" },
    w = { function() trouble.toggle("workspace_diagnostics") end, "Workspace diagnostics" },
    d = { function() trouble.toggle("document_diagnostics") end, "Document diagnostics" },
    q = { function() trouble.toggle("quickfix") end, "Quickfix" },
    l = { function() trouble.toggle("loclist") end, "Loclist" },
}, { prefix = "<leader>x" })

--------------------------------------------------------------------------------
-- NvimTree
--------------------------------------------------------------------------------

wk.register({
    name = "NvimTree",
    o = { ":NvimTreeOpen<CR>", "Open" },
    t = { ":NvimTreeToggle<CR>", "Toggle" },
    c = { ":NvimTreeClose<CR>", "Close" },
    f = { ":NvimTreeFindFile<CR>", "Find file" },
    r = { ":NvimTreeRefresh<CR>", "Refresh" }
}, { prefix = "<leader>t" })


--------------------------------------------------------------------------------
-- Copilot
--------------------------------------------------------------------------------

wk.register({
    name = "Copilot",
    p = { ":Copilot panel<CR>", "Suggest" },
}, { prefix = "<leader>c" })

-- wk.register({
--     ["<C-h>"] = { "<Plug>(copilot-previous)", "Previous suggestion" },
--     ["<C-l>"] = { "<Plug>(copilot-next)", "Next suggestion" },
-- }, { mode = "i" })

--------------------------------------------------------------------------------
-- Git
--------------------------------------------------------------------------------

wk.register({
    name = "Git",
    b = { telescope.git_branches, "Branches" },
    c = {
        name = "Commits",
        b = { telescope.git_bcommits, "Buffer" },
        p = { telescope.git_commits, "Project" },
    },
    d = { ":DiffviewOpen<CR>", "Diff" },
    s = { ":Git<CR>", "Status" },
    S = { telescope.git_status, "Status (quick)" },
}, { prefix = "<leader>g" })

-- Gitsigns
gitsigns.setup({
    on_attach = function(bufnr)
        -- Normal mode
        wk.register({
            h = {
                name = "Hunk",
                b = { function() gitsigns.blame_line({ full = true }) end, "Blame line" },
                d = { gitsigns.diffthis, "Diff" },
                D = { function() gitsigns.diffthis('~') end, "Diff (last commit)" },
                p = { gitsigns.preview_hunk, "Preview hunk" },
                r = { gitsigns.reset_hunk, "Reset hunk" },
                R = { gitsigns.reset_buffer, "Reset buffer" },
                s = { gitsigns.stage_hunk, "Stage hunk" },
                S = { gitsigns.stage_buffer, "Stage buffer" },
                t = {
                    name = "Toggle",
                    b = { gitsigns.toggle_current_line_blame, "Toggle blame" },
                    d = { gitsigns.toggle_deleted, "Deleted" },
                },
                u = { gitsigns.undo_stage_hunk, "Undo stage hunk" }
            }
        }, { prefix = "<leader>", buffer = bufnr})

        wk.register({
            ["[c"] = {
                function()
                    if vim.wo.diff then return '[c' end
                    vim.schedule(function() gitsigns.prev_hunk() end)
                    return '<Ignore>'
                end, "Previous hunk", expr = true
            },
            ["]c"] = {
                function()
                    if vim.wo.diff then return ']c' end
                    vim.schedule(function() gitsigns.next_hunk() end)
                    return '<Ignore>'
                end, "Next hunk", expr = true
            }
        }, { buffer = bufnr })

        -- Visual mode
        wk.register({
            name = "Hunk",
            r = { function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, "Reset hunk" },
            s = { function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, "Stage hunk" },
        }, { prefix = "<leader>h", buffer = bufnr, mode = "v" })

        -- Text object
        wk.register({
            ih = { ":<C-U>Gitsigns select_hunk<CR>", "Inner hunk" },
        }, { mode = { "o", "x" }, buffer = bufnr })
    end
})

--------------------------------------------------------------------------------
-- LSP
--------------------------------------------------------------------------------

-- Diagnostics
wk.register({
    name = "LSP",
    e = { vim.diagnostic.open_float, "Show error" },
    q = { vim.diagnostic.setloclist, "Set loclist" },
}, { prefix = "<space>" })

-- Use an autocommand to only map the following keys after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', { }),
    callback = function(ev)
        local bufnr = ev.buf

        -- Miscellaneous
        wk.register({
            K = { vim.lsp.buf.hover, "Hover" },
            ["<C-k>"] = { vim.lsp.buf.signature_help, "Signature help" },
            ["<space>rn"] = { vim.lsp.buf.rename, "Rename" },
            ["<space>f"] = { function() vim.lsp.buf.format { async = true } end, "Format" },
            ["<space>a"] = { vim.lsp.buf.code_action, "Code action", mode = {"n", "v"} },
        })

        -- Type navigation
        wk.register({
            d = { telescope.lsp_definitions, "Definition" },
            i = { telescope.lsp_implementations, "Implementations" },
            r = { telescope.lsp_references, "References" },
            R = { function() require("trouble").toggle("lsp_references") end, "References (trouble)" },
            y = { telescope.lsp_type_definitions, "Type definition" },
        }, { prefix = "g", buffer = bufnr })

        -- Diagnostics
        wk.register({
            ["[d"] = { vim.diagnostic.goto_prev, "Previous" },
            ["]d"] = { vim.diagnostic.goto_next, "Next" },
        }, { buffer = bufnr })

        -- Workspace
        wk.register({
            name = "Workspace",
            a = { vim.lsp.buf.add_workspace_folder, "Add folder" },
            r = { vim.lsp.buf.remove_workspace_folder, "Remove folder" },
            l = { function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, "List folders" }
        }, { prefix = "<space>w", buffer = bufnr })

        -- Enable completion triggered by <c-x><c-o>
        vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Old mapping for reference. These mapping don't use any plugins.
        -- local opts = { buffer = ev.buf }
        -- keyset('n', 'gD', vim.lsp.buf.declaration, opts)
        -- keyset('n', 'gd', vim.lsp.buf.definition, opts)
        -- keyset('n', 'gi', vim.lsp.buf.implementation, opts)
        -- keyset('n', 'gr', vim.lsp.buf.references, opts)
        -- keyset('n', '<space>D', vim.lsp.buf.type_definition, opts)
        -- keyset({ 'n', 'v' }, '<space>a', vim.lsp.buf.code_action, opts)
    end
})

-- TypeScript-specific
vim.api.nvim_create_autocmd("FileType", {
    pattern = "typescript",
    callback = function()
        local keyset = vim.keymap.set
        local opts = { buffer = true }
        keyset("n", "<space>io", ":TSToolsOrganizeImports<CR>", opts)
        keyset("n", "<space>ia", ":TSToolsAddMissingImports<CR>", opts)
    end
})

