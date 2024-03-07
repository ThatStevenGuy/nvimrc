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
    end
}
