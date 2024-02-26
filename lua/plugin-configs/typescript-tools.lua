require("typescript-tools").setup {
    settings = {
        tsserver_format_options = {
            insertSpaceAfterKeywordsInControlFlowStatements = false
        }
    }
}

-- Create key bindings for LSP functions that don't exist in the native LSP (yet). We'll apply these bindings
-- on a per-buffer basis so they won't interfere with non-TypeScript files.
vim.api.nvim_create_autocmd("FileType", {
    pattern = "typescript",
    callback = function()
        local keyset = vim.keymap.set
        local opts = { buffer = true }
        keyset("n", "<space>io", ":TSToolsOrganizeImports<CR>", opts)
        keyset("n", "<space>ia", ":TSToolsAddMissingImports<CR>", opts)
    end
})
