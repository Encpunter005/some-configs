return {
    "nvim-lua/popup.nvim",   -- An implementation of the Popup API from vim in Neovim
    "nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins
    --UI
    {
        "rcarriga/nvim-notify", -- notify
    },

    {
        "stevearc/dressing.nvim",
        opts = {},
    },


    -- {
    --      "nvimdev/galaxyline.nvim",
    --      lazy = true,
    --      event = { "User Fileopened" },
    -- },
    {
        "MunifTanjim/nougat.nvim",
        lazy = true,
        event = { "User Fileopened" },
    },
    {
        "yamatsum/nvim-nonicons",
        lazy = true,
    },

    "folke/noice.nvim",

    {
        "lukas-reineke/indent-blankline.nvim", -- beautify indent
        main = "ibl",
        lazy = true,
        event = { "UIEnter" },
        opts = {},
    },
G
    {
        "shellRaining/hlchunk.nvim",
        event = { "UIEnter" },
    },

    {
        "goolord/alpha-nvim",
        event = { "VimEnter" },
    },
    -- {
    --     'glepnir/dashboard-nvim',
    --     event = 'VimEnter',
    --     config = function()
    --         require('dashboard').setup {
    --             -- config
    --             theme = 'hyper'
    --         }
    --     end,
    --     dependencies = { { 'nvim-tree/nvim-web-devicons' } }
    -- },

    -- {
    --     "echasnovski/mini.indentscope",
    --     lazy = true,
    --     version = false,
    --     event = { "BufEnter" },
    -- },

    {
        "gen740/SmoothCursor.nvim",
        lazy = true,
        event = { "User Fileopened" },
    },

    {
        "xiyaowong/nvim-cursorword",
        lazy = true,
        event = { "User Fileopened" },
    },

    -- Buffer
    {
        "romgrk/barbar.nvim",
        dependencies = {
            "lewis6991/gitsigns.nvim",     -- OPTIONAL: for git status
            "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
        },

        init = function()
            vim.g.barbar_auto_setup = false
        end,
        opts = {
            -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
            -- animation = true,
            -- insert_at_start = true,
            -- …etc.
        },
        version = "^1.0.0", -- optional: only update when a new 1.x version is released
        lazy = true,
    },

    "ojroques/nvim-bufdel", -- close buffer

    {
        "luukvbaal/stabilize.nvim", -- stabilize buffer events
        lazy = true,
        event = { "BufEnter" },
    },

    --Colorscheme

    {
        "embark-theme/vim",
        lazy = true,
        event = {"BufEnter"},
    },

    {
        "kvrohit/substrata.nvim",
        lazy = true,
        event = { "BufEnter" },
    },

    {
        "glepnir/zephyr-nvim",
        lazy = true,
        event = { "BufEnter" },
    },

    {
        "marko-cerovac/material.nvim",
        lazy = true,
        event = { "BufEnter" },
    },

    {
        "rose-pine/neovim",
        lazy = true,
        event = { "BufEnter" },
    },

    {
        "rockerBOO/boo-colorscheme-nvim",
        lazy = true,
        event = { "BufEnter" },
    },

    {
        "andersevenrud/nordic.nvim",
        lazy = true,
        event = { "BufEnter" },
    },

    {
        "shaunsingh/nord.nvim",
        lazy = true,
        event = { "BufEnter" },
    },

    {
        "folke/tokyonight.nvim",
        lazy = true,
        event = { "BufEnter" },
    },

    {
        "tanvirtin/monokai.nvim",
        lazy = true,
        event = { "BufEnter" },
    },

    {
        "olimorris/onedarkpro.nvim",
        lazy = true,
        event = { "BufEnter" },
    },

    {
        "EdenEast/nightfox.nvim",
        lazy = true,
        event = { "BufEnter" },
    },

    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
    },

    {
        "cocopon/iceberg.vim",
        lazy = true,
        event = { "BufEnter" },
    },
}
