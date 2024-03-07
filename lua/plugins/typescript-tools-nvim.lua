return {
    "pmizio/typescript-tools.nvim", -- TypeScript language server
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    config = function()
        require("typescript-tools").setup {
            settings = {
                tsserver_format_options = {
                    insertSpaceAfterKeywordsInControlFlowStatements = false
                }
            }
        }
    end
}
