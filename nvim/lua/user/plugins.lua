local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end
-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  vim.notify("packer didn't work")
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  -- colorschemes
  use 'glepnir/zephyr-nvim'
  use "marko-cerovac/material.nvim"
  use 'rose-pine/neovim'
  use 'rockerBOO/boo-colorscheme-nvim'
  use "pineapplegiant/spaceduck"
  use 'andersevenrud/nordic.nvim'
  use 'shaunsingh/nord.nvim'
  use 'folke/tokyonight.nvim'
  use "olimorris/onedarkpro.nvim"
  use "EdenEast/nightfox.nvim"
  use 'projekt0n/github-nvim-theme'
  use { "catppuccin/nvim", as = "catppuccin" }
  use "cocopon/iceberg.vim"
  use "Tsuzat/NeoSolarized.nvim"
  use "lunarvim/lunar.nvim"
  use 'norcalli/nvim-colorizer.lua'
  -- markdown
  use "mzlogin/vim-markdown-toc" -- gernerate contents 
  use { 'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview' } -- preview markdown files
  use "dhruvasagar/vim-table-mode"

  -- auto save
  use({ "Pocco81/auto-save.nvim"})
  -- accelerate j k
  use { 'rainbowhxch/accelerated-jk.nvim' }
  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use { 'tzachar/cmp-tabnine', run = './install.sh', requires = 'hrsh7th/nvim-cmp' }
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"
  use "f3fora/cmp-spell"
  use 'jc-doyle/cmp-pandoc-references'
  use "zbirenbaum/copilot.lua"
  use {
  "zbirenbaum/copilot-cmp",
  after = { "copilot.lua" },
  config = function ()
    require("copilot_cmp").setup()
  end
}

  -- lspkind
  use 'onsails/lspkind-nvim'
  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use 'hrsh7th/cmp-vsnip' --snippt engine
  use 'hrsh7th/vim-vsnip'
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use
  -- edit enhance

  use { 'numToStr/Comment.nvim', config = function() require('Comment').setup() end }
  --  use "terrortylor/nvim-comment"
  use "folke/todo-comments.nvim"
  use "folke/trouble.nvim"
  use { "windwp/nvim-autopairs", config = function() require("nvim-autopairs").setup {} end }
  use "mptre/vim-printf"  -- NOTE : :cmdPrintf<CR> 自动帮你补全输出代码 :D
  use "windwp/nvim-spectre" -- replace some words

  
  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/mason.nvim" -- simple to use language server installer
  use "williamboman/mason-lspconfig.nvim" -- simple to use language server installer
  use "jose-elias-alvarez/null-ls.nvim" -- format
  use "ray-x/lsp_signature.nvim"
  use "j-hui/fidget.nvim" -- show the real status of lsp
  use({
    "glepnir/lspsaga.nvim",
    branch = "main",
    config = function()
        require("lspsaga").setup({})
    end,
    requires = { {"nvim-tree/nvim-web-devicons"} }
})
  -- use "lukas-reineke/lsp-format.nvim"
  -- nvim tree
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }
  -- UI
  use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } }
  -- use "rcarriga/nvim-notify" -- notify
  -- use "MunifTanjim/nui.nvim" -- UI
  -- use "folke/noice.nvim"  --  NOTE: 这个插件会与lsp-signature相互冲突，bug待修，另外这个popmenu位置参数调了不知道为啥没生效;-;


  -- Telescope
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    -- or                            , branch = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }
  use "nvim-telescope/telescope-dap.nvim"
  use "nvim-telescope/telescope-ui-select.nvim"
  use "nvim-telescope/telescope-rg.nvim"
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  }
  use {
    "nvim-telescope/telescope-live-grep-args.nvim",
    commit = "9f62ecc6f6282e65adedaa3a0f18daea05664e64"
  }
  use 'nvim-telescope/telescope-media-files.nvim'
  use { "kkharji/sqlite.lua" }
  use { "nvim-telescope/telescope-frecency.nvim" }

  -- dap
  use 'mfussenegger/nvim-dap'
  use "rcarriga/nvim-dap-ui"
  use "theHamsta/nvim-dap-virtual-text"
  -- outline
  use "stevearc/aerial.nvim"
  -- treesitter
  use "nvim-treesitter/nvim-treesitter"
  use "nvim-treesitter/nvim-treesitter-context"
  use "andymass/vim-matchup"
  use "joosepalviste/nvim-ts-context-commentstring"

  -- dashboard
  use "goolord/alpha-nvim"
  -- use "glepnir/dashboard-nvim" -- TODO : 有一个显示运势，暂时不知道咋搞
  -- vim-illuminate
  use "RRethy/vim-illuminate"
  -- commend + search
  -- use "gelguy/wilder.nvim"
  use "mrjones2014/legendary.nvim"

  -- select board
  use 'stevearc/dressing.nvim'
  -- terminal
  use "akinsho/toggleterm.nvim"

  -- gps
  -- use "SmiteshP/nvim-navic"
  -- -- use "SmiteshP/nvim-gps"
  -- use { 'fgheng/winbar.nvim' }
  -- buffer
  use 'akinsho/bufferline.nvim'
  use 'ojroques/nvim-bufdel' -- close buffer
  use "lukas-reineke/indent-blankline.nvim" -- beautify indent
  use 'gen740/SmoothCursor.nvim'
  use "xiyaowong/nvim-cursorword"
  use "luukvbaal/stabilize.nvim" -- stabilize buffer events
  -- auto-command
  use 'jakelinnzy/autocmd-lua'
  -- whiick key
  use "folke/which-key.nvim"
  -- quickfix
  use "kevinhwang91/nvim-bqf"

  -- background transparent
  use "xiyaowong/nvim-transparent"

  -- translate some words
  use "voldikss/vim-translator"
  use "potamides/pantran.nvim"
  -- cmake integration
  use "Shatur/neovim-cmake"
  -- sniprun
  use "michaelb/sniprun"
  -- jump
  use "nacro90/numb.nvim"
  use {
  'phaazon/hop.nvim',
  branch = 'v2', -- optional but strongly recommended
  config = function()
    -- you can configure Hop the way you like here; see :h hop-config
    require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
  end
}
  -- start up time
  use "dstein64/vim-startuptime"
  use 'lewis6991/impatient.nvim' --optimize the startup time
  use "nathom/filetype.nvim"

  -- web search
  use "lalitmee/browse.nvim"
  -- Git
  use "lewis6991/gitsigns.nvim"
  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
  -- Window picker
  -- use {'s1n7ax/nvim-window-picker',tag = 'v1.*'}
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
