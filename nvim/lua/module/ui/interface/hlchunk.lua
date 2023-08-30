local status_ok, hlchunk = pcall(require, "hlchunk")
if not status_ok then
    vim.notify("hlchunk not found!")
    return
end

hlchunk.setup({

    chunk = {
        enable = true,
        notify = false,
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
        enable = false,
    },

    line_num = {
        enable = true,
        use_treesitter = false,
        style = "#806d9c",
    },

    blank = {
        enable = false,
    },
})
