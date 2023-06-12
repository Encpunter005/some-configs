local status_ok, neo = pcall(require, "neo-tree")

if not status_ok then
	vim.notify("neo not found!")
	return
end

neo.setup({
	close_if_last_window = true,
	popup_border_style = "rounded",
	enable_git_status = true,
	enable_diagnostics = true,
	window = {
		width = 30,
		mappings = {
			["<space>"] = "none",
			["a"] = {
				"add",
				-- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
				-- some commands may take optional config options, see `:h neo-tree-mappings` for details
				config = {
					show_path = "relative", -- "none", "relative", "absolute"
				},
			},
			["<bs>"] = "navigate_up",
			["/"] = "fuzzy_finder",
			["D"] = "fuzzy_finder_directory",
			fuzzy_finder_mappings = {
				-- define keymaps for filter popup window in fuzzy_finder_mode
				["<down>"] = "<C-Left>",
				["<up>"] = "<C-Right>",
			},
		},
	},
	default_component_configs = {
		indent = {
			indent_size = 1,
			with_expanders = true,
			expander_collapsed = "",
			expander_expanded = "",
			expander_highlight = "NeoTreeExpander",
			indent_marker = "│",
			last_indent_marker = "└",
			highlight = "NeoTreeIndentMarker",
		},
	},
	source_selector = {
		winbar = true,
		-- statusline = true,
		show_scrolled_off_parent_node = false, -- this will replace the tabs with the parent path
		-- of the top visible node when scrolled down.
	},
	filesystem = {
		visible = true,
		hide_dotfiles = false,
		hide_hidden = false,
		hide_gitignored = true,
		bind_to_cwd = false,
		follow_current_file = true,
		use_libuv_file_watcher = true,
	},
})
