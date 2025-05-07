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

wk.add({
    { "<leader>r", group = "Run" },
    { "<leader>rb", ":3TermExec cmd='clear && npm run build:dev' name='Build'<CR>", desc = "Build" },
})

--------------------------------------------------------------------------------
-- Buffers
--------------------------------------------------------------------------------

wk.add({
    { "<leader>b", group = "Buffer" },
    { "<leader>bb", ":BufferLinePick<CR>", desc = "Pick" },
    { "<leader>bc", group = "Close" },
    { "<leader>bcc", ":Bwipeout<CR>", desc = "Current" },
    { "<leader>bcf", ":Bwipeout!<CR>", desc = "Current (force)" },
    { "<leader>bcl", ":BufferLineCloseLeft<CR>", desc = "Left" },
    { "<leader>bco", ":BufferLineCloseOthers<CR>", desc = "Others" },
    { "<leader>bcp", ":BufferLinePickClose<CR>", desc = "Pick" },
    { "<leader>bcr", ":BufferLineCloseRight<CR>", desc = "Right" },
    { "<leader>bh", ":DiffviewFileHistory %<CR>", desc = "History" },
    { "<leader>bp", ":BufferLineTogglePin<CR>", desc = "Pin" },
})

wk.add({
    { "<C-h>", ":BufferLineCyclePrev<CR>", desc = "Previous" },
    { "<C-l>", ":BufferLineCycleNext<CR>", desc = "Next" },
})

for i = 1, 9 do
    wk.add({ "<leader>" .. i, function() bufferline.go_to(i, false) end, desc = "Go to buffer " .. i })
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
wk.add({
    {
      mode = { "i", "s" },
      { "<C-b>", cmp.mapping.scroll_docs(-4), desc = "Scroll up" },
      { "<C-f>", cmp.mapping.scroll_docs(4), desc = "Scroll down" },
      { "<C-Space>", cmp.mapping.complete(), desc = "Complete" },
      { "<C-e>", cmp.mapping.abort(), desc = "Abort" },
      { "<C-y>", cmp.mapping.confirm({ select = true }), desc = "Confirm" }
    }
})

--------------------------------------------------------------------------------
-- Terminal
--------------------------------------------------------------------------------

-- wk.register({
--     name = "Terminal",
--     c = { ":TermExec cmd='clear'<CR>", "Clear" },
--     t = { ":ToggleTerm<CR>", "Toggle" },
-- }, { prefix = "<leader>t" })

wk.add({
    { "<leader>t", group = "Terminal" },
    { "<leader>tc", ":TermExec cmd='clear'<CR>", desc = "Clear" },
    { "<leader>tt", ":ToggleTerm<CR>", desc = "Toggle" },
})

for i = 1, 9 do
    wk.add({
        "<leader>t" .. i,
        ":" .. i .. "ToggleTerm size=10 direction=horizontal name='Terminal " .. i .."'<CR>",
        desc = "Terminal " .. i
    })
end

--------------------------------------------------------------------------------
-- Finding
--------------------------------------------------------------------------------

wk.add({
    { "<leader>f", group = "Find" },
    { "<leader>fb", telescope.buffers, desc = "Buffer" },
    { "<leader>fc", telescope.commands, desc = "Command" },
    { "<leader>ff", telescope.find_files, desc = "File" },
    { "<leader>fg", telescope.live_grep, desc = "Grep" },
    { "<leader>fh", telescope.help_tags, desc = "Help" },
    { "<leader>fo", telescope.lsp_document_symbols, desc = "Outline" },
    { "<leader>fs", telescope.lsp_workspace_symbols, desc = "Symbol" },
    { "<leader>ft", ":TermSelect<CR>", desc = "Terminal" },
})

--------------------------------------------------------------------------------
-- Trouble
--------------------------------------------------------------------------------

wk.add({
    { "<leader>x", group = "Trouble" },
    { "<leader>xd", function() trouble.toggle("document_diagnostics") end, desc = "Document diagnostics" },
    { "<leader>xl", function() trouble.toggle("loclist") end, desc = "Loclist" },
    { "<leader>xq", function() trouble.toggle("quickfix") end, desc = "Quickfix" },
    { "<leader>xw", function() trouble.toggle("workspace_diagnostics") end, desc = "Workspace diagnostics" },
    { "<leader>xx", function() trouble.toggle() end, desc = "Toggle" },
})

--------------------------------------------------------------------------------
-- File explorer
--------------------------------------------------------------------------------

wk.add({
    { "<leader>e", group = "File explorer" },
    { "<leader>ec", ":NvimTreeClose<CR>", desc = "Close" },
    { "<leader>ef", ":NvimTreeFindFile<CR>", desc = "Find file" },
    { "<leader>eo", ":NvimTreeOpen<CR>", desc = "Open" },
    { "<leader>er", ":NvimTreeRefresh<CR>", desc = "Refresh" },
    { "<leader>et", ":NvimTreeToggle<CR>", desc = "Toggle" },
})

--------------------------------------------------------------------------------
-- Copilot
--------------------------------------------------------------------------------

wk.add({
    { "<leader>c", group = "Copilot" },
    { "<leader>cp", ":Copilot panel<CR>", desc = "Suggest" },
})

-- wk.register({
--     ["<C-h>"] = { "<Plug>(copilot-previous)", "Previous suggestion" },
--     ["<C-l>"] = { "<Plug>(copilot-next)", "Next suggestion" },
-- }, { mode = "i" })

--------------------------------------------------------------------------------
-- Git
--------------------------------------------------------------------------------

wk.add({
    { "<leader>g", group = "Git" },
    { "<leader>gb", telescope.git_branches, desc = "Branches" },
    { "<leader>gc", group = "Commits" },
    { "<leader>gcb", telescope.git_bcommits, desc = "Buffer" },
    { "<leader>gcp", telescope.git_commits, desc = "Project" },
    { "<leader>gd", ":DiffviewOpen<CR>", desc = "Diff" },
    { "<leader>gs", ":Git<CR>", desc = "Status" },
    { "<leader>gS", telescope.git_status, desc = "Status (quick)" }
})

-- Gitsigns
gitsigns.setup({
    on_attach = function(bufnr)
        -- Normal mode
        wk.add({
            { "<leader>h", buffer = bufnr, group = "Hunk" },
            { "<leader>hb", function() gitsigns.blame_line({ full = true }) end, buffer = bufnr, desc = "Blame line" },
            { "<leader>hd", gitsigns.diffthis, buffer = bufnr, desc = "Diff" },
            { "<leader>hD", function() gitsigns.diffthis('~') end, buffer = bufnr, desc = "Diff (last commit)" },
            { "<leader>hp", gitsigns.preview_hunk, buffer = bufnr, desc = "Preview hunk" },
            { "<leader>hr", gitsigns.reset_hunk, buffer = bufnr, desc = "Reset hunk" },
            { "<leader>hR", gitsigns.reset_buffer, buffer = bufnr, desc = "Reset buffer" },
            { "<leader>hs", gitsigns.stage_hunk, buffer = bufnr, desc = "Stage hunk" },
            { "<leader>hS", gitsigns.stage_buffer, buffer = bufnr, desc = "Stage buffer" },
            { "<leader>ht", buffer = bufnr, group = "Toggle" },
            { "<leader>htb", gitsigns.toggle_current_line_blame, buffer = bufnr, desc = "Toggle blame" },
            { "<leader>htd", gitsigns.toggle_deleted, buffer = bufnr, desc = "Deleted" },
            { "<leader>hu", gitsigns.undo_stage_hunk, buffer = bufnr, desc = "Undo stage hunk" },
        })

        wk.add({
            {
                "[c",
                function()
                    if vim.wo.diff then return '[c' end
                    vim.schedule(function() gitsigns.prev_hunk() end)
                    return '<Ignore>'
                end,
                buffer = bufnr,
                desc = "Previous hunk",
                expr = true
            },
            {
                "]c",
                function()
                    if vim.wo.diff then return ']c' end
                    vim.schedule(function() gitsigns.next_hunk() end)
                    return '<Ignore>'
                end,
                buffer = bufnr,
                desc = "Next hunk",
                expr = true
            }
        })

        -- Visual mode
        wk.add({
            {
                mode = { "v" },
                { "<leader>h", buffer = bufnr, group = "Hunk" },
                { "<leader>hr", function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, buffer = bufnr, desc = "Reset hunk" },
                { "<leader>hs", function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, buffer = bufnr, desc = "Stage hunk" },
            },
        })

        -- Text object
        wk.add({
            { "ih", ":<C-U>Gitsigns select_hunk<CR>", buffer = bufnr, desc = "Inner hunk", mode = { "o", "x" } },
        })
    end
})

--------------------------------------------------------------------------------
-- LSP
--------------------------------------------------------------------------------

-- Diagnostics
wk.add({
    { "<space>", group = "LSP" },
    { "<space>e", vim.diagnostic.open_float, desc = "Show error" },
    { "<space>q", vim.diagnostic.setloclist, desc = "Set loclist" },
})

-- Use an autocommand to only map the following keys after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', { }),
    callback = function(ev)
        local bufnr = ev.buf

        -- Miscellaneous
        wk.add({
            { "<C-k>", vim.lsp.buf.signature_help, desc = "Signature help" },
            { "<space>f", function() vim.lsp.buf.format { async = true } end, desc = "Format" },
            { "<space>rn", vim.lsp.buf.rename, desc = "Rename" },
            { "K", vim.lsp.buf.hover, desc = "Hover" },
            { "<space>a", vim.lsp.buf.code_action, desc = "Code action", mode = { "n", "v" } },
        })

        -- Type navigation
        wk.add({
            { "gR", function() require("trouble").toggle("lsp_references") end, buffer = bufnr, desc = "References (trouble)" },
            { "gd", telescope.lsp_definitions, buffer = bufnr, desc = "Definition" },
            { "gi", telescope.lsp_implementations, buffer = bufnr, desc = "Implementations" },
            { "gr", telescope.lsp_references, buffer = bufnr, desc = "References" },
            { "gy", telescope.lsp_type_definitions, buffer = bufnr, desc = "Type definition" },
        })

        -- Diagnostics
        wk.add({
            { "[d", vim.diagnostic.goto_prev, buffer = bufnr, desc = "Previous" },
            { "]d", vim.diagnostic.goto_next, buffer = bufnr, desc = "Next" },
        })

        -- Workspace
        wk.add({
            { "<space>w", buffer = bufnr, group = "Workspace" },
            { "<space>wa", vim.lsp.buf.add_workspace_folder, buffer = bufnr, desc = "Add folder" },
            { "<space>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, buffer = bufnr, desc = "List folders" },
            { "<space>wr", vim.lsp.buf.remove_workspace_folder, buffer = bufnr, desc = "Remove folder" },
        })

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
