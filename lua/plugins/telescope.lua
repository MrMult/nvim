local builtin = require('telescope.builtin')

-- File picker
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find Files' })

-- Live grep (search text in files)
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live Grep' })

-- Browse open buffers
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find Buffers' })

-- Search help tags
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Help Tags' })

-- Git files (ignores node_modules, etc.)
vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = 'Git Files' })

vim.keymap.set('n', '<leader>qf', vim.lsp.buf.code_action, { desc = 'Quick Fix' })
