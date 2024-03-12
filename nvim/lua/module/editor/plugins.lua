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
        },

    }, -- enable LSP
    {
        "williamboman/mason.nvim",
        dependencies = {
            "williamboman/mason-lspconfig.nvim", -- simple to use language server installer
        },
    },
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
        dependencies = { "nvim-tree/nvim-web-devicons", "nvimdev/guard.nvim", "nvimdev/guard-collection" },
        lazy = true,
        event = "User Fileopened",
    },


    {
         "ray-x/lsp_signature.nvim",
        event = "VeryLazy",

    },
    -- lspkind
    {
        "onsails/lspkind-nvim",
        lazy = true,
        event = "User Fileopened",
    },

    {
        "RRethy/vim-illuminate",
        lazy = true,
        event = "User Fileopened",
    },

    --CMP
    {
        "hrsh7th/nvim-cmp", -- The completion plugin
        event = { "InsertEnter" },
        dependencies = {
            {

                "hrsh7th/cmp-path", -- path completions
            },

            {
                "hrsh7th/cmp-cmdline", -- cmdline completions
            },

            {
                "saadparwaiz1/cmp_luasnip", -- snippet completions
            },

            {
                "lukas-reineke/cmp-under-comparator", -- better sorting
            },
            {
                "tzachar/cmp-tabnine",
                build = "./install.sh",
            },

            {
                "hrsh7th/cmp-nvim-lsp",
            },

            {
                "hrsh7th/cmp-nvim-lua",
            },

            {
                "f3fora/cmp-spell",
            },
            -- snippets
            {
                "L3MON4D3/LuaSnip",
                event = "InsertEnter",
                -- follow latest release.
                version = "2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
                -- install jsregexp (optional!).
                build = "make install_jsregexp",
                dependencies = {
                    "rafamadriz/friendly-snippets", -- a bunch of snippets to use
                },
            },                                      --snippet engine
        },
    },
    {
        "kawre/neotab.nvim",
        event = "InsertEnter",
        config = function()
            require("neotab").setup
            {
                tabkey = "<Tab>",
                act_as_tab = true, -- fallback to tab, if `tabout` action is not available
                behavior = "nested", ---@type ntab.behavior
                pairs = { ---@type ntab.pair[]
                    { open = "(", close = ")" },
                    { open = "[", close = "]" },
                    { open = "{", close = "}" },
                    { open = "'", close = "'" },
                    { open = '"', close = '"' },
                    { open = "`", close = "`" },
                    { open = "<", close = ">" },
                },
                exclude = {},
                smart_punctuators = {
                    enabled = false,
                    semicolon = {
                        enabled = false,
                        ft = { "cs", "c", "cpp", "java" },
                    },
                    escape = {
                        enabled = false,
                        triggers = {}, ---@type table<string, ntab.trigger>
                    },
                },
            }
        end,
    },
    {
        "codota/tabnine-nvim",
        name = "tabnine",
        build = vim.loop.os_uname().sysname == "Windows_NT" and "pwsh.exe -file .\\dl_binaries.ps1" or "./dl_binaries.sh",
        cmd = { "TabnineStatus", "TabnineDisable", "TabnineEnable", "TabnineToggle" },
        event = "User FileOpened",
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
