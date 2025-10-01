local builtin = require('telescope.builtin')
require("telescope").load_extension("csharpls_definition")

-- File picker
vim.keymap.set('n', '<leader>ff', function(opts)
  opts = opts or {}
  opts.cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  require'telescope.builtin'.find_files(opts)
end, { desc = 'Git Grep' })

-- Browse open buffers
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find Buffers' })

-- Search help tags
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Help Tags' })
