vim.keymap.set('n', '<space>w', '<cmd>write<cr>', {desc = 'Save'})

vim.keymap.set({'n', 'x'}, 'gy', '"+y')
vim.keymap.set({'n', 'x'}, 'gp', '"+p')

vim.api.nvim_create_user_command("OpenConfig", function()
  vim.cmd.edit("~/.config/nvim")
end, {})

vim.api.nvim_create_user_command("OpenRepository", function()
  vim.cmd.edit("/home/mrmult/repository/")
end, {})

-- Build the project
vim.keymap.set('n', '<leader>db', '<cmd>!dotnet build<CR>', { desc = '[D]otnet [B]uild' })

-- Run the project
vim.keymap.set('n', '<leader>dr', '<cmd>!dotnet run<CR>', { desc = '[D]otnet [R]un' })

-- Run tests
vim.keymap.set('n', '<leader>dt', '<cmd>!dotnet test<CR>', { desc = '[D]otnet [T]est' })

-- Go to definition
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = '[G]oto [D]efinition' })

-- Find references
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = '[G]oto [R]eferences' })

-- Rename symbol
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = '[R]e[N]ame symbol' })

-- Format code
vim.keymap.set("n", "<leader>f", function()
	vim.lsp.buf.format({ async = true })
end, { desc = "[C]ode [F]ormat" })

