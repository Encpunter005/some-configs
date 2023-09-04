local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    return
end

local setup = {
    plugins = {
        marks = false, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
            operators = false,                     -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = true,                        -- adds help for motions
            text_objects = false,                  -- help for text objects triggered after entering an operator
            windows = true,                        -- default bindings on <c-w>
            nav = true,                            -- misc bindings to work with windows
            z = false,                             -- bindings for folds, spelling and others prefixed with z
            g = false,                             -- bindings for prefixed with g
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
        scroll_up = "<c-u>", -- binding to scroll up inside the popup
    },
    window = {
        border = "rounded", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0,
    },
    layout = {
        height = { min = 4, max = 25 },                                        -- min and max height of the columns
        width = { min = 20, max = 50 },                                        -- min and max width of the columns
        spacing = 3,                                                           -- spacing between columns
        align = "left",                                                        -- align columns left, center or right
    },
    ignore_missing = true,                                                     -- enable this to hide mappings for which you didn't specify a label
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    show_help = true,                                                          -- show help message on the command line when the popup is visible
    triggers = "auto",                                                         -- automatically setup triggers
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
    mode = "n",  -- NORMAL mode
    prefix = "<Space>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}
local vopts = {
    mode = "v",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
}

local vmappings = {
    ["/"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment toggle" },
    ["r"] = { "<cmd>SnipRun<cr>", "SnipRun" },
    ["t"] = { "<cmd>TranslateW<cr>,", "Translate" },
}

local mappings = {
    ["a"] = { "<cmd>Alpha<cr>", "Welcome" },
    ["r"] = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    ["p"] = { "<cmd>Lazy<cr>", "Plugins" },
    -- ["b"] = {
    --   "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
    --   "Buffers",
    -- },
    ["e"] = { "<cmd>Neotree toggle<cr>", "Explorer" },
    -- ["w"] = { "<cmd>w!<CR>", "Save" },
    ["q"] = { "<cmd>q!<CR>", "Quit" },
    ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
    -- ["S"] = { "<cmd>SessionManager save_current_session<CR>", "Save session" },
    ["L"] = { "<cmd>Lazy<cr> ", "Lazy" },
    -- ["w"] = { "<cmd>lua print(require('window-picker').pick_window())<CR>" , "Picker a window"},
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
        S = { "<cmd>BrowseBookmarks<cr>", "BookMarkSearch" },
        w = { "<cmd>Pantran<CR>", "Sentences" },
        m = { "<cmd>MinimapToggle<cr>", "Show minimap window" },
    },
    -- p = {
    -- 	name = "Packer",
    -- 	c = { "<cmd>PackerCompile<cr>", "Compile" },
    -- 	i = { "<cmd>PackerInstall<cr>", "Install" },
    -- 	r = { "<cmd>lua require('lvim.plugin-loader').recompile()<cr>", "Re-compile" },
    -- 	s = { "<cmd>PackerSync<cr>", "Sync" },
    -- 	S = { "<cmd>PackerStatus<cr>", "Status" },
    -- 	u = { "<cmd>PackerUpdate<cr>", "Update" },
    -- },
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

    -- ["o"] = {
    --   "<cmd>AerialToggle<CR>", "Outline"
    -- },
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
        l = { "<cmd>Legendars<cr>", "Details of commends" },
        s = { "<cmd>lua require('telescope').extensions.media_files.media_files()<cr>", "Media" },
    },
    j = {
        name = "Hop",
        w = { "<cmd>HopWord<cr>", "Hop word" },
        W = { "<cmd>HopWordMW<cr>", "Hop word in multi-window" },
        c = { "<cmd>HopChar2<cr>", "Jump to a word" },
        C = { "<cmd>HopChar2MW<cr>", "Jump to a word int multi-window" },
        l = { "<cmd>Hopline<cr>", "Jump to a line" },
        L = { "<cmd>HoplineStart<cr>", "Jump to a line in the start" },
    },
    c = {
        name = "CMake",
        g = { "<cmd>CMake configure<CR>", "Configure" },
        t = { "<cmd>CMake select_target<CR>", "SelectTarget" },
        T = { "<cmd>CMake select_build_type<CR>", "SelectBuildType" },
        b = { "<cmd>CMake build<CR>", "BuildTarget" },
        a = { "<cmd>CMake build_all<CR>", "BuildAll" },
        r = { "<cmd>CMake build_and_run<CR>", "Run" },
        d = { "<cmd>CMake build_and_debug<CR>", "DebugTarget" },
        c = { "<cmd>CMake cancel<CR>", "Cancel" },
        C = { "<cmd>CMake create_project<CR>", "New Project" },
        s = { "<cmd>CMake set_target_args<CR>", "SetArg" },
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
        -- d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
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
        -- g = { "<cmd>Gitsigns setloclist<cr>", "Open changed hunk" },
    },

    b = {
        name = "Buffers",
        j = { "<cmd>BufferPick<cr>", "Jump" },
        f = { "<cmd>Telescope buffers<cr>", "Find" },
        b = { "<cmd>BufferPrevious<cr>", "Previous" },
        n = { "<cmd>BufferNext<cr>", "Next" },
        c = { "<cmd>BufferClose<cr>", "Close buffer" },
        D = {
            "<cmd>BufferOrderByDirectory<cr>",
            "Sort by directory",
        },
        L = {
            "<cmd>BufferSortByLanguage<cr>",
            "Sort by language",
        },
    },

    -- g = {
    --   name = "Git",
    --   b = { "<cmd>VGit buffer_gutter_blame_preview<cr>", "File Blame" },
    --   d = { "<cmd>VGit buffer_diff_preview<cr>", "Diff File" },
    --   D = { "<cmd>VGit project_diff_preview<cr>", "Diff Project" },
    --   s = { "<cmd>VGit buffer_stage<cr>", "Stage File" },
    --   u = { "<cmd>VGit buffer_unstage<cr>", "Unstage File" },
    --   r = { "<cmd>VGit buffer_reset<cr>", "Reset File" },
    --   f = { "<cmd>VGit buffer_history_preview <cr>", "Reset File" },
    --
    --   B = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    --   c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    -- },

    g = {
        name = "Git",
        -- g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
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

    -- R = {
    --     name = "Replace",
    --     s = { "<CMD>SearchReplaceSingleBufferSelections<CR>", "SearchReplaceSingleBuffer [s]elction list" },
    --     o = { "<CMD>SearchReplaceSingleBufferOpen<CR>", "[o]pen" },
    --     w = { "<CMD>SearchReplaceSingleBufferCWord<CR>", "[w]ord" },
    --     W = { "<CMD>SearchReplaceSingleBufferCWORD<CR>", "[W]ORD" },
    --     e = { "<CMD>SearchReplaceSingleBufferCExpr<CR>", "[e]xpr" },
    --     f = { "<CMD>SearchReplaceSingleBufferCFile<CR>", "[f]ile" },
    --     b = {
    --         name = "SearchReplaceMultiBuffer",
    --         s = { "<CMD>SearchReplaceMultiBufferSelections<CR>", "SearchReplaceMultiBuffer [s]elction list" },
    --         o = { "<CMD>SearchReplaceMultiBufferOpen<CR>", "[o]pen" },
    --         w = { "<CMD>SearchReplaceMultiBufferCWord<CR>", "[w]ord" },
    --         W = { "<CMD>SearchReplaceMultiBufferCWORD<CR>", "[W]ORD" },
    --         e = { "<CMD>SearchReplaceMultiBufferCExpr<CR>", "[e]xpr" },
    --         f = { "<CMD>SearchReplaceMultiBufferCFile<CR>", "[f]ile" },
    --     },
    -- },
    S = {
        name = "Spectre",
        o = { "<cmd>lua require('spectre').open()<cr>", "Spectre Open" },
        w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Spectre in Visual Word" },
        v = { "<esc><cmd>lua require('spectre').open_visual()<CR>", "Spectre in Visual" },
        f = { "viw<cmd>lua require('spectre').open_file_search()<CR>", "Spectre in File" },
    },

    l = {
        name = "LSP",
        a = { "<cmd>CodeActionMenu<CR>", "Code Action" },
        d = {
            "<cmd>Telescope diagnostics<cr>",
            "Diagnostics",
        },
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
        K = { "<cmd>Lspsaga hover_doc<CR>", "Signature" },
        r = { "<cmd>Lspsaga rename<CR>", "Rename" },
        s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
        p = { "<cmd>Lspsaga peek_definition<CR>", "Peek_definition" },
        g = { "<Cmd>lua vim.lsp.buf.declaration()<CR>", "Go to definition" },
        F = { "<cmd>Lspsaga lsp_finder<CR>", "Reference" },
        h = { "<cmd>Lspsaga incoming_calls<CR>", "Show function incoming_calls" },
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
    -- h = {
    --   a = { "<cmd>HSHighlight 1<cr>", "Hightlight 1" },
    --   b = { "<cmd>HSHighlight 2<cr>", "Hightlight 2" },
    --   c = { "<cmd>HSHighlight 3<cr>", "Hightlight 3" },
    --   d = { "<cmd>HSHighlight 4<cr>", "Hightlight 4" },
    --   e = { "<cmd>HSHighlight 5<cr>", "Hightlight 5" },
    --   f = { "<cmd>HSHighlight 6<cr>", "Hightlight 6" },
    --   u = { "<cmd>HSRmHighlight<cr>", "RemoveHighlight" },
    --   U = { "<cmd>HSRmHighlight rm_all<cr>", "RemoveAllHighlight" },
    -- },
    -- t = {
    --   name = "Terminal",
    --   n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
    --   u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
    --   t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
    --   p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
    --   f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
    --   h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
    --   v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
    -- },
    u = {
        name = "UFO",
        u = { "<cmd>UfoEnableFold<CR>", "Open Fold" },
        f = { "<cmd>UfoDisableFold<CR>", "Close Fold" },
    },
}

which_key.setup(setup)
which_key.register(mappings, opts)
which_key.register(vmappings, vopts)
