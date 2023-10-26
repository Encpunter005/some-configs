local status_guard_ok, guard = pcall(require, "guard")
if not status_guard_ok then
    vim.notify("guard not found")
    return
end

local ft = require("guard.filetype")
ft("c" , "cpp"):fmt('clang-format')
    :lint("clang-tidy")
ft("lua"):fmt('lsp')
    :lint("luacheck")
ft("go"):fmt('gofumpt')
ft("python"):fmt("lsp")
    :lint("pylint")
ft("markdown" , "css" , "jsonc" , "js" , "html"):fmt("prettier")

guard.setup({
    fmt_on_save = false,
    lsp_as_default_formatter = true,
})
