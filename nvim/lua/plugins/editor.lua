return {
    -- LSP
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },
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
                cmd = "Mason",
                build = ":MasonUpdate",
                config = function()
                    local servers = {
                        "lua_ls",
                        "cssls",
                        "html",
                        "tsserver",
                        "templ",
                        "pyright",
                        "bashls",
                        "jsonls",
                        "emmet_ls",
                        "clangd",
                        "cmake",
                        "marksman",
                        "yamlls",
                        "jdtls",
                        "bashls",
                        "vimls",
                        "volar",
                        "rust_analyzer",
                        "gopls",
                    }

                    local settings = {
                        ui = {
                            border = "rounded",
                            icons = {
                                package_installed = "◍",
                                package_pending = "◍",
                                package_uninstalled = "◍",
                            },
                        },
                        log_level = vim.log.levels.INFO,
                        max_concurrent_installers = 4,
                    }

                    require("mason").setup(settings)
                    require("mason-lspconfig").setup({
                        ensure_installed = servers,
                        automatic_installation = true,
                    })


                    local lspconfig = require('lspconfig')
                    local handlers = require('utils.handlers')
                    handlers.setup()
                    for _, server in ipairs(servers) do
                        opts = {
                            on_attach = handlers.on_attach,
                            capabilities = handlers.capabilities,
                        }

                        server = vim.split(server, "@")[1]

                        local require_ok, conf_opts = pcall(require, "utils.settings." .. server)
                        if require_ok then
                            opts = vim.tbl_deep_extend("force", conf_opts, opts)
                        end

                        lspconfig[server].setup { opts }
                    end
                end
            },
            {
                "williamboman/mason-lspconfig.nvim", -- simple to use language server installer
            },
            {
                "vigoux/LanguageTool.nvim" -- check grammar
            },
            {
                'VidocqH/lsp-lens.nvim',
                event = "BufRead",
                config = function()
                    require('lsp-lens').setup()
                end
            },
            {
                "glepnir/lspsaga.nvim",
                branch = "main",
                dependencies = { "nvimdev/guard.nvim", "nvimdev/guard-collection" },
                event = "User Fileopened",
                config = function()
                    local lspsaga = require('lspsaga')
                    lspsaga.setup({
                        callhierarchy = {
                            show_detail = true,
                            keys = {
                                edit = "e",
                                vsplit = "s",
                                split = "i",
                                tabe = "t",
                                jump = "o",
                                quit = "q",
                                expand_collapse = "u",
                            },
                        },
                        beacon = {
                            enable = true,
                            frequency = 7,
                        },
                        code_action = {
                            num_shortcut = true,
                            show_server_name = false,
                            keys = {
                                -- string | table type
                                quit = "q",
                                exec = "<CR>",
                            },
                        },
                        lightbulb = {
                            enable = true,
                            enable_in_insert = true,
                            sign = true,
                            sign_priority = 40,
                            virtual_text = true,
                        },

                        outline = {
                            win_position = "right",
                            win_with = "",
                            win_width = 30,
                            show_detail = true,
                            auto_preview = true,
                            auto_refresh = true,
                            auto_close = true,
                            detail = true,
                            custom_sort = nil,
                            keys = {
                                jump = "o",
                                expand_collapse = "u",
                                quit = "q",
                            },
                        },
                        ui = {
                            -- Currently, only the round theme exists
                            theme = "round",
                            -- This option only works in Neovim 0.9
                            title = true,
                            -- Border type can be single, double, rounded, solid, shadow.
                            border = "rounded",
                            winblend = 0,
                            expand = "",
                            collapse = "",
                            preview = " ",
                            code_action = "󱧡",
                            diagnostic = "",
                            incoming = " ",
                            outgoing = " ",
                            hover = ' ',
                            kind = {},
                        },
                    })

                    local guard = require('guard')
                    local ft = require("guard.filetype")
                    ft("c", "cpp"):fmt('clang-format')
                        :lint("clang-tidy")
                    ft("lua"):fmt('lsp')
                        :lint("luacheck")
                    ft("go"):fmt('gofumpt')
                    ft("python"):fmt("lsp")
                        :lint("pylint")
                    ft("markdown", "css", "jsonc", "js", "html"):fmt("prettier")

                    guard.setup({
                        fmt_on_save = false,
                        lsp_as_default_formatter = true,
                    })
                end

            },

        },

    },

    {

        "RRethy/vim-illuminate",
        lazy = true,
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },
        opts = {
            delay = 200,
            large_file_cutoff = 2000,
            large_file_overrides = {
                providers = {
                    "lsp",
                    "treesitter",
                    "regex"
                },
            },
        },
        config = function(_, opts)
            require("illuminate").configure(opts)

            local function map(key, dir, buffer)
                vim.keymap.set("n", key, function()
                    require("illuminate")["goto_" .. dir .. "_reference"](false)
                end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
            end

            map("]]", "next")
            map("[[", "prev")

            -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    local buffer = vim.api.nvim_get_current_buf()
                    map("]]", "next", buffer)
                    map("[[", "prev", buffer)
                end,
            })
        end,
    },

    --CMP
    {
        "hrsh7th/nvim-cmp", -- The completion plugin
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-buffer",
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
            {
                "L3MON4D3/LuaSnip",
                dependencies = {
                    "rafamadriz/friendly-snippets",
                },
            },
        },


        config = function()
            local cmp, cmp_tabnine, luasnip = require('cmp'), require('cmp_tabnine.config'), require('luasnip')
            cmp_tabnine:setup({
                max_lines = 1000,
                max_num_results = 20,
                sort = true,
                run_on_every_keystroke = true,
                snippet_placeholder = '..',
                ignored_file_types = { -- default is not to ignore
                    -- uncomment to ignore in lua:
                    -- lua = true
                },
                show_prediction_strength = true,
            })

            local function border(hl_name)
                return {
                    { "┌", hl_name },
                    { "─", hl_name },
                    { "┐", hl_name },
                    { "│", hl_name },
                    { "┘", hl_name },
                    { "─", hl_name },
                    { "└", hl_name },
                    { "│", hl_name },
                }
            end

            local has_words_before = function()
                unpack = unpack or table.unpack
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and
                    vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end


            --Custom snippets
            local snippet_path = vim.fn.stdpath("config") .. "/my-snippets/"
            if not vim.tbl_contains(vim.opt.rtp:get(), snippet_path) then
                vim.opt.rtp:append(snippet_path)
            end
            require("luasnip.loaders.from_vscode").lazy_load()
            -- CMP settings
            local cmp_config = {
                confirm_opts = {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = false,
                },
                completion = {
                    completeopt = "menu,menuone,noinsert",
                },
                experimental = {
                    ghost_text = {
                        hl_group = "CmpGhostText",
                    },
                },
                view = {
                    entries = { name = 'custom' }
                },
                formatting = {
                    format = function(_, item)
                        local icons = require("config").icons.kinds
                        if icons[item.kind] then
                            item.kind = icons[item.kind] .. item.kind
                        end
                        return item
                    end,
                },
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = {
                        border = border("FloatBorder"),
                        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                        col_offset = -3,
                        side_padding = 0,
                    },
                    documentation = {
                        border = border("FloatBorder"),
                    },
                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "path" },
                    { name = "luasnip" },
                    { name = "cmp_tabnine" },
                    { name = "nvim_lua" },
                    { name = "spell" },
                    { name = "calc" },
                    { name = "treesitter" },
                    { name = "crates" },
                    { name = "luasnip" },
                    { name = "buffer" },
                },
                mapping = {
                    ["<Up>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
                    ["<Down>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
                    ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
                    ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
                    ["<C-k>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
                    ["<C-j>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
                    ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
                    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
                    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
                    ["<C-y>"] = cmp.config.disable,
                    ["<C-e>"] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close() },
                    ["<CR>"] = cmp.mapping.confirm { select = false },
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                },
            }
            cmp.setup(cmp_config)
            -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" },
                },
            })


            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "cmdline" },
                }, {
                    { name = "path" },
                }),
            })
        end
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
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true,
        -- use opts = {} for passing setup options
        -- this is equalent to setup({}) function
        opts = {
            disable_filetype = { "TelescopePrompt", "spectre_panel" },
            disable_in_macro = true, -- disable when recording or executing a macro
            disable_in_visualblock = false, -- disable when insert after visual block mode
            disable_in_replace_mode = true,
            ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
            enable_moveright = true,
            enable_afterquote = true, -- add bracket pairs after quote
            enable_check_bracket_line = true, --- check bracket in same line
            enable_bracket_in_quote = true, --
            enable_abbr = false,      -- trigger abbreviation
            break_undo = true,        -- switch for basic rule break undo sequence
            check_ts = false,
            map_cr = true,
            map_bs = true, -- map the <BS> key
            map_c_h = false, -- Map the <C-h> key to delete a pair
            map_c_w = false, -- map <c-w> to delete a pair if possible
        }
    },

    -- treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        version = false, -- last release is way too old and doesn't work on Windows
        build = ":TSUpdate",
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },
        init = function(plugin)
            -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
            -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
            -- no longer trigger the **nvim-treesitter** module to be loaded in time.
            -- Luckily, the only things that those plugins need are the custom queries, which we make available
            -- during startup.
            require("lazy.core.loader").add_to_rtp(plugin)
            require("nvim-treesitter.query_predicates")
        end,
        dependencies = {
            {
                "nvim-treesitter/nvim-treesitter-textobjects",
                config = function()
                    -- When in diff mode, we want to use the default
                    -- vim text objects c & C instead of the treesitter ones.
                    local move = require("nvim-treesitter.textobjects.move") ---@type table<string,fun(...)>
                    local configs = require("nvim-treesitter.configs")
                    for name, fn in pairs(move) do
                        if name:find("goto") == 1 then
                            move[name] = function(q, ...)
                                if vim.wo.diff then
                                    local config = configs.get_module("textobjects.move")
                                        [name] ---@type table<string,string>
                                    for key, query in pairs(config or {}) do
                                        if q == query and key:find("[%]%[][cC]") then
                                            vim.cmd("normal! " .. key)
                                            return
                                        end
                                    end
                                end
                                return fn(q, ...)
                            end
                        end
                    end
                end,
            },
        },
        cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
        ---@type TSConfig
        ---@diagnostic disable-next-line: missing-fields
        opts = {
            highlight = { enable = true },
            indent = { enable = true },
            ensure_installed = {
                "bash",
                "c",
                "cpp",
                "diff",
                "html",
                "javascript",
                "jsdoc",
                "json",
                "jsonc",
                "lua",
                "luadoc",
                "luap",
                "markdown",
                "markdown_inline",
                "python",
                "query",
                "regex",
                "toml",
                "tsx",
                "typescript",
                "vim",
                "vimdoc",
                "xml",
                "yaml",
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
            textobjects = {
                move = {
                    enable = true,
                    goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
                    goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
                    goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
                    goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
                },
            },
        },
        ---@param opts TSConfig
        config = function(_, opts)
            if type(opts.ensure_installed) == "table" then
                ---@type table<string, boolean>
                local added = {}
                opts.ensure_installed = vim.tbl_filter(function(lang)
                    if added[lang] then
                        return false
                    end
                    added[lang] = true
                    return true
                end, opts.ensure_installed)
            end
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },
        enabled = true,
        opts = { mode = "cursor", max_lines = 3 },
    },

    {
        "windwp/nvim-ts-autotag",
        event = "VeryLazy",
        opts = {},
    },

}
