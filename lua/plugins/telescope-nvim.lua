-- Documentation:
-- https://github.com/nvim-telescope/telescope.nvim?tab=readme-ov-file#usage

return {
    'nvim-telescope/telescope.nvim', -- Fuzzy finding, git & LSP operations and more
    tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local trouble = require("trouble.providers.telescope")
        require("telescope").setup {
            defaults = {
                mappings = {
                    i = { ["<c-t>"] = trouble.open_with_trouble },
                    n = { ["<c-t>"] = trouble.open_with_trouble },
                },
            },
            pickers = {
                find_files = {
                    -- hidden = true,
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
    end
}
