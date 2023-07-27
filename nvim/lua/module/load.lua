local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


local lazy = require("lazy")

lazy.setup({
  {import = "module/dap/plugins"},
  {import = "module/ui/plugins"},
  {import = "module/tool/plugins"},
  {import = "module/editor/plugins"}
})

require "module.ui"
require "module.editor"
require "module.tool"
require "module.dap"
require "module.icons"
