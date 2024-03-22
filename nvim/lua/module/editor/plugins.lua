return {
    -- LSP
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            {
                "folke/neodev.nvim",
                ft = "lua",
                lazy = true,
            },
            {
                "simrat39/rust-tools.nvim",
                ft = "rust",
                lazy = true,
            },

            --Rust
            {
                "rust-lang/rust.vim",
                lazy = true,
                ft = "rust",
            },
            {

                "williamboman/mason.nvim",
            },
            {
                "williamboman/mason-lspconfig.nvim", -- simple to use language server installer
            },
            {
                "vigoux/LanguageTool.nvim" -- check grammar
            },
            {
                "weilbith/nvim-code-action-menu",
                lazy = true,
                -- event = { "User FileOpened" },
                cmd = "CodeActionMenu",
            },
            {
                'VidocqH/lsp-lens.nvim',
                event = "BufRead",
                config = function() 
                    require('lsp-lens').setup()
                end
            },
            {
                "j-hui/fidget.nvim",
                branch = "legacy",
                event = "User Fileopened",
            }, -- show the real status of lsp
            {
                "glepnir/lspsaga.nvim",
                branch = "main",
                dependencies = { "nvimdev/guard.nvim", "nvimdev/guard-collection" },
                event = "User Fileopened",
            },
            {
                "ray-x/lsp_signature.nvim",
                event = "VeryLazy",

            },

        },

    },

    {
        "RRethy/vim-illuminate",
        lazy = true,
        event = "User Fileopened",
    },

    --CMP
    {
        "hrsh7th/nvim-cmp", -- The completion plugin
        event = "VeryLazy",
        dependencies = {
            -- lspkind
            "onsails/lspkind-nvim",
            "hrsh7th/cmp-path",                   -- path completions
            "hrsh7th/cmp-cmdline",                -- cmdline completions
            "saadparwaiz1/cmp_luasnip",           -- snippet completions
            "lukas-reineke/cmp-under-comparator", -- better sorting
            "hrsh7th/cmp-calc",
            {
                "tzachar/cmp-tabnine",
                build = "./install.sh",
            },
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "f3fora/cmp-spell",
            -- snippets
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets", -- a bunch of snippets to use
        },
    },

    -- Markdown
    {
        'jghauser/follow-md-links.nvim',
        lazy = true,
        ft = "markdown",
        vim.keymap.set('n', '<bs>', ':edit #<cr>', { silent = true })
    },
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
}
