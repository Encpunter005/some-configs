return {

    {
        'phaazon/hop.nvim',
        branch = 'v2', -- optional but strongly recommended
        config = function()
            -- you can configure Hop the way you like here; see :h hop-config
            require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
        end
    },

    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        dependencies = {
            "nvim-telescope/telescope-ui-select.nvim",
            "nvim-telescope/telescope-live-grep-args.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = vim.fn.executable("make") == 1 and "make"
                    or
                    "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
                enabled = vim.fn.executable("make") == 1 or vim.fn.executable("cmake") == 1,
                config = function()
                    require("telescope").load_extension("fzf")
                end,
            },
        },
        config = function()
            local telescope = require("telescope")
            vim.cmd [[

                    augroup _fold_bug_solution
                        autocmd!
                        autocmd Bufread * autocmd BufWinEnter * ++once normal! zx
                    augroup end

                    ]]
            telescope.setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {
                            -- even more opts
                        }
                    },
                    file_browser = {
                        theme = "ivy",
                        hijack_netrw = true,
                    },
                    live_grep_raw = {
                        auto_quoting = true, -- enable/disable auto-quotingtele
                    }
                },
                telescope.load_extension("ui-select"),
                telescope.load_extension("live_grep_args"),
                telescope.load_extension("notify"),
            })
        end

    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        cmd = "Neotree",
        deactivate = function()
            vim.cmd([[Neotree close]])
        end,
        init = function()
            if vim.fn.argc(-1) == 1 then
                local stat = vim.uv.fs_stat(vim.fn.argv(0))
                if stat and stat.type == "directory" then
                    require("neo-tree")
                end
            end
        end,

        config = function()
            require('neo-tree').setup({
                sources = { "filesystem", "buffers", "git_status", "document_symbols" },
                open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
                close_if_last_window = true,
                popup_border_style = "rounded",
                enable_git_status = true,
                enable_diagnostics = true,
                filesystem = {
                    hide_dotfiles = false,
                    hide_hidden = false,
                    bind_to_cwd = false,
                    follow_current_file = { enabled = true },
                    use_libuv_file_watcher = true,
                    visible = true,
                    hide_gitignored = true,
                },
                window = {
                    width = 30,
                    close_if_last_window = true,
                    popup_border_style = "rounded",
                    enable_git_status = true,
                    enable_diagnostics = true,
                    mappings = {
                        ["<space>"] = "none",
                        ["Y"] = {
                            function(state)
                                local node = state.tree:get_node()
                                local path = node:get_id()
                                vim.fn.setreg("+", path, "c")
                            end,
                            desc = "copy path to clipboard",
                        },
                    },
                },
                default_component_configs = {
                    indent = {
                        indent_size = 2,
                        with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
                        expander_collapsed = "",
                        expander_expanded = "",
                        expander_highlight = "NeoTreeExpander",
                    },
                },
                source_selector = {
                    winbar = true,
                    show_scrolled_off_parent_node = false, -- this will replace the tabs with the parent path
                },
            })
        end
    },
    {
        "folke/persistence.nvim",
        event = "BufReadPre",
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            local which_key = require('which-key')
            local setup = {
                plugins = {
                    marks = false,    -- shows a list of your marks on ' and `
                    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
                    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
                    -- No actual key bindings are created
                    presets = {
                        operators = false,                           -- adds help for operators like d, y, ... and registers them for motion / text object completion
                        motions = true,                              -- adds help for motions
                        text_objects = false,                        -- help for text objects triggered after entering an operator
                        windows = true,                              -- default bindings on <c-w>
                        nav = true,                                  -- misc bindings to work with windows
                        z = false,                                   -- bindings for folds, spelling and others prefixed with z
                        g = false,                                   -- bindings for prefixed with g
                    },
                    spelling = { enabled = true, suggestions = 20 }, -- use whick-key for spelling hints
                },
                -- add operators that will trigger motion and text object completion
                -- to enable all native operators, set the preset / operators plugin above
                --  operators = { gc = "Comments" },
                key_labels = {
                    -- override the label used to display some keys. It doesn't effect WK in any other way.
                    -- For example:
                    -- ["<space>"] = "SPC",
                    -- ["<cr>"] = "RET",
                    -- ["<tab>"] = "TAB",
                },
                icons = {
                    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
                    separator = "➜", -- symbol used between a key and it's label
                    group = "+", -- symbol prepended to a group
                },
                popup_mappings = {
                    scroll_down = "<c-d>", -- binding to scroll down inside the popup
                    scroll_up = "<c-u>",   -- binding to scroll up inside the popup
                },
                window = {
                    border = "rounded",       -- none, single, double, shadow
                    position = "bottom",      -- bottom, top
                    margin = { 1, 0, 1, 0 },  -- extra window margin [top, right, bottom, left]
                    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
                    winblend = 0,
                },
                layout = {
                    height = { min = 4, max = 25 },                                           -- min and max height of the columns
                    width = { min = 20, max = 50 },                                           -- min and max width of the columns
                    spacing = 3,                                                              -- spacing between columns
                    align = "left",                                                           -- align columns left, center or right
                },
                ignore_missing = true,                                                        -- enable this to hide mappings for which you didn't specify a label
                hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
                show_help = true,                                                             -- show help message on the command line when the popup is visible
                triggers = "auto",                                                            -- automatically setup triggers
                -- triggers = {"<leader>"} -- or specify a list manually
                triggers_blacklist = {
                    -- list of mode / prefixes that should never be hooked by WhichKey
                    -- this is mostly relevant for key maps that start with a native binding
                    -- most people should not need to change this
                    i = { "j", "k" },
                    v = { "j", "k" },
                },
            }

            local opts = {
                mode = "n",     -- NORMAL mode
                prefix = "<Space>",
                buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
                silent = true,  -- use `silent` when creating keymaps
                noremap = true, -- use `noremap` when creating keymaps
                nowait = true,  -- use `nowait` when creating keymaps
            }
            local vopts = {
                mode = "v",
                prefix = "<Space>",
                buffer = nil,
                silent = true,
                noremap = true,
                nowait = true,
            }

            local vmappings = {
                ["/"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment toggle" },
                ["t"] = { "<cmd>TranslateW<cr>,", "Translate" },
            }

            local mappings = {
                ["a"] = { "<cmd>Alpha<cr>", "Welcome" },
                ["r"] = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
                ["p"] = { "<cmd>Lazy<cr>", "Plugins" },
                ["["] = { "<cmd>BufferLineCycleNext<cr>", "Move next buffer" },
                ["]"] = { "<cmd>BufferLineCyclePrev<cr>", "Move prev buffer" },
                -- ["b"] = {
                --   "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
                --   "Buffers",
                -- },
                ["e"] = { "<cmd>Neotree toggle<cr>", "Explorer" },
                -- ["w"] = { "<cmd>w!<CR>", "Save" },
                ["q"] = { "<cmd>q!<CR>", "Quit" },
                ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
                -- ["S"] = { "<cmd>SessionManager save_current_session<CR>", "Save session" },
                -- ["L"] = { "<cmd>Lazy<cr> ", "Lazy" },
                -- ["F"] = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },

                -- ["p"] = { "<cmd>SessionManager load_session<cr>", "Projects" },

                -- ["t"] = {
                --   "<cmd>UltestSummary<CR>", "Unit Test"
                -- },
                s = {
                    name = "Support",
                    t = { "<cmd>TranslateW<cr>", "Translate" },
                    p = { "<cmd>Printf<CR>", "Print" },
                    o = { "<cmd>Lspsaga outline<cr>", "Outline" },
                    s = { "<cmd>BrowseInputSearch<cr>", "WebSearch" },
                    b = { "<cmd>BrowseBookmarks<cr>", "BookMarkSearch" },
                    w = { "<cmd>Pantran<CR>", "Sentences" },
                    m = { "<cmd>MinimapToggle<cr>", "Show minimap window" },
                },
                m = {
                    name = "Markdown",
                    p = { "<cmd>MarkdownPreview<cr>", "Preview" },
                    c = { "<cmd>GenTocGFM<cr>", "Generate a content" },
                    r = { "<cmd>RemoveToc<cr>", "Remove table" },
                    u = { "<cmd>UpdateToc<cr>", "Update content" },
                    t = { "<cmd>TableModeToggle<cr>", "Creat Table" },
                    o = { "<cmd>AerialToggle!<CR>", "Outline" },
                    m = { "<cmd>MarkmapOpen<CR>", "Mindmap" },
                },
                -- ["v"] = {
                --   "<cmd>lua require('telescope').extensions.neoclip.default(require('telescope.themes').get_ivy())<cr>",
                --   "Clipboard Manager"
                -- },
                f = {
                    name = "Telescope",
                    f = { "<cmd>Telescope find_files<cr>", "Find_files" },
                    c = { "<cmd>Telescope colorscheme<cr>", "Colorschme" },
                    r = { "<cmd>Telescope oldfiles<cr>", "Open recent files" },
                    t = { "<cmd>Telescope live_grep<cr>", "Search words" },
                    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
                    C = { "<cmd>Telescope commands<cr>", "Commands" },
                    h = { "<cmd>Telescope highlights<cr>", "Find hightlight groups" },
                    R = { "<cmd>Telescope registers<cr>", "Registers" },
                    p = { "<cmd>Telescope project<cr>", "Projects" },
                    l = { "<cmd>Legendars<cr>", "Details of commends" },
                    n = { "<cmd>Telescope notify<CR>", "Notifications" },
                },
                j = {
                    name = "Hop",
                    w = { "<cmd>HopWord<CR>", "Jump a word" },
                    s = { "<cmd>HopLine<CR>", "Jump a line" },
                },
                c = {
                    name = "CMake",
                    g = { "<cmd>CMakeGenerate<cr>", "Create Project" },
                    b = { "<cmd>CMakeBuild<cr>", "Build Project" },
                    r = { "<cmd>CMakeRun<cr>", "Run Project" },
                    t = { "<cmd>CMakeRunTest<cr>", "Test Project" },
                },
                C = {
                    name = "CompetiTest",
                    a = { "<cmd>CompetiTest receive testcases<CR>", "Receive Test cases" },
                    d = { "<cmd>CompetiTest delete<CR>", "Delete Test cases" },
                    r = { "<cmd>CompetiTest run<CR>", "Run Test cases" },
                },

                d = {
                    name = "Debug",
                    t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
                    b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
                    c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
                    C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
                    g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
                    i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
                    o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
                    u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
                    p = { "<cmd>lua require'dap'.pause()<cr>", "Pause" },
                    r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
                    s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
                    q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
                    U = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
                },

                t = {
                    name = "Trouble",
                    t = { "<cmd>Trouble<cr>", "ToggleTrouble" },
                    d = { "<cmd>Trouble document_diagnostics<cr>", "Document Diagnostics" },
                    w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
                    q = { "<cmd>Trouble quickfix<cr>", "Quick Fix" },
                    c = { "<cmd>TodoTrouble<cr>", "Todo-comment" },
                },

                b = {
                    name = "Buffers",
                    j = { "<cmd>BufferPick<cr>", "Jump" },
                    f = { "<cmd>Telescope buffers<cr>", "Find" },
                    d = {
                        "<cmd>BufferOrderByDirectory<cr>",
                        "Sort by directory",
                    },
                    l = {
                        "<cmd>BufferOrderByLanguage<cr>",
                        "Sort by Relative Directory",
                    },
                },
                g = {
                    name = "Git",
                    f = { "<cmd>DiffviewFileHistory<CR>", "File History" },
                    p = { "<cmd>DiffviewOpen<CR>", "Diff Project" },
                    n = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
                    N = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
                    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
                    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
                    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
                    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
                    S = { "<cmd>lua require 'gitsigns'.stage_buffer()<cr>", "Stage Hunk" },
                    u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" },
                    U = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" },
                    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
                    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
                    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
                    d = {
                        "<cmd>Gitsigns diffthis HEAD<cr>",
                        "Diff",
                    },
                },
                R = {
                    name = "Spectre",
                    o = { "<cmd>lua require('spectre').open()<cr>", "Spectre Open" },
                    w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Spectre in Visual Word" },
                    v = { "<esc><cmd>lua require('spectre').open_visual()<CR>", "Spectre in Visual" },
                    f = { "viw<cmd>lua require('spectre').open_file_search()<CR>", "Spectre in File" },
                },

                l = {
                    name = "LSP",
                    a = { "<cmd>Lspsaga code_action<CR>", "Code Action" },
                    c = { "<cmd>Lspsaga incoming_calls ++normal<CR>", "Callhierarchy" },
                    d = {
                        "<cmd>Telescope diagnostics<cr>",
                        "Diagnostics",
                    },
                    h = { "<cmd>lua require('lsp-inlayhints').toggle()<CR>", "Enable Inlayhints" },
                    f = { "<cmd>GuardFmt<CR>", "Format" },
                    w = {
                        "<cmd>Telescope lsp_workspace_diagnostics<cr>",
                        "Workspace Diagnostics",
                    },
                    i = { "<cmd>LspInfo<cr>", "Info" },
                    j = {
                        "<cmd>Lspsaga diagnostic_jump_next<CR>",
                        "Next Diagnostic",
                    },
                    k = {
                        "<cmd>Lspsaga diagnostic_jump_prev<CR>",
                        "Prev Diagnostic",
                    },
                    g = { "<cmd>Lspsaga goto_definition<CR>", "Goto definition" },
                    K = { "<cmd>Lspsaga hover_doc<CR>", "Signature" },
                    r = { "<cmd>Lspsaga rename<CR>", "Rename" },
                    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
                    p = { "<cmd>Lspsaga peek_definition<CR>", "Peek_definition" },
                    F = { "<cmd>Lspsaga finder def+ref<CR>", "Reference" },
                    u = { "<cmd>Trouble lsp_references<cr>", "Usage" },
                    q = { "<cmd>lua vim.diagnostic.setloclist()<CR>", "Set diagnostic list" },
                },
                w = {
                    name = "Windows",
                    m = { "<cmd>WindowsMaximize<CR>", "Window Maximize" },
                    v = { "<cmd>WindowsMaximizeVertically<CR>", "Window Vertically Maximize" },
                    h = { "<cmd>WindowsMaximizeHorizontally<CR>", "Window Horizontally Maximize" },
                    e = { "<cmd>WindowsEqualize<CR>", "Window Equalize" },
                    s = { "<cmd>vsplit<CR>", "Window Vertical Split" },
                    V = { "<cmd>split<CR>", "Window Split" },
                },
            }

            which_key.setup(setup)
            which_key.register(mappings, opts)
            which_key.register(vmappings, vopts)
        end
    },

    {
        "folke/trouble.nvim",
        cmd = { "TroubleToggle", "Trouble" },
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },
        opts = { use_diagnostic_signs = true },
    },

    {
        "folke/todo-comments.nvim",
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },
        opts = {},
    },
    {
        "folke/persistence.nvim",
        event = "BufReadPre",
        opts = { options = vim.opt.sessionoptions:get() },
    },


    --Cmake
    {
        "Civitasv/cmake-tools.nvim",
        lazy = true,
        ft = { 'cpp', c },
        init = function()
            local loaded = false
            local function check()
                local cwd = vim.uv.cwd()
                if vim.fn.filereadable(cwd .. "/CMakeLists.txt") == 1 then
                    require("lazy").load({ plugins = { "cmake-tools.nvim" } })
                    loaded = true
                end
            end
            check()
            vim.api.nvim_create_autocmd("DirChanged", {
                callback = function()
                    if not loaded then
                        check()
                    end
                end,
            })
        end,
        opts = {
            cmake_command = "cmake",                                          -- this is used to specify cmake command path
            ctest_command = "ctest",                                          -- this is used to specify ctest command path
            cmake_regenerate_on_save = true,                                  -- auto generate when save CMakeLists.txt
            cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" }, -- this will be passed when invoke `CMakeGenerate`
            cmake_build_options = {},                                         -- this will be passed when invoke `CMakeBuild`
            -- support macro expansion:
            --       ${kit}
            --       ${kitGenerator}
            --       ${variant:xx}
            cmake_build_directory = "out/${variant:buildType}", -- this is used to specify generate directory for cmake, allows macro expansion, relative to vim.loop.cwd()
            cmake_soft_link_compile_commands = true,            -- this will automatically make a soft link from compile commands file to project root dir
            cmake_compile_commands_from_lsp = false,            -- this will automatically set compile commands file location using lsp, to use it, please set `cmake_soft_link_compile_commands` to false
            cmake_kits_path = nil,                              -- this is used to specify global cmake kits path, see CMakeKits for detailed usage
            cmake_variants_message = {
                short = { show = true },                        -- whether to show short message
                long = { show = true, max_length = 40 },        -- whether to show long message
            },
            cmake_dap_configuration = {                         -- debug settings for cmake
                name = "cpp",
                type = "codelldb",
                request = "launch",
                stopOnEntry = false,
                runInTerminal = true,
                console = "integratedTerminal",
            },
            cmake_executor = {                          -- executor to use
                name = "quickfix",                      -- name of the executor
                opts = {},                              -- the options the executor will get, possible values depend on the executor type. See `default_opts` for possible values.
                default_opts = {                        -- a list of default and possible values for executors
                    quickfix = {
                        show = "always",                -- "always", "only_on_error"
                        position = "belowright",        -- "vertical", "horizontal", "leftabove", "aboveleft", "rightbelow", "belowright", "topleft", "botright", use `:h vertical` for example to see help on them
                        size = 10,
                        encoding = "utf-8",             -- if encoding is not "utf-8", it will be converted to "utf-8" using `vim.fn.iconv`
                        auto_close_when_success = true, -- typically, you can use it with the "always" option; it will auto-close the quickfix buffer if the execution is successful.
                    },
                    toggleterm = {
                        direction = "float",   -- 'vertical' | 'horizontal' | 'tab' | 'float'
                        close_on_exit = false, -- whether close the terminal when exit
                        auto_scroll = true,    -- whether auto scroll to the bottom
                    },
                    overseer = {
                        new_task_opts = {
                            strategy = {
                                "toggleterm",
                                direction = "horizontal",
                                autos_croll = true,
                                quit_on_exit = "success"
                            }
                        }, -- options to pass into the `overseer.new_task` command
                        on_new_task = function(task)
                            require("overseer").open(
                                { enter = false, direction = "right" }
                            )
                        end, -- a function that gets overseer.Task when it is created, before calling `task:start`
                    },
                    terminal = {
                        name = "Main Terminal",
                        prefix_name = "[CMakeTools]: ", -- This must be included and must be unique, otherwise the terminals will not work. Do not use a simple spacebar " ", or any generic name
                        split_direction = "horizontal", -- "horizontal", "vertical"
                        split_size = 11,

                        -- Window handling
                        single_terminal_per_instance = true,  -- Single viewport, multiple windows
                        single_terminal_per_tab = true,       -- Single viewport per tab
                        keep_terminal_static_location = true, -- Static location of the viewport if avialable

                        -- Running Tasks
                        start_insert = false,       -- If you want to enter terminal with :startinsert upon using :CMakeRun
                        focus = false,              -- Focus on terminal when cmake task is launched.
                        do_not_add_newline = false, -- Do not hit enter on the command inserted when using :CMakeRun, allowing a chance to review or modify the command before hitting enter.
                    },                              -- terminal executor uses the values in cmake_terminal
                },
            },
            cmake_runner = {                     -- runner to use
                name = "terminal",               -- name of the runner
                opts = {},                       -- the options the runner will get, possible values depend on the runner type. See `default_opts` for possible values.
                default_opts = {                 -- a list of default and possible values for runners
                    quickfix = {
                        show = "always",         -- "always", "only_on_error"
                        position = "belowright", -- "bottom", "top"
                        size = 10,
                        encoding = "utf-8",
                        auto_close_when_success = true, -- typically, you can use it with the "always" option; it will auto-close the quickfix buffer if the execution is successful.
                    },
                    toggleterm = {
                        direction = "float",   -- 'vertical' | 'horizontal' | 'tab' | 'float'
                        close_on_exit = false, -- whether close the terminal when exit
                        auto_scroll = true,    -- whether auto scroll to the bottom
                    },
                    overseer = {
                        new_task_opts = {
                            strategy = {
                                "toggleterm",
                                direction = "horizontal",
                                autos_croll = true,
                                quit_on_exit = "success"
                            }
                        },   -- options to pass into the `overseer.new_task` command
                        on_new_task = function(task)
                        end, -- a function that gets overseer.Task when it is created, before calling `task:start`
                    },
                    terminal = {
                        name = "Main Terminal",
                        prefix_name = "[CMakeTools]: ", -- This must be included and must be unique, otherwise the terminals will not work. Do not use a simple spacebar " ", or any generic name
                        split_direction = "horizontal", -- "horizontal", "vertical"
                        split_size = 11,

                        -- Window handling
                        single_terminal_per_instance = true,  -- Single viewport, multiple windows
                        single_terminal_per_tab = true,       -- Single viewport per tab
                        keep_terminal_static_location = true, -- Static location of the viewport if avialable

                        -- Running Tasks
                        start_insert = false,       -- If you want to enter terminal with :startinsert upon using :CMakeRun
                        focus = false,              -- Focus on terminal when cmake task is launched.
                        do_not_add_newline = false, -- Do not hit enter on the command inserted when using :CMakeRun, allowing a chance to review or modify the command before hitting enter.
                    },
                },
            },
            cmake_notifications = {
                runner = { enabled = true },
                executor = { enabled = true },
                spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }, -- icons used for progress display
                refresh_rate_ms = 100, -- how often to iterate icons
            },
        },
    },


    --DAP
    {
        "mfussenegger/nvim-dap",
        lazy = true,
        event = { "VeryLazy" },
        dependencies = {
            "mfussenegger/nvim-dap-python",
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
            "nvim-neotest/neotest",
            "nvim-neotest/neotest-python",
            "nvim-neotest/nvim-nio",
        },
        config = function()
            require('utils.dap')
        end
    },

    -- fold
    {
        "kevinhwang91/nvim-ufo",
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },
        dependencies = {
            "kevinhwang91/promise-async"
        },

        config = function()
            -- Option 2: nvim lsp as LSP client
            -- Tell the server the capability of foldingRange,
            -- Neovim hasn't added foldingRange to default capabilities, users must add it manually
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
            }
            local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
            for _, ls in ipairs(language_servers) do
                require("lspconfig")[ls].setup({
                    capabilities = capabilities,
                    -- you can add other fields for setting up lsp server in this table
                })
            end

            local handler = function(virtText, lnum, endLnum, width, truncate)
                local newVirtText = {}
                local suffix = (" 󰁂 %d "):format(endLnum - lnum)
                local sufWidth = vim.fn.strdisplaywidth(suffix)
                local targetWidth = width - sufWidth
                local curWidth = 0
                for _, chunk in ipairs(virtText) do
                    local chunkText = chunk[1]
                    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    if targetWidth > curWidth + chunkWidth then
                        table.insert(newVirtText, chunk)
                    else
                        chunkText = truncate(chunkText, targetWidth - curWidth)
                        local hlGroup = chunk[2]
                        table.insert(newVirtText, { chunkText, hlGroup })
                        chunkWidth = vim.fn.strdisplaywidth(chunkText)
                        -- str width returned from truncate() may less than 2nd argument, need padding
                        if curWidth + chunkWidth < targetWidth then
                            suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
                        end
                        break
                    end
                    curWidth = curWidth + chunkWidth
                end
                table.insert(newVirtText, { suffix, "MoreMsg" })
                return newVirtText
            end

            -- global handler
            -- `handler` is the 2nd parameter of `setFoldVirtTextHandler`,
            -- check out `./lua/ufo.lua` and search `setFoldVirtTextHandler` for detail.

            require("ufo").setup({
                open_fold_hl_timeout = 0,
                fold_virt_text_handler = handler,
                preview = {
                    win_config = {
                        border       = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
                        winblend     = 0,
                        winhighlight = "Normal:LazyNormal",
                    },
                    mappings = {
                        scrollU = "<C-u>",
                        scrollD = "<C-d>",
                        jumpTop = "[",
                        jumpBot = "]",
                    },
                },
            })
            vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
            vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
            vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
            vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
        end
    },

    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },
        opts = {
            signs = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "" },
                topdelete = { text = "" },
                changedelete = { text = "▎" },
                untracked = { text = "▎" },
            },
            signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
            numhl = true,      -- Toggle with `:Gitsigns toggle_numhl`
            linehl = false,    -- Toggle with `:Gitsigns toggle_linehl`
            word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
            watch_gitdir = {
                interval = 1000,
                follow_files = true,
            },
            attach_to_untracked = true,
            current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
                delay = 100,
                ignore_whitespace = false,
            },
            current_line_blame_formatter_opts = {
                relative_time = false,
            },
            sign_priority = 6,
            update_debounce = 100,
            status_formatter = nil, -- Use default
            max_file_length = 40000,
            preview_config = {
                -- Options passed to nvim_open_win
                border = "rounded",
                style = "minimal",
                relative = "cursor",
                row = 0,
                col = 1,
            },
            yadm = {
                enable = false,
            },
            -- keymapping
            on_attach = function(bufnr)
                local function map(mode, lhs, rhs, opts)
                    opts = vim.tbl_extend("force", { noremap = true, silent = true }, opts or {})
                    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
                end
            end,
        },
    },


    {
        "sindrets/diffview.nvim",
        event = "VeryLazy",
        cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
        config = function()
            require 'diffview'.setup {}
        end
    },

    {
        "nacro90/numb.nvim",
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    },

    { -- auto save
        "Pocco81/auto-save.nvim",
        lazy = true,
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },
        config = function()
            local auto_save = require('auto-save')
            auto_save.setup({
                enabled = true,          -- start auto-save when the plugin is loaded (i.e. when your package manager loads it)
                execution_message = {
                    message = function() -- message to print on save
                        return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
                    end,
                    dim = 0.18,                                    -- dim the color of `message`
                    cleaning_interval = 1250,                      -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
                },
                trigger_events = { "InsertLeave", "TextChanged" }, -- vim events that trigger auto-save. See :h events
                -- function that determines whether to save the current buffer or not
                -- return true: if buffer is ok to be saved
                -- return false: if it's not ok to be saved
                condition = function(buf)
                    local fn = vim.fn
                    local utils = require("auto-save.utils.data")

                    if fn.getbufvar(buf, "&modifiable") == 1 and utils.not_in(fn.getbufvar(buf, "&filetype"), {}) then
                        return true              -- met condition(s), can save
                    end
                    return false                 -- can't save
                end,
                write_all_buffers = false,       -- write all buffers when the current one meets `condition`
                debounce_delay = 135,            -- saves the file at most every `debounce_delay` milliseconds
                callbacks = {                    -- functions to be executed at different intervals
                    enabling = nil,              -- ran when enabling auto-save
                    disabling = nil,             -- ran when disabling auto-save
                    before_asserting_save = nil, -- ran before checking `condition`
                    before_saving = nil,         -- ran before doing the actual save
                    after_saving = nil,          -- ran after doing the actual save
                },
            })
        end
    },




    {
        "numToStr/Comment.nvim",
        lazy = true,
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },
        config = function()
            require("Comment").setup({

                pre_hook = function(ctx)
                    local U = require "Comment.utils"

                    local status_utils_ok, utils = pcall(require, "ts_context_commentstring.utils")
                    if not status_utils_ok then
                        return
                    end

                    local location = nil
                    if ctx.ctype == U.ctype.block then
                        location = utils.get_cursor_location()
                    elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
                        location = utils.get_visual_start_location()
                    end

                    local status_internals_ok, internals = pcall(require, "ts_context_commentstring.internals")
                    if not status_internals_ok then
                        return
                    end

                    return internals.calculate_commentstring {
                        key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
                        location = location,
                    }
                end,
            })
        end,
    },

    {
        "xeluxee/competitest.nvim",
        lazy = true,
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },
        ft = 'cpp',
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
        config = function()
            local browse = require('browse')
            browse.setup({
                provider = "bing",
            })
            local bookmarks = {
                "https://www.chrisatmachine.com/",
                "https://github.com/christianchiarulli",
                "https://github.com/rockerBOO/awesome-neovim",
                "https://doc.rust-lang.org/book/",
                "https://aur.archlinux.org/packages/",
                "https://www.bilibili.com",
                "https://www.google.com",
                "https://www.youtube.com",
                "https://www.bing.com",
                "https://markdown.com.cn/basic-syntax/",
                "https://atcode.jp",
                "https://blog,csdn.net",
                "https://leetcode.cn",
                "https://www.acwing.com",
                "https://luogu.com.cn",
                "https://zh.cppreference.com/w/cpp",
                "https://github.com/neovim/neovim",
                "https://neovim.discourse.group/",
            }

            local function command(name, rhs, opts)
                opts = opts or {}
                vim.api.nvim_create_user_command(name, rhs, opts)
            end

            command("BrowseInputSearch", function()
                browse.input_search()
            end, {})

            command("Browse", function()
                browse.browse { bookmarks = bookmarks }
            end, {})

            command("BrowseBookmarks", function()
                browse.open_bookmarks { bookmarks = bookmarks }
            end, {})

            command("BrowseDevdocsSearch", function()
                browse.devdocs.search()
            end, {})

            command("BrowseDevdocsFiletypeSearch", function()
                browse.devdocs.search_with_filetype()
            end, {})

            command("BrowseMdnSearch", function()
                browse.mdn.search()
            end, {})

            local opts = { noremap = true, silent = true }
            local keymap = vim.api.nvim_set_keymap
        end
    },


    { -- Search and Replace files
        "nvim-pack/nvim-spectre",
        build = false,
        cmd = "Spectre",
        opts = { open_cmd = "noswapfile vnew" },
    },

    { -- terminal
        "akinsho/toggleterm.nvim",
        lazy = true,
        event = { "VeryLazy" },
        config = function()
            require("toggleterm").setup()
        end
    },

    { -- Outline
        "stevearc/aerial.nvim",
        lazy = true,
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },
        config = function()
            require('aerial').setup({
                layout = {
                    min_width = 30,
                }
            })
        end
    },

    { -- Translator
        "voldikss/vim-translator",
        lazy = true,
        cmd = { "TranslateW" }

    },

}
