local builtin = require('telescope.builtin')
require("telescope").load_extension("csharpls_definition")

-- File picker
vim.keymap.set('n', '<leader>ff', function()
  local git_root = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
  local cwd = git_root or vim.fn.getcwd()
  require('telescope.builtin').live_grep({
    cwd = cwd,
    prompt_title = 'Git Grep in ' .. vim.fn.fnamemodify(cwd, ':t')
  })
end, { desc = 'Git Grep' })

-- Browse open buffers
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find Buffers' })

-- Search help tags
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Help Tags' })
