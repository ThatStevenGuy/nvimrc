return {
    "folke/trouble.nvim", -- Search results & diagnostics window
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        -- Set Trouble's signs as the LSP diagnostic signs
        function firstToUpper(str)
            return (str:gsub("^%l", string.upper))
        end

        local signs = require("trouble.config").options.signs
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. firstToUpper(type)
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
         end

        -- Key bindings
        local keyset = vim.keymap.set
        keyset("n", "<leader>xx", function() require("trouble").toggle() end)
        keyset("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end)
        keyset("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end)
        keyset("n", "<leader>xq", function() require("trouble").toggle("quickfix") end)
        keyset("n", "<leader>xl", function() require("trouble").toggle("loclist") end)
        keyset("n", "gR", function() require("trouble").toggle("lsp_references") end)

        local wk = require("which-key")
        wk.register({
            name = "Trouble",
            x = "Toggle",
            w = "Workspace diagnostics",
            d = "Document diagnostics",
            q = "Quickfix",
            l = "Loclist"
        }, { prefix = "<leader>x" })
    end
}
