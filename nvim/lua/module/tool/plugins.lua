return {
    -- Support
    -- {
    --     "nathom/filetype.nvim",
    -- },
    --
    { --better quickfix window
        "kevinhwang91/nvim-bqf",
        event = {"VeryLazy"},
        ft = 'qf',
    },
    {
        's1n7ax/nvim-window-picker',
        name = 'window-picker',
        event = 'VeryLazy',
        version = '2.*',
        config = function()
            require 'window-picker'.setup()
        end,
    },

    {
        "akinsho/toggleterm.nvim",
        lazy = true,
        event = { "VeryLazy" },
        config = function()
            require("toggleterm").setup()
        end
    },

    {
        "kevinhwang91/nvim-ufo",
        event = { "User FileOpened" },
        dependencies = {
            "kevinhwang91/promise-async"
        },
    },


    {
        "xeluxee/competitest.nvim",
        lazy = true,
        event = "BufReadPre",
        config = function()
            require("competitest").setup({
                compile_command = {
                    cpp = { exec = 'g++', args = { '-std=c++20', '$(FNAME)', '-o', '$(FNOEXT)' } },
                },
                runner_ui = {
                    interface = "popup",
                },
                split_ui = {
                    position = "right",
                    relative_to_editor = true,
                    total_width = 0.3,
                    vertical_layout = {
                        { 1, "tc" },
                        { 1, { { 1, "so" }, { 1, "eo" } } },
                        { 1, { { 1, "si" }, { 1, "se" } } },
                    },
                    total_height = 0.4,
                    horizontal_layout = {
                        { 2, "tc" },
                        { 3, { { 1, "so" }, { 1, "si" } } },
                        { 3, { { 1, "eo" }, { 1, "se" } } },
                    },
                },
                view_output_diff = true,

            })
        end,
    },
    -- web search
    {
        "lalitmee/browse.nvim",
        lazy = true,
        event = "BufReadPre",
        dependencies = { "nvim-telescope/telescope.nvim" },
    },

    -- Compiler
    -- { -- This plugin
    -- 	"Zeioth/compiler.nvim",
    -- 	cmd = { "CompilerOpen", "CompilerToggleResults" },
    -- 	dependencies = { "stevearc/overseer.nvim" },
    --    lazy = true,
    -- },

    -- { -- The framework we use to run tasks
    -- 	"stevearc/overseer.nvim",
    --    lazy = true,
    -- 	commit = "3047ede61cc1308069ad1184c0d447ebee92d749", -- Recommended to to avoid breaking changes
    -- 	cmd = { "CompilerOpen", "CompilerToggleResults" },
    -- },

    {
        "voldikss/vim-translator",
        lazy = true,
        event = { "UIEnter" },
    },

    {
        "potamides/pantran.nvim",
        lazy = true,
    },

    -- {
    -- 	"michaelb/sniprun",
    -- 	build = "sh ./install.sh",
    -- 	lazy = true,
    -- },
    -- jump
    {
        "nacro90/numb.nvim",
        event = { "BufEnter" }
    },

    {
        "phaazon/hop.nvim",
        event = "BufRead",
        version = "v2", -- optional but strongly recommended
        config = function()
            -- you can configure Hop the way you like here; see :h hop-config
            require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
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

    {
        "folke/persistence.nvim",
        -- Restore last session of current dir
        lazy = true,
        event = "BufReadPre", -- this will only start session saving when an actual file was opened
    },

    { -- Highlight search
        "glepnir/hlsearch.nvim",
        event = "BufRead",
        config = function()
            require("hlsearch").setup()
        end,
    },

    -- { -- AI
    -- 	"jackMort/ChatGPT.nvim",
    -- 	event = "VeryLazy",
    -- 	dependencies = {
    -- 		"MunifTanjim/nui.nvim",
    -- 		"nvim-lua/plenary.nvim",
    -- 		"nvim-telescope/telescope.nvim",
    -- 	},
    -- },
    { -- auto save
        "Pocco81/auto-save.nvim",
        lazy = true,
        event = { "BufEnter" },
    },

    { -- accelerate j k
        "rainbowhxch/accelerated-jk.nvim",
        lazy = true,
        event = { "BufEnter" },
    },

    {
        "folke/which-key.nvim",
    },

    -- Outline
    {
        "stevearc/aerial.nvim",
        lazy = true,
        event = { "BufEnter" },
    },
    {
        "rinx/nvim-minimap",
        lazy = true,
        event = { "BufRead" },
    },

    {
        "numToStr/Comment.nvim",
        lazy = true,
        event = "BufEnter",
        config = function()
            require("Comment").setup()
        end,
    },

    {
        "folke/todo-comments.nvim",
        lazy = true,
        event = "BufEnter",
    },

    {
        "folke/trouble.nvim",
        lazy = true,
        event = "LspAttach",
    },

    {
        "windwp/nvim-autopairs",
        lazy = true,
        event = "BufEnter",
        config = function()
            require("nvim-autopairs").setup({})
        end,
    },
    -- {
    --     -- 将没有使用的变量进行暗淡处理
    --     "zbirenbaum/neodim",
    --     lazy = true,
    --     event = "LspAttach",
    -- },

    {
        "roobert/search-replace.nvim",
        lazy = true,
        cmd = {
            "SearchReplaceSingleBufferVisualSelection",
            "SearchReplaceWithinVisualSelection",
            "SearchReplaceWithinVisualSelectionCWord",
            "SearchReplaceSingleBufferSelections",
            "SearchReplaceSingleBufferCWord",
            "SearchReplaceSingleBufferCWORD",
            "SearchReplaceSingleBufferCExpr",
            "SearchReplaceSingleBufferCFile",
            "SearchReplaceMultiBufferSelections",
            "SearchReplaceMultiBufferOpen",
            "SearchReplaceMultiBufferCWord",
            "SearchReplaceMultiBufferCWORD",
            "SearchReplaceMultiBufferCExpr",
            "SearchReplaceMultiBufferCFile",
        },
    },

    { -- cmake tools
        "Shatur/neovim-cmake",
        lazy = true,
        event = "BufEnter",
    },

    -- Treesitter

    "nvim-treesitter/nvim-treesitter",
    "nvim-treesitter/nvim-treesitter-context",
    "luckasRanarison/tree-sitter-hypr",

    { -- Highlight, jump between pairs like if..else
        "andymass/vim-matchup",
        lazy = true,
        event = { "CursorMoved" },
        config = function()
            vim.g.matchup_matchparen_offscreen = { method = "popup" }
        end,
    },

    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        lazy = true,
        event = { "User FileOpened" },
    },

    {
        "chrisgrieser/nvim-various-textobjs",
        lazy = true,
        event = { "User FileOpened" },
    },

    -- File
    { -- file manager
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
    },

    {
        "is0n/fm-nvim",
        lazy = true,
        event = { "BufEnter" },
    },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-telescope/telescope-ui-select.nvim",
            event = { "BufRead" },
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build =
                "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
                event = { "BufRead" },
            },
            {
                "nvim-telescope/telescope-project.nvim",
                event = "BufWinEnter",
                setup = function()
                    vim.cmd [[packadd telescope.nvim]]
                end,
            },
            {
                "nvim-telescope/telescope-live-grep-args.nvim",
                event = { "BufRead" },
            },
            {
                "nvim-telescope/telescope-media-files.nvim",
                event = { "BufRead" },
            },
            {
                "nvim-telescope/telescope-frecency.nvim",
                event = { "BufRead" },
            },
        },
    },
    { "kkharji/sqlite.lua" },

    -- Git

    {
        "lewis6991/gitsigns.nvim",
        event = "BufEnter",
        cmd = "Gitsigns",
    },

    {
        "sindrets/diffview.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        event = "VeryLazy",
        cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    },
    {
        "windwp/nvim-spectre",
        lazy = true,
        cmd = { "Spectre" },
        config = function()
            require("spectre").setup()
        end,
    },


    -- Web-tools
    {
        "ray-x/web-tools.nvim",
        -- lazy = true,
        -- ft = { "html", "js" },
        config = function()
            require('web-tools').setup({
                keymaps = {
                    rename = nil,         -- by default use same setup of lspconfig
                    repeat_rename = '.',  -- . to repeat
                },
                hurl = {                  -- hurl default
                    show_headers = false, -- do not show http headers
                    floating = false,     -- use floating windows (need guihua.lua)
                    formatters = {        -- format the result by filetype
                        json = { 'jq' },
                        html = { 'prettier', '--parser', 'html' },
                    },
                },
            })
        end
    },
}
