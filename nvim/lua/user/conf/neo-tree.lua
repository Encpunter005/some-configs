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

  source_selector = {
    winbar = true,
    -- statusline = true,
    show_scrolled_off_parent_node = false, -- this will replace the tabs with the parent path
                                           -- of the top visible node when scrolled down.
  },

  close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab

})
