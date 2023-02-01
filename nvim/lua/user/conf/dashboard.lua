local status_ok, dashboard = pcall(require, "dashboard")
if not status_ok then

  vim.notify("dashboard not found!")
  return
end



  dashboard.setup({
    theme = 'hyper',
    config = {
      week_header = {
       enable = true,
      },
      shortcut = {
        { desc = ' Update', group = '@property', action = 'PackerUpdate', key = 'u' },
        {
          desc = ' Files',
          group = 'Label',
          action = 'Telescope find_files',
          key = 'f',
        },
        {
          desc = ' rescentfiles',
          group = 'DiagnosticHint',
          action = 'Telescope oldfiles',
          key = 'r',
        },
        {
          desc = ' colorscheme',
          group = 'Number',
          action = 'Telescope colorscheme',
          key = 'c',
        },
      },
    },
  })



