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
  
  "nvim-lua/popup.nvim", -- An implementation of the Popup API from vim in Neovim
  "nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins
  -- colorschemes
   "kvrohit/substrata.nvim",
  'glepnir/zephyr-nvim',
  "marko-cerovac/material.nvim",
  'rose-pine/neovim',
  'rockerBOO/boo-colorscheme-nvim',
  "pineapplegiant/spaceduck",
  'andersevenrud/nordic.nvim',
  'shaunsingh/nord.nvim',
  'folke/tokyonight.nvim',
  "olimorris/onedarkpro.nvim",
  "EdenEast/nightfox.nvim",
  'projekt0n/github-nvim-theme',
  "catppuccin/nvim", 
  "cocopon/iceberg.vim",
  "Tsuzat/NeoSolarized.nvim",
  "lunarvim/lunar.nvim",
  'norcalli/nvim-colorizer.lua',
    -- markdown
   "mzlogin/vim-markdown-toc", -- gernerate contents 
  { 'iamcco/markdown-preview.nvim', build = 'cd app && yarn install', cmd = 'MarkdownPreview', init = function() vim.g.mkdp_filetypes = {"markdown"} end, ft = {"markdown"}, } ,-- preview markdown files
  "dhruvasagar/vim-table-mode",
  -- auto save
  "Pocco81/auto-save.nvim",
  -- accelerate j k
  'rainbowhxch/accelerated-jk.nvim',
  -- cmp plugins
   "hrsh7th/nvim-cmp", -- The completion plugin
  "hrsh7th/cmp-buffer", -- buffer completions
  "hrsh7th/cmp-path", -- path completions
  "hrsh7th/cmp-cmdline", -- cmdline completions
  "saadparwaiz1/cmp_luasnip", -- snippet completions
  { 'tzachar/cmp-tabnine', build = './install.sh', dependencies = 'hrsh7th/nvim-cmp' },
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-nvim-lua",
  "f3fora/cmp-spell",
  'jc-doyle/cmp-pandoc-references',

  -- lspkind
   'onsails/lspkind-nvim',
  -- snippets
  "L3MON4D3/LuaSnip", --snippet engine
  'hrsh7th/cmp-vsnip', --snippt engine
  'hrsh7th/vim-vsnip',
  "rafamadriz/friendly-snippets", -- a bunch of snippets to use
  -- edit enhance

  { 'numToStr/Comment.nvim', config = function() require('Comment').setup() end },
  --  use "terrortylor/nvim-comment"
  "folke/todo-comments.nvim",
  "folke/trouble.nvim",
 { "windwp/nvim-autopairs", config = function() require("nvim-autopairs").setup {} end },
--  "mptre/vim-printf"  -- NOTE : :cmdPrintf<CR> 自动帮你补全输出代码 :D
--  "windwp/nvim-spectre" -- replace some words



  -- LSP
  "neovim/nvim-lspconfig", -- enable LSP
  "williamboman/mason.nvim", -- simple to use language server installer
  "williamboman/mason-lspconfig.nvim", -- simple to use language server installer
  "jose-elias-alvarez/null-ls.nvim", -- format
  "ray-x/lsp_signature.nvim",
  "j-hui/fidget.nvim", -- show the real status of lsp
  ({
    "glepnir/lspsaga.nvim",
    branch = "main",
    config = function()
        require("lspsaga").setup({})
    end,
    dependencies = { {"nvim-tree/nvim-web-devicons"} }
  }),
  -- use "lukas-reineke/lsp-format.nvim"
  -- nvim tree
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    version = 'nightly' -- optional, updated every week. (see issue #1193)
  },

  -- UI
  -- use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } }
-- 
  'glepnir/galaxyline.nvim',
  --use({"rebelot/heirline.nvim"})

   { 'yamatsum/nvim-nonicons' },
  -- use "rcarriga/nvim-notify" -- notify
  -- use "MunifTanjim/nui.nvim" -- UI
  -- use "folke/noice.nvim"  --  NOTE: 这个插件会与lsp-signature相互冲突，bug待修，另外这个popmenu位置参数调了不知道为啥没生效;-;

  -- Telescope
  {
    'nvim-telescope/telescope.nvim', version = '0.1.1',
    -- or                            , branch = '0.1.x',
    dependencies = { { 'nvim-lua/plenary.nvim' } }
  },
  "nvim-telescope/telescope-dap.nvim",
  "nvim-telescope/telescope-ui-select.nvim",
  -- use "nvim-telescope/telescope-rg.nvim"
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  },
  -- use "nvim-telescope/telescope-file-browser.nvim"
  "nvim-telescope/telescope-project.nvim",
  {
    "nvim-telescope/telescope-live-grep-args.nvim",
    commit = "9f62ecc6f6282e65adedaa3a0f18daea05664e64"
  },
  'nvim-telescope/telescope-media-files.nvim',
  { "kkharji/sqlite.lua" },
  { "nvim-telescope/telescope-frecency.nvim" },

  -- dap
   'mfussenegger/nvim-dap',
  "rcarriga/nvim-dap-ui",
  "theHamsta/nvim-dap-virtual-text",
  -- outline
  "stevearc/aerial.nvim",
  'rinx/nvim-minimap',
  -- treesitter
  "nvim-treesitter/nvim-treesitter",
  "nvim-treesitter/nvim-treesitter-context",
  "andymass/vim-matchup",
  "joosepalviste/nvim-ts-context-commentstring",

  -- dashboard
  "goolord/alpha-nvim",
  --"glepnir/dashboard-nvim", -- TODO : 有一个显示运势，暂时不知道咋搞
  -- vim-illuminate
  "RRethy/vim-illuminate",
  -- commend + search
  -- use "gelguy/wilder.nvim"
  "mrjones2014/legendary.nvim",
 
  -- select board
 'stevearc/dressing.nvim',
  -- terminal
  "akinsho/toggleterm.nvim",

  -- gps
  -- use "SmiteshP/nvim-navic"
  -- -- use "SmiteshP/nvim-gps"
  -- use { 'fgheng/winbar.nvim' }
  -- buffer
   'akinsho/bufferline.nvim',
  'ojroques/nvim-bufdel', -- close buffer
  "lukas-reineke/indent-blankline.nvim", -- beautify indent
  {
    "echasnovski/mini.indentscope",
    version = false,
    event = {"BufReadPre" , "BufNewFile"},
  }
  'gen740/SmoothCursor.nvim',
  "xiyaowong/nvim-cursorword",
  "luukvbaal/stabilize.nvim", -- stabilize buffer events
  -- auto-command
  'jakelinnzy/autocmd-lua',
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
  --"michaelb/sniprun"
  -- jump
  "nacro90/numb.nvim",
  {
    'phaazon/hop.nvim',
    version = 'v2', -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    end
  },

    -- start up time
  "dstein64/vim-startuptime",
--  'lewis6991/impatient.nvim', --optimize the startup time
--  "nathom/filetype.nvim",

  -- web search
  "lalitmee/browse.nvim",
  -- Git
  "lewis6991/gitsigns.nvim",
  { 'sindrets/diffview.nvim', dependencies = 'nvim-lua/plenary.nvim' },
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
    'glepnir/hlsearch.nvim', event = 'BufRead',
    config = function()
      require('hlsearch').setup()
    end
  },


})
