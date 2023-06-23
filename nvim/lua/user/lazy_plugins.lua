local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	ui = {
		border = "rounded",
		title_pos = "center",
	},
	"nvim-lua/popup.nvim", -- An implementation of the Popup API from vim in Neovim
	"nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins
	-- colorschemes
  "ray-x/aurora",
	"kvrohit/substrata.nvim",
	"glepnir/zephyr-nvim",
	"marko-cerovac/material.nvim",
	"rose-pine/neovim",
	"rockerBOO/boo-colorscheme-nvim",
	"pineapplegiant/spaceduck",
	"andersevenrud/nordic.nvim",
	"shaunsingh/nord.nvim",
	"folke/tokyonight.nvim",
	"olimorris/onedarkpro.nvim",
	"EdenEast/nightfox.nvim",
	"projekt0n/github-nvim-theme",
	"catppuccin/nvim",
	"cocopon/iceberg.vim",
	"Tsuzat/NeoSolarized.nvim",
	"lunarvim/lunar.nvim",
	"norcalli/nvim-colorizer.lua",
	-- markdown
	"mzlogin/vim-markdown-toc", -- gernerate contents
	{
		"iamcco/markdown-preview.nvim",
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
	}, -- preview markdown files
	"dhruvasagar/vim-table-mode",
	-- auto save
	"Pocco81/auto-save.nvim",
	-- accelerate j k
	"rainbowhxch/accelerated-jk.nvim",
	-- cmp plugins
	"hrsh7th/nvim-cmp", -- The completion plugin
	"hrsh7th/cmp-buffer", -- buffer completions
	"hrsh7th/cmp-path", -- path completions
	"hrsh7th/cmp-cmdline", -- cmdline completions
	"saadparwaiz1/cmp_luasnip", -- snippet completions
	{ "tzachar/cmp-tabnine", build = "./install.sh", dependencies = "hrsh7th/nvim-cmp" },
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-nvim-lua",
	"f3fora/cmp-spell",
	"jc-doyle/cmp-pandoc-references",
	"hrsh7th/cmp-nvim-lsp-signature-help",
	-- lspkind
	"onsails/lspkind-nvim",
	-- snippets
	{
		"L3MON4D3/LuaSnip",
    version= "v<CurrentMajor>.*",
		build = "make install_jsregexp",
	}, --snippet engine
	-- "hrsh7th/cmp-vsnip", --snippt engine
	"rafamadriz/friendly-snippets", -- a bunch of snippets to use
	-- edit enhance

	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},
	--  use "terrortylor/nvim-comment"
	"folke/todo-comments.nvim",
	"folke/trouble.nvim",
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},
	{
		-- 将没有使用的变量进行暗淡处理
		"zbirenbaum/neodim",
		lazy = true,
		event = "LspAttach",
		config = function()
			require("neodim").setup({
				alpha = 0.75,
				blend_color = "#000000",
				update_in_insert = {
					enable = true,
					delay = 100,
				},
				hide = {
					virtual_text = true,
					signs = false,
					underline = false,
				},
			})
		end,
	},
	--  "mptre/vim-printf"  -- NOTE : :cmdPrintf<CR> 自动帮你补全输出代码 :D
	--  "windwp/nvim-spectre" -- replace some words

	-- LSP
	"neovim/nvim-lspconfig", -- enable LSP
	"williamboman/mason.nvim", -- simple to use language server installer
	"williamboman/mason-lspconfig.nvim", -- simple to use language server installer
	"jose-elias-alvarez/null-ls.nvim", -- format
	"ray-x/lsp_signature.nvim",
  {
    "j-hui/fidget.nvim",
    version = "legacy"

  }, -- show the real status of lsp
	{
		"glepnir/lspsaga.nvim",
		branch = "main",
		config = function()
			require("lspsaga").setup({})
		end,
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},
	-- use "lukas-reineke/lsp-format.nvim"
	--file browser
	-- {
	-- 	"nvim-tree/nvim-tree.lua",
	-- 	dependencies = {
	-- 		"nvim-tree/nvim-web-devicons", -- optional, for file icons
	-- 	},
	-- 	version = "nightly", -- optional, updated every week. (see issue #1193)
	-- },
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
	},
	-- UI
	-- use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } }
	--
	--
	"glepnir/galaxyline.nvim",
	--use({"rebelot/heirline.nvim"})
	{ "yamatsum/nvim-nonicons" },
	-- "rcarriga/nvim-notify", -- notify
	-- use "MunifTanjim/nui.nvim" -- UI
	"folke/noice.nvim",
	"lukas-reineke/indent-blankline.nvim", -- beautify indent
	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		version = "0.1.1",
		-- or                            , branch = '0.1.x',
		dependencies = { { "nvim-lua/plenary.nvim" } },
	},
	"nvim-telescope/telescope-dap.nvim",
	"nvim-telescope/telescope-ui-select.nvim",
	-- use "nvim-telescope/telescope-rg.nvim"
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	},
	-- use "nvim-telescope/telescope-file-browser.nvim"
	"nvim-telescope/telescope-project.nvim",
	{
		"nvim-telescope/telescope-live-grep-args.nvim",
		commit = "9f62ecc6f6282e65adedaa3a0f18daea05664e64",
	},
	"nvim-telescope/telescope-media-files.nvim",
	{ "kkharji/sqlite.lua" },
	{ "nvim-telescope/telescope-frecency.nvim" },
	-- dap
	"mfussenegger/nvim-dap",
	"rcarriga/nvim-dap-ui",
	"theHamsta/nvim-dap-virtual-text",
	-- outline
	"stevearc/aerial.nvim",
	"rinx/nvim-minimap",
	-- { 'echasnovski/mini.map'},
	-- treesitter
	"nvim-treesitter/nvim-treesitter",
	"nvim-treesitter/nvim-treesitter-context",
	{
		"andymass/vim-matchup",
		-- Highlight, jump between pairs like if..else
		lazy = true,
		event = { "User FileOpened" },
		config = function()
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
			lvim.builtin.treesitter.matchup.enable = true
		end,
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		lazy = true,
		event = { "User FileOpened" },
	},
	-- dashboard
	"goolord/alpha-nvim",
	--"glepnir/dashboard-nvim", -- TODO : 有一个显示运势，暂时不知道咋搞
	-- vim-illuminate
	"RRethy/vim-illuminate",
	-- commend + search
	-- use "gelguy/wilder.nvim"
	"mrjones2014/legendary.nvim",
	-- select board
	"stevearc/dressing.nvim",
	-- terminal
	-- "akinsho/toggleterm.nvim",

	-- gps
	-- use "SmiteshP/nvim-navic"
	-- -- use "SmiteshP/nvim-gps"
	-- use { 'fgheng/winbar.nvim' }
	-- buffer
	"akinsho/bufferline.nvim",
	"ojroques/nvim-bufdel", -- close buffer
	{
		"echasnovski/mini.indentscope",
		version = false,
		event = { "BufReadPre", "BufNewFile" },
	},
	"gen740/SmoothCursor.nvim",
	"xiyaowong/nvim-cursorword",
	"luukvbaal/stabilize.nvim", -- stabilize buffer events
	-- auto-command
	"jakelinnzy/autocmd-lua",
	-- whiick key
	"folke/which-key.nvim",
	-- quickfix
	"kevinhwang91/nvim-bqf",
	-- translate some words
	"voldikss/vim-translator",
	"potamides/pantran.nvim",
	-- cmake integration
	"Shatur/neovim-cmake",
	-- sniprun
  {
    "michaelb/sniprun",
    build = "sh ./install.sh",
  },
	-- jump
	"nacro90/numb.nvim",
	{
		"phaazon/hop.nvim",
		version = "v2", -- optional but strongly recommended
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
		end,
	},
	-- start up time
	"dstein64/vim-startuptime",
	--  'lewis6991/impatient.nvim', --optimize the startup time
	-- "nathom/filetype.nvim",

	-- web search
	"lalitmee/browse.nvim",
	-- Git
	"lewis6991/gitsigns.nvim",
	{ "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim" },
	-- Session manager
	--   use {
	--   'rmagatti/auto-session',
	--   config = function()
	--     require("auto-session").setup {
	--       log_level = "error",
	--       auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/"},
	--     }
	--   end
	-- }
	"Shatur/neovim-session-manager",
	-- Highlight search
	{
		"glepnir/hlsearch.nvim",
		event = "BufRead",
		config = function()
			require("hlsearch").setup()
		end,
	},
	{
		--通过几个函数可以将当前neovim窗口进行全屏/垂直全屏/水平全屏/等分
		"anuvyklack/windows.nvim",
		lazy = true,
		cmd = {
			"WindowsMaximize",
			"WindowsMaximizeVertically",
			"WindowsMaximizeHorizontally",
			"WindowsEqualize",
		},
		dependencies = {
			"anuvyklack/middleclass",
			"anuvyklack/animation.nvim",
		},
		config = function()
			require("windows").setup({
				autowidth = {
					enable = false,
				},
				ignore = {
					buftype = { "quickfix" },
					filetype = {
						"neo-tree",
						"qf",
						"toggleterm",
						"alpha",
						"TelescopePrompt",
					},
				},
			})
		end,
	},
	{
		-- 打开多窗口时，在当前焦点窗口周围显示紫色边框
		"nvim-zh/colorful-winsep.nvim",
		lazy = true,
		event = "WinNew",
		config = function()
			require("colorful-winsep").setup()
		end,
	},
	--AI
	-- "github/copilot.vim",
	{
		"jackMort/ChatGPT.nvim",
		-- event = "VeryLazy",
		config = function()
			require("chatgpt").setup({
				keymaps = {
					submit = "<C-Enter>",
					yank_last_code = "<C-y>",
				},
				edit_with_instructions = {
					keymaps = {
						use_output_as_input = "<C-I>",
					},
				},
			})
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},


	},
  -- file manager
  'is0n/fm-nvim',
	-- {
	--   "xeluxee/competitest.nvim",
	--   config = function ()
	--     require("competitest").setup()
	--   end
	-- },
})
