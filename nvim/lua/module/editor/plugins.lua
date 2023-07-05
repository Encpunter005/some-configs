return {
  	-- LSP
	"neovim/nvim-lspconfig", -- enable LSP
	"williamboman/mason.nvim", -- simple to use language server installer
	"williamboman/mason-lspconfig.nvim", -- simple to use language server installer
	"jose-elias-alvarez/null-ls.nvim", -- format
	"ray-x/lsp_signature.nvim",
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


}
