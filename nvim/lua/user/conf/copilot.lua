local status_ok, copilot = pcall(require, "copilot")
if not status_ok then
  return
end

copilot.setup {
  cmp = {
          enabled = true,
          method = "getCompletionsCycling",
  },
  filetypes = {
          ["dap-repl"] = false,
          ["big_file_disabled_ft"] = false,
          ["cpp"] = false,
  },
  suggestion = {enabled = false},
  panel = {enabled = false},
}
