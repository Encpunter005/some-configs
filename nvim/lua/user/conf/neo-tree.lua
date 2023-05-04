local status_ok, neo = pcall(require , "neo-tree")

if not status_ok then
    vim.notify("neo not found!")
  return
end

neo.setup({
  filesystem = {
    bind_to_cwd = false,
    follow_current_file = true,
    use_libuv_file_watcher = true,
  },

  window = {
    width = 30,
    mappings = {
      ["<space>"] = "none",
    },
  },

  default_component_configs = {
    indent = {
      with_expanders = true,
      expander_collapsed = "",
      expander_expanded = "",
      expander_highlight = "NeoTreeExpander",
    },
  },
})
