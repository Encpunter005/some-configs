return {
    "nvim-lua/popup.nvim", -- An implementation of the Popup API from vim in Neovim
    {                      -- Useful lua functions used ny lots of plugins
        "nvim-lua/plenary.nvim",
        lazy = true,
    },
    { --better quickfix window
        "kevinhwang91/nvim-bqf",
        event = { "VeryLazy" },
        ft = 'qf',
    },
    {
        "MunifTanjim/nui.nvim",
        lazy = true,
    },
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true
    },
    { --better vim.ui
        "stevearc/dressing.nvim",
        lazy = true,
        init = function()
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.select = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.select(...)
            end
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.input = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.input(...)
            end
        end,
    },

    --UI
    {
        "rcarriga/nvim-notify", -- notify
        config = function()
            local notify = require("notify")
            notify.setup({
                stages = "slide",
                on_open = nil,
                timeout = 3000,
                max_width = function()
                    return math.floor(vim.o.columns * 0.75)
                end,
                max_height = function()
                    return math.floor(vim.o.lines * 0.75)
                end,
                render = "simple",
            })
        end
    },

    --color scheme

    {
        "folke/tokyonight.nvim",
        lazy = true,
        event = { "BufEnter" },
    },

    {
        "rebelot/kanagawa.nvim",
        lazy = true,
        event = { "BufEnter" },
    },

    { -- Bufferline
        "akinsho/bufferline.nvim",
        event = "VeryLazy",
        dependencies = {
            "echasnovski/mini.bufremove",
        },
        opts = {
            options = {
                separator_style = 'slant',
                -- stylua: ignore
                close_command = function(n) require("mini.bufremove").delete(n, false) end,
                -- stylua: ignore
                right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
                diagnostics = "nvim_lsp",
                always_show_bufferline = true,
                diagnostics_indicator = function(_, _, diag)
                    local icons = require("config").icons.diagnostics
                    local ret = (diag.error and icons.Error .. diag.error .. " " or "")
                        .. (diag.warning and icons.Warn .. diag.warning or "")
                    return vim.trim(ret)
                end,
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "Neo-tree",
                        highlight = "Directory",
                        text_align = "left",
                    },
                },
            },
        },
        config = function(_, opts)
            require('bufferline').setup(opts)


            -- Fix bufferline when restoring a session
            vim.api.nvim_create_autocmd("BufAdd", {
                callback = function()
                    vim.schedule(function()
                        pcall(nvim_bufferline)
                    end)
                end,
            })
        end,
    },
    {
        "nvimdev/dashboard-nvim",
        event = "VimEnter",
        opts = function()
            local opts = {
                theme = "doom",
                hide = {
                    -- this is taken care of by lualine
                    -- enabling this messes up the actual laststatus setting after loading a file
                    statusline = true,
                },
                config = {
                    header = {
                        '',
                        ' ⣇⣿⠘⣿⣿⣿⡿⡿⣟⣟⢟⢟⢝⠵⡝⣿⡿⢂⣼⣿⣷⣌⠩⡫⡻⣝⠹⢿⣿⣷ ',
                        ' ⡆⣿⣆⠱⣝⡵⣝⢅⠙⣿⢕⢕⢕⢕⢝⣥⢒⠅⣿⣿⣿⡿⣳⣌⠪⡪⣡⢑⢝⣇ ',
                        ' ⡆⣿⣿⣦⠹⣳⣳⣕⢅⠈⢗⢕⢕⢕⢕⢕⢈⢆⠟⠋⠉⠁⠉⠉⠁⠈⠼⢐⢕⢽ ',
                        ' ⡗⢰⣶⣶⣦⣝⢝⢕⢕⠅⡆⢕⢕⢕⢕⢕⣴⠏⣠⡶⠛⡉⡉⡛⢶⣦⡀⠐⣕⢕ ',
                        ' ⡝⡄⢻⢟⣿⣿⣷⣕⣕⣅⣿⣔⣕⣵⣵⣿⣿⢠⣿⢠⣮⡈⣌⠨⠅⠹⣷⡀⢱⢕ ',
                        ' ⡝⡵⠟⠈⢀⣀⣀⡀⠉⢿⣿⣿⣿⣿⣿⣿⣿⣼⣿⢈⡋⠴⢿⡟⣡⡇⣿⡇⡀⢕ ',
                        ' ⡝⠁⣠⣾⠟⡉⡉⡉⠻⣦⣻⣿⣿⣿⣿⣿⣿⣿⣿⣧⠸⣿⣦⣥⣿⡇⡿⣰⢗⢄ ',
                        ' ⠁⢰⣿⡏⣴⣌⠈⣌⠡⠈⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣬⣉⣉⣁⣄⢖⢕⢕⢕ ',
                        ' ⡀⢻⣿⡇⢙⠁⠴⢿⡟⣡⡆⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣵⣵⣿ ',
                        ' ⡻⣄⣻⣿⣌⠘⢿⣷⣥⣿⠇⣿⣿⣿⣿⣿⣿⠛⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿ ',
                        ' ⣷⢄⠻⣿⣟⠿⠦⠍⠉⣡⣾⣿⣿⣿⣿⣿⣿⢸⣿⣦⠙⣿⣿⣿⣿⣿⣿⣿⣿⠟ ',
                        ' ⡕⡑⣑⣈⣻⢗⢟⢞⢝⣻⣿⣿⣿⣿⣿⣿⣿⠸⣿⠿⠃⣿⣿⣿⣿⣿⣿⡿⠁⣠ ',
                        ' ⡝⡵⡈⢟⢕⢕⢕⢕⣵⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣶⣿⣿⣿⣿⣿⠿⠋⣀⣈⠙ ',
                        ' ⡝⡵⡕⡀⠑⠳⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠛⢉⡠⡲⡫⡪⡪⡣ ',
                        '',
                    },
                    -- stylua: ignore
                    center = {
                        { action = "Telescope find_files", desc = " Find file", icon = " ", key = "f" },
                        { action = "ene | startinsert", desc = " New file", icon = " ", key = "n" },
                        { action = "Telescope oldfiles", desc = " Recent files", icon = " ", key = "r" },
                        { action = "Telescope live_grep", desc = " Find text", icon = " ", key = "t" },
                        { action = 'lua require("persistence").load()', desc = " Restore Session", icon = " ", key = "S" },
                        { action = "Telescope colorscheme", desc = " Change colorscheme", icon = " ", key = "s" },
                        { action = ":e ~/.config/nvim/init.lua", desc = " Configure", icon = " ", key = "c" },
                        { action = "Lazy", desc = " Lazy", icon = "󰒲 ", key = "p" },
                        { action = "qa", desc = " Quit", icon = " ", key = "q" },
                    },
                    footer = function()
                        local stats = require("lazy").stats()
                        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                        return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
                    end,
                },
            }

            for _, button in ipairs(opts.config.center) do
                button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
                button.key_format = "  %s"
            end

            -- close Lazy and re-open when the dashboard is ready
            if vim.o.filetype == "lazy" then
                vim.cmd.close()
                vim.api.nvim_create_autocmd("User", {
                    pattern = "DashboardLoaded",
                    callback = function()
                        require("lazy").show()
                    end,
                })
            end

            return opts
        end,
    },

    --Better nvim-ui
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            cmdline = {
                view = "cmdline",
            },
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            routes = {
                {
                    filter = {
                        event = "msg_show",
                        any = {
                            { find = "%d+L, %d+B" },
                            { find = "; after #%d+" },
                            { find = "; before #%d+" },
                        },
                    },
                    view = "mini",
                },
            },
            presets = {
                bottom_search = true,
                command_palette = true,
                long_message_to_split = true,
                inc_rename = true,
            },
        },
    },

    { -- statusline
        "glepnir/galaxyline.nvim",
        event = 'VimEnter',
        config = function()
            local gl = require('galaxyline')
            local gls = gl.section

            local current_scheme = vim.g.colors_name
            local colors = {
                bg = "#0d0d0d",
                fg = "#b2b2b9",
                black = "#191919",
                yellow = "#E5C07B",
                cyan = "#70C0BA",
                dimblue = "#83A598",
                green = "#98C379",
                orange = "#FF8800",
                purple = "#C678DD",
                magenta = "#D27E99",
                blue = "#81A1C1",
                red = "#D54E53",
                divider = "#24242e",
            }

            if current_scheme == "everforest" then
                colors.bg = "#282E2C"
                colors.black = "#222B28"
            elseif current_scheme == "gruvbox" then
                colors.bg = "#261C00"
                colors.black = "#3A2300"
                colors.divider = "#322e2e"
            elseif current_scheme == "dawnfox" then
                colors.bg = "#898180"
                colors.black = "#625c5c"
            elseif current_scheme:match("github_light[%l_]*") then
                local custom = {
                    fg = "#24292f",
                    bg = "#bbd6ee",
                    black = "#9fc5e8",
                    yellow = "#dbab09",
                    cyan = "#0598bc",
                    green = "#28a745",
                    orange = "#d18616",
                    magenta = "#5a32a3",
                    purple = "#5a32a3",
                    blue = "#0366d6",
                    red = "#d73a49",
                }
                -- merge custom color to default
                colors = vim.tbl_deep_extend("force", {}, colors, custom)
            end

            local checkwidth = function()
                local squeeze_width = vim.fn.winwidth(0) / 2
                if squeeze_width > 50 then
                    return true
                end
                return false
            end

            local function should_activate_lsp()
                local clients = vim.lsp.get_active_clients({ bufnr = 0 })
                return checkwidth() and #clients ~= 0
            end

            local buffer_not_empty = function()
                if vim.fn.empty(vim.fn.expand("%:t")) ~= 1 then
                    return true
                end
                return false
            end

            -- insert_left insert item at the left panel
            local function insert_left(element)
                table.insert(gls.left, element)
            end

            -- insert_right insert given item into galaxyline.right
            local function insert_right(element)
                table.insert(gls.right, element)
            end

            -----------------------------------------------------
            ----------------- start insert ----------------------
            -----------------------------------------------------
            -- { mode panel start
            insert_left({
                ViMode = {
                    provider = function()
                        return " "
                    end,
                    highlight = { colors.black, colors.black },
                },
            })

            insert_left({
                ViModeIcon = {
                    provider = function()
                        -- auto change color according the vim mode
                        local alias = {
                            n = " ",
                            i = " ",
                            c = "",
                            V = "",
                            [""] = "",
                            v = "",
                            C = "",
                            ["r?"] = "?",
                            rm = "M",
                            R = "",
                            Rv = "",
                            s = "",
                            S = "",
                            ["r"] = "HIT-ENTER",
                            [""] = "",
                            t = "T",
                            ["!"] = "",
                        }

                        local mode = vim.fn.mode()
                        local vim_mode_color = {
                            n = colors.yellow,
                            i = colors.green,
                            v = colors.blue,
                            [""] = colors.blue,
                            V = colors.blue,
                            c = colors.magenta,
                            no = colors.red,
                            s = colors.orange,
                            S = colors.orange,
                            [""] = colors.orange,
                            ic = colors.yellow,
                            R = colors.purple,
                            Rv = colors.purple,
                            cv = colors.red,
                            ce = colors.red,
                            r = colors.cyan,
                            rm = colors.cyan,
                            ["r?"] = colors.cyan,
                            ["!"] = colors.red,
                            t = colors.red,
                        }

                        vim.api.nvim_set_hl(0, "GalaxyViMode", { fg = vim_mode_color[mode], bg = colors.bg })
                        return alias[mode]
                    end,
                    highlight = "GalaxyViMode",
                },
            })

            insert_left({
                EndingSepara = {
                    provider = function()
                        return " "
                    end,
                    highlight = function()
                        if should_activate_lsp() then
                            return { colors.bg, colors.black }
                        else
                            return { colors.bg, colors.divider }
                        end
                    end,
                },
            })

            insert_left({
                FileIcon = {
                    provider = "FileIcon",
                    condition = function()
                        return buffer_not_empty() and should_activate_lsp()
                    end,
                    highlight = {
                        require("galaxyline.provider_fileinfo").get_file_icon_color,
                        colors.black,
                    },
                },
            })

            insert_left({
                GetLspClient = {
                    provider = "GetLspClient",
                    condition = should_activate_lsp,
                    highlight = { colors.fg, colors.black },
                },
            })

            insert_left({
                LspSpace = {
                    provider = function()
                        return " "
                    end,
                    condition = should_activate_lsp,
                    highlight = { colors.black, colors.black },
                },
            })

            insert_left({
                DiagnosticError = {
                    provider = "DiagnosticError",
                    condition = should_activate_lsp,
                    icon = "  ",
                    highlight = { colors.red, colors.black },
                },
            })

            insert_left({
                DiagnosticWarn = {
                    provider = "DiagnosticWarn",
                    condition = should_activate_lsp,
                    icon = "  ",
                    highlight = { colors.yellow, colors.black },
                },
            })

            insert_left({
                DiagnosticInfo = {
                    provider = "DiagnosticInfo",
                    condition = should_activate_lsp,
                    highlight = { colors.green, colors.black },
                    icon = "  ",
                },
            })

            insert_left({
                DiagnosticHint = {
                    provider = "DiagnosticHint",
                    condition = should_activate_lsp,
                    highlight = { colors.white, colors.black },
                    icon = "  ",
                },
            })

            insert_left({
                LeftEnd = {
                    provider = function()
                        return ""
                    end,
                    condition = should_activate_lsp,
                    highlight = { colors.black, colors.divider },
                },
            })

            insert_left({
                MiddleSpace = {
                    provider = function()
                        return " "
                    end,
                    highlight = { colors.black, colors.divider },
                },
            })

            insert_right({
                RightStart = {
                    provider = function()
                        return " "
                    end,
                    highlight = { colors.black, colors.divider },
                },
            })

            insert_right({
                GitIcon = {
                    provider = function()
                        return "  "
                    end,
                    condition = require("galaxyline.provider_vcs").check_git_workspace,
                    highlight = { colors.fg, colors.black },
                },
            })

            insert_right({
                GitBranch = {
                    provider = "GitBranch",
                    condition = require("galaxyline.provider_vcs").check_git_workspace,
                    highlight = { colors.fg, colors.black },
                },
            })

            insert_right({
                RightSpace = {
                    provider = function()
                        return " "
                    end,
                    highlight = { colors.black, colors.black },
                },
            })

            insert_right({
                DiffAdd = {
                    provider = "DiffAdd",
                    condition = checkwidth,
                    icon = "  ",
                    highlight = { colors.green, colors.black },
                },
            })

            insert_right({
                DiffModified = {
                    provider = "DiffModified",
                    condition = checkwidth,
                    icon = "  ",
                    highlight = { colors.yellow, colors.black },
                },
            })

            insert_right({
                DiffRemove = {
                    provider = "DiffRemove",
                    condition = checkwidth,
                    icon = "  ",
                    highlight = { colors.red, colors.black },
                },
            })

            insert_right({
                RightEndingSepara = {
                    provider = function()
                        return ""
                    end,
                    highlight = { colors.bg, colors.black },
                },
            })

            insert_right({
                LineInfo = {
                    provider = "LineColumn",
                    separator = "  ",
                    separator_highlight = { colors.fg, colors.bg },
                    highlight = { colors.fg, colors.bg },
                },
            })

            insert_right({
                RightSpacing = {
                    provider = function()
                        return "   "
                    end,
                    highlight = { colors.bg, colors.bg },
                },
            })

            insert_right({
                PerCent = {
                    provider = "LinePercent",
                    condition = checkwidth,
                    highlight = { colors.fg, colors.bg },
                },
            })

            insert_right({
                RightSpacing = {
                    provider = function()
                        return "   "
                    end,
                    highlight = { colors.bg, colors.bg },
                },
            })

            insert_right({
                FileFormat = {
                    provider = "FileEncode",
                    condition = checkwidth,
                    highlight = { colors.fg, colors.bg },
                },
            })

            insert_right({
                RightEnding = {
                    provider = function()
                        return " "
                    end,
                    highlight = { colors.bg, colors.bg },
                },
            })

            -- ============================= short line ===============================

            local BufferTypeMap = {
                ["DiffviewFiles"] = " Diff View",
                ["FTerm"] = "Terminal",
                ["Mundo"] = "Mundo History",
                ["MundoDiff"] = "Mundo Diff",
                ["NeogitCommitMessage"] = " Neogit Commit",
                ["NeogitPopup"] = " Neogit Popup",
                ["NeogitStatus"] = " Neogit Status",
                ["NvimTree"] = " Tree",
                ["Outline"] = " SymbolOutline",
                ["dap-repl"] = " Dap REPL",
                ["dapui_breakpoints"] = " Dap Breakpoints",
                ["dapui_scopes"] = "כֿ Dap Scope",
                ["dapui_stacks"] = " Dap Stacks",
                ["dapui_watches"] = "ﭓ Dap Watch",
                ["fern"] = " Fern FM",
                ["neo-tree"] = " Files",
                ["fugitive"] = " Fugitive",
                ["floggraph"] = " Git Log",
                ["fugitiveblame"] = " Fugitive Blame",
                ["git"] = " Git",
                ["help"] = " Help",
                ["minimap"] = "Minimap",
                ["neoterm"] = " NeoTerm",
                ["qf"] = " Quick Fix",
                ["tabman"] = "Tab Manager",
                ["tagbar"] = "Tagbar",
                ["toggleterm"] = " ToggleTerm",
                ["Trouble"] = "ﮒ Diagnostic",
            }

            gl.short_line_list = vim.tbl_keys(BufferTypeMap)

            require("galaxyline").section.short_line_left = {
                {
                    ShortLineLeftBufferType = {
                        highlight = { colors.black, colors.cyan },
                        provider = function()
                            -- return filename for normal file
                            local get_file_name = function()
                                return string.format("%s %s", "", vim.fn.pathshorten(vim.fn.expand("%")))
                            end
                            local name = BufferTypeMap[vim.bo.filetype] or get_file_name()
                            return string.format("  %s", name)
                        end,
                        separator = " ",
                        separator_highlight = { colors.cyan, colors.bg },
                    },
                },
                {
                    ShortLineLeftWindowNumber = {
                        highlight = { colors.cyan, colors.bg },
                        provider = function()
                            return " " .. vim.api.nvim_win_get_number(vim.api.nvim_get_current_win())
                        end,
                        separator = "",
                        separator_highlight = { colors.black, colors.bg },
                    },
                },
            }
        end
    },

    {
        "shellRaining/hlchunk.nvim",
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },
        config = function()
            require('hlchunk').setup({
                chunk = {
                    enable = true,
                    notify = true,
                    use_treesitter = true,
                    -- details about support_filetypes and exclude_filetypes in https://github.com/shellRaining/hlchunk.nvim/blob/main/lua/hlchunk/utils/filetype.lua
                    chars = {
                        horizontal_line = "─",
                        vertical_line = "│",
                        left_top = "╭",
                        left_bottom = "╰",
                        right_arrow = ">",
                    },
                    style = {
                        { fg = "#61AFEF" },
                        { fg = "#c21f30" }, -- this fg is used to highlight wrong chunk
                    },
                },

                indent = {
                    enable = true,
                    use_treesitter = true,
                },

                line_num = {
                    enable = true,
                    use_treesitter = true,
                    style = "#806d9c",
                },

                blank = {
                    enable = false,
                },
            })
        end
    },
}
