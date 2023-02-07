
local status_ok, lspsaga = pcall(require, "lspsaga")
if not status_ok then
  vim.notify("lspsaga not found")
  return
end



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
        border = "solid",
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
