local lazy = {}

function lazy.install(path)
	if not vim.loop.fs_stat(path) then
		print('Installing lazy.nvim....')
		vim.fn.system({
			'git',
			'clone',
			'--filter=blob:none',
			'https://github.com/folke/lazy.nvim.git',
			'--branch=stable', -- latest stable release
			path,
		})
	end
end

function lazy.setup(plugins)
	if vim.g.plugins_ready then
		return
	end

	-- You can "comment out" the line below after lazy.nvim is installed
	-- lazy.install(lazy.path)

	vim.opt.rtp:prepend(lazy.path)

	require('lazy').setup(plugins, lazy.opts)
	vim.g.plugins_ready = true
end

lazy.path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
lazy.opts = {}

lazy.setup({
	{ 'nvim-lualine/lualine.nvim',        dependencies = { 'nvim-tree/nvim-web-devicons' } },
	{ "folke/tokyonight.nvim" },
	{ 'nvim-telescope/telescope.nvim',    tag = '0.1.8',                                   dependencies = { 'nvim-lua/plenary.nvim' } },
	{ "nvim-treesitter/nvim-treesitter" },
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{
		"neovim/nvim-lspconfig",
		event = "BufReadPre",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/nvim-cmp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
	},
	{ "Decodetalkers/csharpls-extended-lsp.nvim", },
	{ "aznhe21/actions-preview.nvim", },
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		}
	},
	{ "mbbill/undotree", },
	{ "tpope/vim-fugitive", },
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" }
	},
	{
		"lopi-py/luau-lsp.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"karb94/neoscroll.nvim",
		opts = {},
	},
	{
		'kdheepak/lazygit.nvim',
		dependencies = {
			'nvim-lua/plenary.nvim',
		},
	},
	{
		'sindrets/diffview.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	{
		'lewis6991/gitsigns.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	{
		'tpope/vim-fugitive',
	},
	{
		'stevearc/resession.nvim',
		opts = {},
	},
	{
		'nvim-mini/mini.nvim',
		version = false
	},
})

-- Load plugin configurations
require('plugins.lualine')
require('plugins.telescope')
require('plugins.harpoon')
require('plugins.lsp')
require('plugins.actions-preview')
require('plugins.undotree')
require('plugins.luasnip')
require('plugins.neoscroll')
require('plugins.dotnet')
require('plugins.git')
require('plugins.ressesion')
require('plugins.mini-file')
