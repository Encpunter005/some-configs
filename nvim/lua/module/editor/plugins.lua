return {
	-- LSP
	"neovim/nvim-lspconfig", -- enable LSP
	"williamboman/mason.nvim", -- simple to use language server installer
	"williamboman/mason-lspconfig.nvim", -- simple to use language server installer
	"jose-elias-alvarez/null-ls.nvim", -- format
	-- "ray-x/lsp_signature.nvim",
	{
		"j-hui/fidget.nvim",
		branch = "legacy",
	}, -- show the real status of lsp

	{
		"glepnir/lspsaga.nvim",
		branch = "main",
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},
	-- lspkind
	"onsails/lspkind-nvim",

  --Clangd
  "p00f/clangd_extensions.nvim",

	-- vim-illuminate
	"RRethy/vim-illuminate",

	--CMP
	"hrsh7th/nvim-cmp", -- The completion plugin
	"hrsh7th/cmp-buffer", -- buffer completions
	"hrsh7th/cmp-path", -- path completions
	"hrsh7th/cmp-cmdline", -- cmdline completions
	"saadparwaiz1/cmp_luasnip", -- snippet completions
	{
		"tzachar/cmp-tabnine",
		build = "./install.sh",
		dependencies = "hrsh7th/nvim-cmp",
	},
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-nvim-lua",
	"f3fora/cmp-spell",
	"jc-doyle/cmp-pandoc-references",
	"hrsh7th/cmp-nvim-lsp-signature-help",
	-- snippets
	{
		"L3MON4D3/LuaSnip",
		version = "v<CurrentMajor>.*",
		build = "make install_jsregexp",
	}, --snippet engine
	-- "hrsh7th/cmp-vsnip", --snippt engine
	"rafamadriz/friendly-snippets", -- a bunch of snippets to use


  -- {
  --   "codota/tabnine-nvim",
  --   name = "tabnine",
  --   build = vim.loop.os_uname().sysname == "Windows_NT" and "pwsh.exe -file .\\dl_binaries.ps1" or "./dl_binaries.sh",
  --   cmd = { "TabnineStatus", "TabnineDisable", "TabnineEnable", "TabnineToggle" },
  --   event = "User FileOpened",
  -- },

	-- Markdown
	{ -- gernerate contents
		"mzlogin/vim-markdown-toc",
		ft = {
			"markdown",
		},
		lazy = true,
		event = "BufReadPre",
	},

	{ -- preview markdown files
		"iamcco/markdown-preview.nvim",
		lazy = true,
		event = "BufReadPre",
		build = "cd app && yarn install",
		cmd = "MarkdownPreview",
		init = function()
			vim.g.mkdp_filetypes = {
				"markdown",
			}
		end,
		ft = {
			"markdown",
		},
	},

	{ --generate a mind-map
		"Zeioth/markmap.nvim",
		build = "yarn global add markmap-cli",
		cmd = { "MarkmapOpen", "MarkmapSave", "MarkmapWatch", "MarkmapWatchStop" },
    lazy = true,
    ft = "markdown",
    event = "BufReadPre",
	},


  {
    'norcalli/nvim-colorizer.lua',
    lazy = true,
    event = "User Fileopened",
  },
  { "folke/neodev.nvim", opts = {} }
}
