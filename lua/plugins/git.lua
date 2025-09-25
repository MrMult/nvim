-- Fugitive configuration
vim.keymap.set('n', '<leader>ga', ':Git add .<CR>', { desc = 'Git add all' })
vim.keymap.set('n', '<leader>gs', vim.cmd.Git, { desc = 'Git status' })
vim.keymap.set('n', '<leader>gb', ':Git blame<CR>', { desc = 'Git blame' })
vim.keymap.set('n', '<leader>gd', ':Gdiffsplit<CR>', { desc = 'Git diff' })
vim.keymap.set('n', '<leader>gc', ':Git commit<CR>', { desc = 'Git commit' })
vim.keymap.set('n', '<leader>gp', ':Git push<CR>', { desc = 'Git push' })
vim.keymap.set('n', '<leader>gl', ':Git pull<CR>', { desc = 'Git pull' })
vim.keymap.set('n', '<leader>gf', ':Git fetch<CR>', { desc = 'Git fetch' })

-- Gitsigns configuration
require('gitsigns').setup({
  signs = {
    add = { text = '│' },
    change = { text = '│' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    -- Navigation
    vim.keymap.set('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, { buffer = bufnr, desc = 'Next hunk' })

    vim.keymap.set('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, { buffer = bufnr, desc = 'Previous hunk' })

    -- Actions
    vim.keymap.set({'n', 'v'}, '<leader>ghs', ':Gitsigns stage_hunk<CR>', { buffer = bufnr, desc = 'Stage hunk' })
    vim.keymap.set({'n', 'v'}, '<leader>ghr', ':Gitsigns reset_hunk<CR>', { buffer = bufnr, desc = 'Reset hunk' })
    vim.keymap.set('n', '<leader>ghS', gs.stage_buffer, { buffer = bufnr, desc = 'Stage buffer' })
    vim.keymap.set('n', '<leader>ghu', gs.undo_stage_hunk, { buffer = bufnr, desc = 'Undo stage hunk' })
    vim.keymap.set('n', '<leader>ghR', gs.reset_buffer, { buffer = bufnr, desc = 'Reset buffer' })
    vim.keymap.set('n', '<leader>ghp', gs.preview_hunk, { buffer = bufnr, desc = 'Preview hunk' })
    vim.keymap.set('n', '<leader>ghb', function() gs.blame_line{full=true} end, { buffer = bufnr, desc = 'Blame line' })
  end
})

-- Diffview configuration
vim.keymap.set('n', '<leader>gdo', ':DiffviewOpen<CR>', { desc = 'Diffview open' })
vim.keymap.set('n', '<leader>gdc', ':DiffviewClose<CR>', { desc = 'Diffview close' })
vim.keymap.set('n', '<leader>gdh', ':DiffviewFileHistory<CR>', { desc = 'File history' })
vim.keymap.set('n', '<leader>gdm', ':DiffviewOpen origin/main...HEAD<CR>', { desc = 'Diffview main' })

-- LazyGit configuration
vim.keymap.set('n', '<leader>gg', ':LazyGit<CR>', { desc = 'LazyGit' })
