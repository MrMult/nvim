require('mini.files').setup({})

vim.keymap.set('n', '<leader>e', function()
	MiniFiles.open(vim.api.nvim_buf_get_name(0))
end, { desc = '[E]xplore' })

vim.keymap.set('n', '<leader>se', function()
	MiniFiles.synchronize()
end, { desc = '[S]ynchronize [E]xplorer'})
