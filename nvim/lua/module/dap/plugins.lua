return {
  -- DAP
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    event = { "VeryLazy" },
    dependencies = {
      "mfussenegger/nvim-dap-python",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "ravenxrz/DAPInstall.nvim",
    },
  },
}
