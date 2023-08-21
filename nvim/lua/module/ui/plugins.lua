return {
    "nvim-lua/popup.nvim", -- An implementation of the Popup API from vim in Neovim
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
    -- 	"glepnir/galaxyline.nvim", -- statusline
    -- 	lazy = true,
    -- },

    {
        "freddiehaddad/feline.nvim",
        lazy = true,
    },

    {
        "yamatsum/nvim-nonicons",
        lazy = true,
    },

    "folke/noice.nvim",

    {
        "lukas-reineke/indent-blankline.nvim", -- beautify indent
        lazy = true,
        event = { "User Fileopened" },
    },

    "goolord/alpha-nvim",

    {
        "echasnovski/mini.indentscope",
        lazy = true,
        version = false,
        event = { "BufEnter" },
    },

    {
        "gen740/SmoothCursor.nvim",
        lazy = true,
        event = { "BufEnter" },
    },

    {
        "xiyaowong/nvim-cursorword",
        lazy = true,
        event = { "BufEnter" },
    },

    -- Buffer
    {
        "romgrk/barbar.nvim",
        dependencies = {
            "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
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
    },

    "ojroques/nvim-bufdel", -- close buffer

    {
        "luukvbaal/stabilize.nvim", -- stabilize buffer events
        lazy = true,
        event = { "BufEnter" },
    },

    --Colorscheme

    {
        "voidekh/kyotonight.vim",
        lazy = true,
        event = { "BufEnter" },
    },

    {
        "ray-x/aurora",
        lazy = true,
        event = { "BufEnter" },
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
        "pineapplegiant/spaceduck",
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
        "projekt0n/github-nvim-theme",
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

    {
        "Tsuzat/NeoSolarized.nvim",
        lazy = true,
        event = { "BufEnter" },
    },

    {
        "lunarvim/lunar.nvim",
        lazy = true,
        event = { "BufEnter" },
    },

    {
        "xiyaowong/transparent.nvim",
        lazy = true,
        event = { "BufEnter" },
    },
}
