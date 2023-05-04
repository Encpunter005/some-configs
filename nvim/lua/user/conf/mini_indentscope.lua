local status_ok, mini = pcall(require, "mini.indentscope")
if not status_ok then
    vim.notify("mini not found!")
  return
end

mini.setup({
  symbol = "│",
  options = { try_as_border = true },
  init = function()
    vim.api.nvim_create_autocmd("Filetype" , {
      pattern = { "help" , "alpha" , "lazy" , "mason" },
      callback = function()
        vim.b.miniindentscope_disable = true,
      end,
    })
  end,  
})
