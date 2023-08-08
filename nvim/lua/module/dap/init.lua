require("module.dap.dap-config")
-- require "module.dap.dap-java"
require("module.dap.dap-python")
require("module.dap.dap-cpp")
require("module.dap.dap-virtual-text")
require("module.dap.dap-ui")

local dap_install = require("dap-install")
dap_install.setup({
  installation_path = vim.fn.stdpath("data") .. "/dapinstall/",
})
