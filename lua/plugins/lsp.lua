require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "csharp_ls" },
})
-- Enable diagnostics with better visuals
vim.diagnostic.config({
  virtual_text = true,      -- Show inline errors
  signs = true,            -- Show signs in the gutter
  underline = true,        -- Underline errors
  update_in_insert = false, -- Don't update while typing
  severity_sort = true,    -- Sort diagnostics by severity
  float = {               -- Configuration for floating window
    border = "rounded",   -- Rounded border
    source = "always",    -- Show source of diagnostic
    header = "",          -- No header
    prefix = "",          -- No prefix
  },
})

-- Set highlight colors for diagnostics
vim.cmd [[
  highlight DiagnosticError guifg=#db4b4b
  highlight DiagnosticWarn guifg=#e0af68
  highlight DiagnosticInfo guifg=#0db9d7
  highlight DiagnosticHint guifg=#10B981
  highlight DiagnosticUnderlineError gui=undercurl guisp=#db4b4b
  highlight DiagnosticUnderlineWarn gui=undercurl guisp=#e0af68
  highlight DiagnosticUnderlineInfo gui=undercurl guisp=#0db9d7
  highlight DiagnosticUnderlineHint gui=undercurl guisp=#10B981
]]


-- Set up nvim-cmp.
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
  }),
})

-- Set configuration for cmdline
cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
  matching = { disallow_symbol_nonprefix_matching = false },
})

-- Set up lspconfig
local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.formatting = true

local lspconfig = require("lspconfig")
local util = require 'lspconfig.util'

require('lspconfig').csharp_ls.setup {
  --capabilities = capabilities,
  cmd = { 'csharp-ls' },
  root_dir = function(fname)
	  return util.find_git_ancestor(fname) or util.root_pattern('*.sln', '*.csproj')(fname)
  end,
  filetypes = { 'cs' }, 
  init_options = {
	  AutomaticWorkspaceInit = true,
    },
  }
