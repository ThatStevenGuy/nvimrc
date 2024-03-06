-- Documentation:
-- https://github.com/nvim-telescope/telescope.nvim?tab=readme-ov-file#usage

local trouble = require("trouble.providers.telescope")

-- Create a path display that lists filenames first followed by the parent directory
-- Credits: https://github.com/nvim-telescope/telescope.nvim/issues/2014#issuecomment-1873229658
local function filenameFirst(_, path)
	local tail = vim.fs.basename(path)
	local parent = vim.fs.dirname(path)
	if parent == "." then return tail end
	return string.format("%s\t\t%s", tail, parent)
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = "TelescopeResults",
	callback = function(ctx)
		vim.api.nvim_buf_call(ctx.buf, function()
			vim.fn.matchadd("TelescopeParent", "\t\t.*$") -- Set a highlight group for every match with two tabs
			vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" }) -- Link the highlight group to Comment
		end)
	end,
})

require("telescope").setup {
    defaults = {
        mappings = {
            i = { ["<c-t>"] = trouble.open_with_trouble },
            n = { ["<c-t>"] = trouble.open_with_trouble },
        },
    },
    pickers = {
        find_files = {
            hidden = true,
            path_display = filenameFirst,
		},
        lsp_references = {
            path_display = { "tail" }, -- Show filenames only
        },
        buffers = {
            mappings = {
                i = { ["<c-d>"] = "delete_buffer" },
                n = { ["<c-d>"] = "delete_buffer" }
            }
        }
    },
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_dropdown { }
        }
    }
}

-- The telescope-ui-select extension can list code actions among other things
require("telescope").load_extension("ui-select")

-- General keymaps
local keyset = vim.keymap.set
local builtin = require('telescope.builtin')
keyset('n', '<leader>ff', builtin.find_files, {})
keyset('n', '<leader>fg', builtin.live_grep, {})
keyset('n', '<leader>fb', builtin.buffers, {})
keyset('n', '<leader>fh', builtin.help_tags, {})
keyset('n', '<leader>fc', builtin.commands, {})

-- Git keymaps
keyset('n', '<leader>gs', builtin.git_status, {})
keyset('n', '<leader>gb', builtin.git_branches, {})
keyset('n', '<leader>gh', builtin.git_commits, {})
keyset('n', '<leader>gd', ":DiffviewOpen<Cr>", {}) -- Not telescope, but fits here
keyset('n', '<leader>gbd', ":Gdiffsplit!<Cr>", {})
keyset('n', '<leader>gbh', builtin.git_bcommits, {}) -- Alternatively, ":DiffviewFileHistory<CR>"

-- LSP keymaps
keyset('n', '<leader>fs', builtin.lsp_workspace_symbols, {})
keyset('n', '<leader>fo', builtin.lsp_document_symbols, {})
keyset('n', 'gd', builtin.lsp_definitions, {})
keyset('n', 'gy', builtin.lsp_type_definitions, {})
keyset('n', 'gr', builtin.lsp_references, {})
keyset('n', 'gi', builtin.lsp_implementations, {})

local wk = require('which-key')
wk.register({
    name = "Find",
    f = "File",
    g = "Grep",
    b = "Buffer",
    h = "Help",
    c = "Command",
    s = "Symbol",
    o = "Outline"
}, { prefix = '<leader>f' })
wk.register({
    name = "Git",
    s = "Status",
    b = "Branches",
    h = "History",
    b = "Buffer",
    bd = "Diff",
    bh = "History"
}, { prefix = "<leader>g" })
