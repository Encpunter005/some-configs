local status_guard_ok, guard = pcall(require, "guard")
if not status_guard_ok then
    vim.notify("guard not found")
    return
end


local ft = require("guard.filetype")
ft('c'):fmt('clang-format')
    :lint("clang-tidy")
ft("cpp"):fmt('clang-format')
ft("lua"):fmt('lsp')
ft("python"):fmt("lsp")
    :lint("pylint")
ft("markdown"):fmt("prettier")
ft("jsonc"):fmt("prettier")

guard.setup({
    fmt_on_save = false,
    lsp_as_default_formatter = false,
})
