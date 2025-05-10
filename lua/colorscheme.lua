vim.opt.termguicolors = true

require("tokyonight").setup({
  style = "night", -- or "storm", "moon", "day"
  transparent = true, -- Enable transparency
})
vim.cmd.colorscheme("tokyonight")
