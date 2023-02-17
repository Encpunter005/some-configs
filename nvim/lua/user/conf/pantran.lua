local pantran = require("pantran")
local actions = require("pantran.ui.actions")
local engines = require("pantran.engines")
local async = require("pantran.async")


pantran.setup({
  default_engine = "google",
  default_sources = "auto",
  default_target = "zh",
})
