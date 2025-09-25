local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

require("luasnip.loaders.from_vscode").lazy_load()

vim.keymap.set({"i"}, "<C-j>", function() ls.expand() end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-l>", function() ls.jump(1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-h>", function() ls.jump(-1) end, {silent = true})
