require("windows").setup({
	autowidth = {
		enable = false,
	},
	ignore = {
		buftype = { "quickfix" },
		filetype = {
			"neo-tree",
			"qf",
			"toggleterm",
			"alpha",
			"TelescopePrompt",
		},
	},
})
