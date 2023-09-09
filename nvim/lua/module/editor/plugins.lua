return {
    -- LSP
    "neovim/nvim-lspconfig",             -- enable LSP
    "williamboman/mason.nvim",           -- simple to use language server installer
    "williamboman/mason-lspconfig.nvim", -- simple to use language server installer
    -- "jose-elias-alvarez/null-ls.nvim", -- format
    "ray-x/lsp_signature.nvim",
    { -- inlay_hint
        "lvimuser/lsp-inlayhints.nvim",
        lazy = true,
    },
    -- {
    --     "ahmedkhalf/lsp-rooter.nvim",
    --     event = "BufRead",
    --     config = function()
    --         require("lsp-rooter").setup()
    --     end,
    -- },
    {
        "weilbith/nvim-code-action-menu",
        lazy = true,
        -- event = { "User FileOpened" },
        cmd = "CodeActionMenu",
    },
    {
        "j-hui/fidget.nvim",
        branch = "legacy",
        lazy = true,
        event = "User Fileopened",
    }, -- show the real status of lsp

    {
        "glepnir/lspsaga.nvim",
        branch = "main",
        dependencies = { { "nvim-tree/nvim-web-devicons" }, "nvimdev/guard.nvim" },
        lazy = true,
        event = "User Fileopened",
    },
    -- lspkind
    {
        "onsails/lspkind-nvim",
        lazy = true,
        event = "User Fileopened",
    },

    -- --Clangd
    -- "p00f/clangd_extensions.nvim",

    -- vim-illuminate
    {
        "RRethy/vim-illuminate",
        lazy = true,
        event = "User Fileopened",
    },

    --CMP
    {
        "hrsh7th/nvim-cmp", -- The completion plugin
        lazy = true,
        event = { "User FileOpened" },
        dependencies = {
            "hrsh7th/cmp-buffer",       -- buffer completions
            "hrsh7th/cmp-path",         -- path completions
            "hrsh7th/cmp-cmdline",      -- cmdline completions
            "saadparwaiz1/cmp_luasnip", -- snippet completions
            {
                "tzachar/cmp-tabnine",
                build = "./install.sh",
            },
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "f3fora/cmp-spell",
            "jc-doyle/cmp-pandoc-references",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            -- snippets
            {
                "L3MON4D3/LuaSnip",
                -- follow latest release.
                version = "2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
                -- install jsregexp (optional!).
                build = "make install_jsregexp",
            },                              --snippet engine
            "hrsh7th/cmp-vsnip",            --snippt engine
            "rafamadriz/friendly-snippets", -- a bunch of snippets to use
        },
    },
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
        "norcalli/nvim-colorizer.lua",
        lazy = true,
        event = "User Fileopened",
    },
    { "folke/neodev.nvim", opts = {} },

    --Rust
    {
        "rust-lang/rust.vim",
        lazy = true,
        ft = "rust",
    },

    {
        "simrat39/rust-tools.nvim",
        ft = "rust",
        lazy = true,
        dependencies = "neovim/nvim-lspconfig",
    },
}
