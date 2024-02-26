local ls = require("luasnip")
local keyset = vim.keymap.set
keyset({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
keyset({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
keyset({"i", "s"}, "<C-H>", function() ls.jump(-1) end, {silent = true})
keyset({"i", "s"}, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, { silent = true })

require("luasnip.loaders.from_vscode").lazy_load()
