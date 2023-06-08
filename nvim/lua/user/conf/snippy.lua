local status_ok, snippy = pcall(require, "snippy")
if not status_ok then
  vim.notify("snippy not found!")
  return
end


snippy.setup({
  mappings = {
    is = {
      ['<Tab>'] = 'expand_or_advance',
      ['<S-Tab>'] = 'previous',
    },
    nx = {
      ['<leader>x'] = 'cut-text',
    },
  },
})
