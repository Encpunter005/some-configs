local status_ok, wilder = pcall(require, "wilder")
if not status_ok then
  vim.notify("wilder not found!")
end


wilder.setup({modes = {':', '/', '?'}})

wilder.set_option('renderer', wilder.popupmenu_renderer({
  pumblend = 20,
  highlighter = wilder.basic_highlighter(),
  left = {' ', wilder.popupmenu_devicons()},
  right = {' ', wilder.popupmenu_scrollbar()},
}))

