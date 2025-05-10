require("mason").setup()
require("mason-lspconfig").setup()

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

require("mason").setup()
require("mason-lspconfig").setup()

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

-- Omnisharp configuration
vim.lsp.enable('omnisharp')
require('lspconfig').omnisharp.setup {
  cmd = {
    "omnisharp",
    "--languageserver",
    "--hostPID",
    tostring(vim.fn.getpid()),
    "-z",
    "DotNet:enablePackageRestore=false",
    "--encoding",
    "utf-8",
  },
  root_dir = function(fname)
    local root_files = {
      ".sln",
      ".csproj",
      "omnisharp.json",
      "function.json",
      ".git",
    }
    return require("lspconfig.util").root_pattern(unpack(root_files))(fname)
    or vim.fn.getcwd()
  end,
  enable_roslyn_analyzers = true,
  enable_import_completion = true,
  organize_imports_on_format = true,
  enable_decompilation_support = true,
  settings = {
    FormattingOptions = {
      EnableEditorConfigSupport = true,
      OrganizeImports = true,
    },
    MsBuild = {
      LoadProjectsOnDemand = false,
    },
    RoslynExtensionsOptions = {
      EnableAnalyzersSupport = true,
      EnableImportCompletion = true,
    },
  },
}
